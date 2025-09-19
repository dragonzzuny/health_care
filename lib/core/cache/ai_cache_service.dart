import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';
import 'package:path_provider/path_provider.dart';

/// AI 응답 결과를 위한 고성능 캐싱 서비스
/// 메모리, 디스크, 네트워크 캐시를 계층적으로 관리하여 성능 최적화
class AICacheService {
  final Logger _logger = Logger();
  
  // 3계층 캐싱 구조
  final Map<String, CacheEntry> _memoryCache = {}; // L1: 메모리 캐시
  SharedPreferences? _preferences; // L2: 로컬 스토리지 캐시
  Directory? _diskCacheDir; // L3: 디스크 파일 캐시

  // 캐시 설정
  static const int _maxMemoryCacheSize = 50; // 메모리 캐시 최대 항목 수
  static const int _maxDiskCacheSizeMB = 100; // 디스크 캐시 최대 크기 (MB)
  static const Duration _defaultCacheDuration = Duration(hours: 6);
  
  // 캐시 통계
  int _memoryHits = 0;
  int _diskHits = 0;
  int _misses = 0;

  /// 캐시 서비스 초기화
  Future<void> initialize() async {
    try {
      _logger.i('Initializing AI cache service');
      
      // SharedPreferences 초기화
      _preferences = await SharedPreferences.getInstance();
      
      // 디스크 캐시 디렉토리 설정
      final appDir = await getApplicationDocumentsDirectory();
      _diskCacheDir = Directory('${appDir.path}/ai_cache');
      
      if (!await _diskCacheDir!.exists()) {
        await _diskCacheDir!.create(recursive: true);
      }
      
      // 시작시 캐시 정리
      await _cleanupExpiredCache();
      await _enforceCacheSizeLimit();
      
      _logger.i('AI cache service initialized successfully');
    } catch (e) {
      _logger.e('Error initializing cache service: $e');
      rethrow;
    }
  }

  /// 캐시에서 데이터 조회
  /// [key] 캐시 키
  /// 반환: 캐시된 데이터 또는 null
  Future<Map<String, dynamic>?> get(String key) async {
    try {
      final cacheKey = _generateCacheKey(key);
      
      // L1: 메모리 캐시 확인
      final memoryResult = _getFromMemoryCache(cacheKey);
      if (memoryResult != null) {
        _memoryHits++;
        _logger.d('Cache hit (memory): $key');
        return memoryResult;
      }
      
      // L2: 로컬 스토리지 캐시 확인
      final storageResult = await _getFromStorageCache(cacheKey);
      if (storageResult != null) {
        _diskHits++;
        _logger.d('Cache hit (storage): $key');
        
        // 메모리 캐시에도 저장 (캐시 승격)
        _setToMemoryCache(cacheKey, storageResult, _defaultCacheDuration);
        return storageResult;
      }
      
      // L3: 디스크 파일 캐시 확인
      final diskResult = await _getFromDiskCache(cacheKey);
      if (diskResult != null) {
        _diskHits++;
        _logger.d('Cache hit (disk): $key');
        
        // 상위 레벨 캐시에 승격
        _setToMemoryCache(cacheKey, diskResult, _defaultCacheDuration);
        await _setToStorageCache(cacheKey, diskResult, _defaultCacheDuration);
        return diskResult;
      }
      
      _misses++;
      _logger.d('Cache miss: $key');
      return null;
      
    } catch (e) {
      _logger.e('Error getting from cache: $e');
      return null;
    }
  }

  /// 캐시에 데이터 저장
  /// [key] 캐시 키
  /// [data] 저장할 데이터
  /// [duration] 캐시 유지 기간
  Future<void> set(
    String key,
    Map<String, dynamic> data, {
    Duration duration = _defaultCacheDuration,
  }) async {
    try {
      final cacheKey = _generateCacheKey(key);
      _logger.d('Setting cache: $key (duration: ${duration.inMinutes}min)');
      
      // 모든 레벨에 저장
      _setToMemoryCache(cacheKey, data, duration);
      await _setToStorageCache(cacheKey, data, duration);
      await _setToDiskCache(cacheKey, data, duration);
      
      // 캐시 크기 제한 적용
      await _enforceCacheSizeLimit();
      
    } catch (e) {
      _logger.e('Error setting cache: $e');
    }
  }

