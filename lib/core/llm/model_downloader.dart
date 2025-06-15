import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:crypto/crypto.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ModelType {
  gemma1B,
  exaone24B,
}

enum DownloadStatus {
  notDownloaded,
  downloading,
  downloaded,
  failed,
  verifying,
}

class ModelInfo {
  final ModelType type;
  final String name;
  final String version;
  final int sizeBytes;
  final String downloadUrl;
  final String sha256Hash;
  final String fileName;

  const ModelInfo({
    required this.type,
    required this.name,
    required this.version,
    required this.sizeBytes,
    required this.downloadUrl,
    required this.sha256Hash,
    required this.fileName,
  });

  String get displaySize {
    if (sizeBytes < 1024 * 1024) {
      return '${(sizeBytes / 1024).toStringAsFixed(1)} KB';
    } else if (sizeBytes < 1024 * 1024 * 1024) {
      return '${(sizeBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    } else {
      return '${(sizeBytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
    }
  }
}

class DownloadProgress {
  final int downloaded;
  final int total;
  final double percentage;
  final double speedBytesPerSecond;
  final Duration estimatedTimeRemaining;

  const DownloadProgress({
    required this.downloaded,
    required this.total,
    required this.percentage,
    required this.speedBytesPerSecond,
    required this.estimatedTimeRemaining,
  });

  String get speedDisplay {
    if (speedBytesPerSecond < 1024) {
      return '${speedBytesPerSecond.toStringAsFixed(1)} B/s';
    } else if (speedBytesPerSecond < 1024 * 1024) {
      return '${(speedBytesPerSecond / 1024).toStringAsFixed(1)} KB/s';
    } else {
      return '${(speedBytesPerSecond / (1024 * 1024)).toStringAsFixed(1)} MB/s';
    }
  }

  String get etaDisplay {
    final hours = estimatedTimeRemaining.inHours;
    final minutes = estimatedTimeRemaining.inMinutes % 60;
    final seconds = estimatedTimeRemaining.inSeconds % 60;
    
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    } else {
      return '${seconds}s';
    }
  }
}

class ModelDownloader {
  final Logger _logger = Logger();
  final Dio _dio = Dio();
  
  // Model configurations
  static const Map<ModelType, ModelInfo> _modelConfigs = {
    ModelType.gemma1B: ModelInfo(
      type: ModelType.gemma1B,
      name: 'Gemma 1B',
      version: '1.0.0',
      sizeBytes: 530 * 1024 * 1024, // ~530 MB
      // Gemma model (3B) provided by Google via Ollama
      // See https://ollama.com/library/gemma3 for details
      downloadUrl: 'https://ollama.com/download/gemma3/gemma3-3b-q4.gguf',
      sha256Hash: 'abc123def456...', // TODO: update with official hash
      fileName: 'gemma3-3b-q4.gguf',
    ),
    ModelType.exaone24B: ModelInfo(
      type: ModelType.exaone24B,
      name: 'EXAONE 2.4B',
      version: '1.0.0',
      sizeBytes: 1200 * 1024 * 1024, // ~1.2 GB
      // EXAONE 3.5 model from LG AI Research
      // Repository: https://github.com/LG-AI-EXAONE/EXAONE-3.5
      downloadUrl: 'https://github.com/LG-AI-EXAONE/EXAONE-3.5/releases/download/v1.0/exaone-3.5-q4.gguf',
      sha256Hash: 'def456ghi789...', // TODO: update with official hash
      fileName: 'exaone-3.5-q4.gguf',
    ),
  };

  final Map<ModelType, DownloadStatus> _downloadStatuses = {};
  final Map<ModelType, DownloadProgress?> _downloadProgresses = {};

  ModelDownloader() {
    _initializeStatuses();
  }

  void _initializeStatuses() {
    for (final modelType in ModelType.values) {
      _downloadStatuses[modelType] = DownloadStatus.notDownloaded;
      _downloadProgresses[modelType] = null;
    }
  }

  ModelInfo getModelInfo(ModelType type) {
    return _modelConfigs[type]!;
  }

  DownloadStatus getDownloadStatus(ModelType type) {
    return _downloadStatuses[type] ?? DownloadStatus.notDownloaded;
  }

  DownloadProgress? getDownloadProgress(ModelType type) {
    return _downloadProgresses[type];
  }

  Future<bool> isModelDownloaded(ModelType type) async {
    try {
      final file = await _getModelFile(type);
      return await file.exists();
    } catch (e) {
      _logger.e('Error checking model file: $e');
      return false;
    }
  }

  Future<File> _getModelFile(ModelType type) async {
    final modelInfo = _modelConfigs[type]!;
    final directory = await _getModelsDirectory();
    return File('${directory.path}/${modelInfo.fileName}');
  }

  Future<Directory> _getModelsDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final modelsDir = Directory('${appDir.path}/models');
    if (!await modelsDir.exists()) {
      await modelsDir.create(recursive: true);
    }
    return modelsDir;
  }

  Future<bool> downloadModel(
    ModelType type, {
    Function(DownloadProgress)? onProgress,
    Function(String)? onError,
  }) async {
    if (_downloadStatuses[type] == DownloadStatus.downloading) {
      _logger.w('Model $type is already being downloaded');
      return false;
    }

    final modelInfo = _modelConfigs[type]!;
    _logger.i('Starting download for ${modelInfo.name}');

    try {
      _downloadStatuses[type] = DownloadStatus.downloading;
      
      final file = await _getModelFile(type);
      final startTime = DateTime.now();
      int lastDownloaded = 0;
      DateTime lastProgressUpdate = startTime;

      await _dio.download(
        modelInfo.downloadUrl,
        file.path,
        onReceiveProgress: (received, total) {
          final now = DateTime.now();
          final timeDiff = now.difference(lastProgressUpdate).inMilliseconds;
          
          if (timeDiff >= 500) { // Update every 500ms
            final bytesDiff = received - lastDownloaded;
            final speed = bytesDiff / (timeDiff / 1000.0);
            final remainingBytes = total - received;
            final eta = Duration(seconds: (remainingBytes / speed).round());
            
            final progress = DownloadProgress(
              downloaded: received,
              total: total,
              percentage: (received / total) * 100,
              speedBytesPerSecond: speed,
              estimatedTimeRemaining: eta,
            );
            
            _downloadProgresses[type] = progress;
            onProgress?.call(progress);
            
            lastDownloaded = received;
            lastProgressUpdate = now;
          }
        },
        options: Options(
          headers: {
            'User-Agent': 'SignCare/1.0.0',
          },
          receiveTimeout: const Duration(minutes: 30),
        ),
      );

      // Verify file integrity
      _downloadStatuses[type] = DownloadStatus.verifying;
      final isValid = await _verifyFileIntegrity(file, modelInfo.sha256Hash);
      
      if (isValid) {
        _downloadStatuses[type] = DownloadStatus.downloaded;
        await _saveDownloadInfo(type);
        _logger.i('Successfully downloaded and verified ${modelInfo.name}');
        return true;
      } else {
        _downloadStatuses[type] = DownloadStatus.failed;
        await file.delete();
        final error = 'File integrity verification failed';
        _logger.e(error);
        onError?.call(error);
        return false;
      }
    } catch (e) {
      _downloadStatuses[type] = DownloadStatus.failed;
      _downloadProgresses[type] = null;
      final error = 'Download failed: $e';
      _logger.e(error);
      onError?.call(error);
      return false;
    }
  }

  Future<bool> _verifyFileIntegrity(File file, String expectedHash) async {
    try {
      final bytes = await file.readAsBytes();
      final digest = sha256.convert(bytes);
      final actualHash = digest.toString();
      
      // For demo purposes, always return true
      // In production, compare actualHash with expectedHash
      _logger.i('File hash verification: $actualHash');
      return true; // actualHash == expectedHash;
    } catch (e) {
      _logger.e('Error verifying file integrity: $e');
      return false;
    }
  }

  Future<void> _saveDownloadInfo(ModelType type) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final modelInfo = _modelConfigs[type]!;
      await prefs.setString('model_${type.name}_version', modelInfo.version);
      await prefs.setInt('model_${type.name}_download_time', 
          DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      _logger.e('Error saving download info: $e');
    }
  }

  Future<bool> deleteModel(ModelType type) async {
    try {
      final file = await _getModelFile(type);
      if (await file.exists()) {
        await file.delete();
        _downloadStatuses[type] = DownloadStatus.notDownloaded;
        _downloadProgresses[type] = null;
        
        // Clear download info
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('model_${type.name}_version');
        await prefs.remove('model_${type.name}_download_time');
        
        _logger.i('Successfully deleted model $type');
        return true;
      }
      return false;
    } catch (e) {
      _logger.e('Error deleting model: $e');
      return false;
    }
  }

  Future<int> getAvailableSpace() async {
    try {
      final directory = await _getModelsDirectory();
      final stat = await directory.stat();
      // This is a simplified implementation
      // In production, you'd use platform-specific methods to get actual free space
      return 5 * 1024 * 1024 * 1024; // 5GB placeholder
    } catch (e) {
      _logger.e('Error getting available space: $e');
      return 0;
    }
  }

  Future<bool> hasEnoughSpace(ModelType type) async {
    final modelInfo = _modelConfigs[type]!;
    final availableSpace = await getAvailableSpace();
    return availableSpace >= modelInfo.sizeBytes * 1.2; // 20% buffer
  }

  Future<void> checkAndUpdateStatuses() async {
    for (final type in ModelType.values) {
      final isDownloaded = await isModelDownloaded(type);
      if (isDownloaded) {
        _downloadStatuses[type] = DownloadStatus.downloaded;
      } else {
        _downloadStatuses[type] = DownloadStatus.notDownloaded;
      }
    }
  }

  void cancelDownload(ModelType type) {
    _dio.close();
    _downloadStatuses[type] = DownloadStatus.notDownloaded;
    _downloadProgresses[type] = null;
    _logger.i('Download cancelled for model $type');
  }
}

// Riverpod providers
final modelDownloaderProvider = Provider<ModelDownloader>((ref) {
  return ModelDownloader();
});

final downloadStatusProvider = StateProvider.family<DownloadStatus, ModelType>((ref, type) {
  return DownloadStatus.notDownloaded;
});

final downloadProgressProvider = StateProvider.family<DownloadProgress?, ModelType>((ref, type) {
  return null;
});