  /// 특정 키의 캐시 삭제
  Future<void> remove(String key) async {
    try {
      final cacheKey = _generateCacheKey(key);
      _logger.d('Removing from cache: $key');
      
      // 모든 레벨에서 삭제
      _memoryCache.remove(cacheKey);
      await _preferences?.remove(cacheKey);
      
      final diskFile = File('${_diskCacheDir!.path}/$cacheKey.json');
      if (await diskFile.exists()) {
        await diskFile.delete();
      }
      
    } catch (e) {
      _logger.e('Error removing from cache: $e');
    }
  }

  /// 특정 패턴의 캐시들 삭제
  /// [pattern] 삭제할 키 패턴 (예: 'diet_', 'exercise_')
  Future<void> removeByPattern(String pattern) async {
    try {
      _logger.i('Removing cache entries with pattern: $pattern');
      
      // 메모리 캐시에서 패턴 매칭 삭제
      final memoryKeysToRemove = _memoryCache.keys
          .where((key) => key.contains(pattern))
          .toList();
      
      for (final key in memoryKeysToRemove) {
        _memoryCache.remove(key);
      }
      
      // SharedPreferences에서 패턴 매칭 삭제
      final allKeys = _preferences?.getKeys() ?? <String>{};
      for (final key in allKeys) {
        if (key.contains(pattern)) {
          await _preferences?.remove(key);
        }
      }
      
      // 디스크 캐시에서 패턴 매칭 삭제
      if (_diskCacheDir != null && await _diskCacheDir!.exists()) {
        final files = await _diskCacheDir!.list().toList();
        for (final file in files) {
          if (file.path.contains(pattern)) {
            await file.delete();
          }
        }
      }
      
      _logger.i('Removed ${memoryKeysToRemove.length} cache entries');
    } catch (e) {
      _logger.e('Error removing cache by pattern: $e');
    }
  }

  /// 사용자별 캐시 삭제
  Future<void> clearUserCache(String userId) async {
    await removeByPattern('user_$userId');
  }

  /// 특정 기능별 캐시 삭제
  Future<void> clearFeatureCache(String feature) async {
    await removeByPattern('ai_${feature}_');
  }

  /// 전체 캐시 삭제
  Future<void> clearAll() async {
    try {
      _logger.i('Clearing all cache');
      
      _memoryCache.clear();
      await _preferences?.clear();
      
      if (_diskCacheDir != null && await _diskCacheDir!.exists()) {
        await _diskCacheDir!.delete(recursive: true);
        await _diskCacheDir!.create(recursive: true);
      }
      
      // 통계 초기화
      _memoryHits = 0;
      _diskHits = 0;
      _misses = 0;
      
    } catch (e) {
      _logger.e('Error clearing all cache: $e');
    }
  }

  /// 캐시 통계 조회
  CacheStatistics getStatistics() {
    final totalRequests = _memoryHits + _diskHits + _misses;
    final hitRate = totalRequests > 0 
        ? ((_memoryHits + _diskHits) / totalRequests * 100)
        : 0.0;

    return CacheStatistics(
      memoryHits: _memoryHits,
      diskHits: _diskHits,
      misses: _misses,
      hitRate: hitRate,
      memoryCacheSize: _memoryCache.length,
      diskCacheSize: _getDiskCacheSize(),
    );
  }

  /// 캐시 상태 진단
  Future<CacheHealthReport> getDiagnostics() async {
    try {
      final stats = getStatistics();
      final expiredCount = await _countExpiredEntries();
      final diskSizeMB = await _calculateDiskCacheSize();
      
      return CacheHealthReport(
        statistics: stats,
        expiredEntries: expiredCount,
        diskUsageMB: diskSizeMB,
        memoryUsageKB: _estimateMemoryUsage(),
        recommendations: _generateRecommendations(stats, diskSizeMB),
      );
    } catch (e) {
      _logger.e('Error generating cache diagnostics: $e');
      return CacheHealthReport.error(e.toString());
    }
  }

  // ========== 내부 메서드들 ==========

  String _generateCacheKey(String key) {
    // SHA-256 해시를 사용하여 안전하고 고정 길이의 키 생성
    final bytes = utf8.encode(key);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Map<String, dynamic>? _getFromMemoryCache(String key) {
    final entry = _memoryCache[key];
    if (entry == null || entry.isExpired) {
      if (entry?.isExpired == true) {
        _memoryCache.remove(key);
      }
      return null;
    }
    
    // 액세스 시간 업데이트 (LRU를 위해)
    entry.lastAccessed = DateTime.now();
    return entry.data;
  }

  void _setToMemoryCache(
    String key,
    Map<String, dynamic> data,
    Duration duration,
  ) {
    // 메모리 캐시 크기 제한 확인
    if (_memoryCache.length >= _maxMemoryCacheSize) {
      _evictLeastRecentlyUsed();
    }
    
    _memoryCache[key] = CacheEntry(
      data: data,
      expiry: DateTime.now().add(duration),
      lastAccessed: DateTime.now(),
    );
  }

  Future<Map<String, dynamic>?> _getFromStorageCache(String key) async {
    try {
      final jsonString = _preferences?.getString(key);
      if (jsonString == null) return null;
      
      final cacheData = jsonDecode(jsonString) as Map<String, dynamic>;
      final expiry = DateTime.parse(cacheData['expiry']);
      
      if (DateTime.now().isAfter(expiry)) {
        await _preferences?.remove(key);
        return null;
      }
      
      return cacheData['data'] as Map<String, dynamic>;
    } catch (e) {
      _logger.w('Error reading from storage cache: $e');
      return null;
    }
  }

  Future<void> _setToStorageCache(
    String key,
    Map<String, dynamic> data,
    Duration duration,
  ) async {
    try {
      final cacheData = {
        'data': data,
        'expiry': DateTime.now().add(duration).toIso8601String(),
        'created': DateTime.now().toIso8601String(),
      };
      
      await _preferences?.setString(key, jsonEncode(cacheData));
    } catch (e) {
      _logger.w('Error writing to storage cache: $e');
    }
  }

  Future<Map<String, dynamic>?> _getFromDiskCache(String key) async {
    try {
      final file = File('${_diskCacheDir!.path}/$key.json');
      if (!await file.exists()) return null;
      
      final content = await file.readAsString();
      final cacheData = jsonDecode(content) as Map<String, dynamic>;
      final expiry = DateTime.parse(cacheData['expiry']);
      
      if (DateTime.now().isAfter(expiry)) {
        await file.delete();
        return null;
      }
      
      return cacheData['data'] as Map<String, dynamic>;
    } catch (e) {
      _logger.w('Error reading from disk cache: $e');
      return null;
    }
  }

  Future<void> _setToDiskCache(
    String key,
    Map<String, dynamic> data,
    Duration duration,
  ) async {
    try {
      final cacheData = {
        'data': data,
        'expiry': DateTime.now().add(duration).toIso8601String(),
        'created': DateTime.now().toIso8601String(),
        'size': jsonEncode(data).length,
      };
      
      final file = File('${_diskCacheDir!.path}/$key.json');
      await file.writeAsString(jsonEncode(cacheData));
    } catch (e) {
      _logger.w('Error writing to disk cache: $e');
    }
  }

  void _evictLeastRecentlyUsed() {
    if (_memoryCache.isEmpty) return;
    
    String? oldestKey;
    DateTime? oldestAccess;
    
    for (final entry in _memoryCache.entries) {
      if (oldestAccess == null || entry.value.lastAccessed.isBefore(oldestAccess)) {
        oldestAccess = entry.value.lastAccessed;
        oldestKey = entry.key;
      }
    }
    
    if (oldestKey != null) {
      _memoryCache.remove(oldestKey);
      _logger.d('Evicted LRU cache entry: $oldestKey');
    }
  }

  Future<void> _cleanupExpiredCache() async {
    try {
      _logger.i('Cleaning up expired cache entries');
      
      // 메모리 캐시 정리
      final expiredMemoryKeys = _memoryCache.entries
          .where((entry) => entry.value.isExpired)
          .map((entry) => entry.key)
          .toList();
      
      for (final key in expiredMemoryKeys) {
        _memoryCache.remove(key);
      }
      
      // SharedPreferences 정리
      final allKeys = _preferences?.getKeys() ?? <String>{};
      for (final key in allKeys) {
        final jsonString = _preferences?.getString(key);
        if (jsonString != null) {
          try {
            final cacheData = jsonDecode(jsonString) as Map<String, dynamic>;
            final expiry = DateTime.parse(cacheData['expiry']);
            if (DateTime.now().isAfter(expiry)) {
              await _preferences?.remove(key);
            }
          } catch (e) {
            // 잘못된 형식의 데이터 삭제
            await _preferences?.remove(key);
          }
        }
      }
      
      // 디스크 캐시 정리
      if (_diskCacheDir != null && await _diskCacheDir!.exists()) {
        final files = await _diskCacheDir!.list().toList();
        for (final file in files) {
          if (file is File && file.path.endsWith('.json')) {
            try {
              final content = await file.readAsString();
              final cacheData = jsonDecode(content) as Map<String, dynamic>;
              final expiry = DateTime.parse(cacheData['expiry']);
              if (DateTime.now().isAfter(expiry)) {
                await file.delete();
              }
            } catch (e) {
              // 잘못된 파일 삭제
              await file.delete();
            }
          }
        }
      }
      
      _logger.i('Cache cleanup completed. Removed ${expiredMemoryKeys.length} memory entries');
    } catch (e) {
      _logger.e('Error during cache cleanup: $e');
    }
  }

  Future<void> _enforceCacheSizeLimit() async {
    try {
      final diskSizeMB = await _calculateDiskCacheSize();
      
      if (diskSizeMB > _maxDiskCacheSizeMB) {
        _logger.w('Disk cache size ($diskSizeMB MB) exceeds limit ($_maxDiskCacheSizeMB MB)');
        await _reduceDiscCacheSize();
      }
    } catch (e) {
      _logger.e('Error enforcing cache size limit: $e');
    }
  }

  Future<void> _reduceDiscCacheSize() async {
    try {
      if (_diskCacheDir == null || !await _diskCacheDir!.exists()) return;
      
      final files = await _diskCacheDir!.list().toList();
      final fileInfos = <FileInfo>[];
      
      // 파일 정보 수집
      for (final file in files) {
        if (file is File && file.path.endsWith('.json')) {
          final stat = await file.stat();
          final content = await file.readAsString();
          final cacheData = jsonDecode(content) as Map<String, dynamic>;
          final created = DateTime.parse(cacheData['created']);
          
          fileInfos.add(FileInfo(
            file: file,
            size: stat.size,
            created: created,
          ));
        }
      }
      
      // 오래된 파일부터 정렬
      fileInfos.sort((a, b) => a.created.compareTo(b.created));
      
      // 크기 제한까지 파일 삭제
      int currentSize = fileInfos.fold(0, (sum, info) => sum + info.size);
      const targetSize = _maxDiskCacheSizeMB * 1024 * 1024 * 0.8; // 80%까지 감소
      
      for (final info in fileInfos) {
        if (currentSize <= targetSize) break;
        
        await info.file.delete();
        currentSize -= info.size;
      }
      
      _logger.i('Reduced disk cache size to ${(currentSize / 1024 / 1024).toStringAsFixed(1)} MB');
    } catch (e) {
      _logger.e('Error reducing disk cache size: $e');
    }
  }

  Future<double> _calculateDiskCacheSize() async {
    try {
      if (_diskCacheDir == null || !await _diskCacheDir!.exists()) return 0.0;
      
      final files = await _diskCacheDir!.list().toList();
      int totalSize = 0;
      
      for (final file in files) {
        if (file is File) {
          final stat = await file.stat();
          totalSize += stat.size;
        }
      }
      
      return totalSize / 1024 / 1024; // MB로 변환
    } catch (e) {
      _logger.e('Error calculating disk cache size: $e');
      return 0.0;
    }
  }

  int _getDiskCacheSize() {
    // 근사치 계산 (실제 파일 개수)
    return _diskCacheDir?.listSync().length ?? 0;
  }

  double _estimateMemoryUsage() {
    double totalSize = 0;
    for (final entry in _memoryCache.values) {
      totalSize += jsonEncode(entry.data).length;
    }
    return totalSize / 1024; // KB로 변환
  }

  Future<int> _countExpiredEntries() async {
    int count = 0;
    
    // 메모리 캐시
    count += _memoryCache.values.where((entry) => entry.isExpired).length;
    
    // SharedPreferences (간단히 추정)
    final allKeys = _preferences?.getKeys() ?? <String>{};
    for (final key in allKeys.take(10)) { // 샘플링
      final jsonString = _preferences?.getString(key);
      if (jsonString != null) {
        try {
          final cacheData = jsonDecode(jsonString) as Map<String, dynamic>;
          final expiry = DateTime.parse(cacheData['expiry']);
          if (DateTime.now().isAfter(expiry)) count++;
        } catch (e) {
          count++;
        }
      }
    }
    
    return count;
  }

  List<String> _generateRecommendations(CacheStatistics stats, double diskSizeMB) {
    final recommendations = <String>[];
    
    if (stats.hitRate < 50) {
      recommendations.add('캐시 히트율이 낮습니다. 캐시 키 전략을 검토하세요.');
    }
    
    if (diskSizeMB > _maxDiskCacheSizeMB * 0.8) {
      recommendations.add('디스크 캐시 사용량이 높습니다. 정리를 고려하세요.');
    }
    
    if (stats.memoryCacheSize >= _maxMemoryCacheSize * 0.9) {
      recommendations.add('메모리 캐시가 거의 가득찼습니다.');
    }
    
    if (recommendations.isEmpty) {
      recommendations.add('캐시 상태가 양호합니다.');
    }
    
    return recommendations;
  }
}

/// 캐시 엔트리 클래스
class CacheEntry {
  final Map<String, dynamic> data;
  final DateTime expiry;
  DateTime lastAccessed;

  CacheEntry({
    required this.data,
    required this.expiry,
    required this.lastAccessed,
  });

  bool get isExpired => DateTime.now().isAfter(expiry);
}

/// 파일 정보 클래스
class FileInfo {
  final File file;
  final int size;
  final DateTime created;

  FileInfo({
    required this.file,
    required this.size,
    required this.created,
  });
}

/// 캐시 통계 클래스
class CacheStatistics {
  final int memoryHits;
  final int diskHits;
  final int misses;
  final double hitRate;
  final int memoryCacheSize;
  final int diskCacheSize;

  CacheStatistics({
    required this.memoryHits,
    required this.diskHits,
    required this.misses,
    required this.hitRate,
    required this.memoryCacheSize,
    required this.diskCacheSize,
  });

  int get totalHits => memoryHits + diskHits;
  int get totalRequests => totalHits + misses;
}

/// 캐시 상태 진단 보고서
class CacheHealthReport {
  final CacheStatistics statistics;
  final int expiredEntries;
  final double diskUsageMB;
  final double memoryUsageKB;
  final List<String> recommendations;
  final String? error;

  CacheHealthReport({
    required this.statistics,
    required this.expiredEntries,
    required this.diskUsageMB,
    required this.memoryUsageKB,
    required this.recommendations,
    this.error,
  });

  CacheHealthReport.error(String errorMessage)
      : statistics = CacheStatistics(
          memoryHits: 0,
          diskHits: 0,
          misses: 0,
          hitRate: 0,
          memoryCacheSize: 0,
          diskCacheSize: 0,
        ),
        expiredEntries = 0,
        diskUsageMB = 0,
        memoryUsageKB = 0,
        recommendations = [],
        error = errorMessage;

  bool get isHealthy => error == null && statistics.hitRate > 50;
}

// Riverpod Provider
final aiCacheServiceProvider = Provider<AICacheService>((ref) {
  final service = AICacheService();
  // 앱 시작시 초기화
  service.initialize();
  return service;
});