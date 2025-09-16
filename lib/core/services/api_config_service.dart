import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

class ApiConfigService {
  static final ApiConfigService _instance = ApiConfigService._internal();
  factory ApiConfigService() => _instance;
  ApiConfigService._internal();

  final Logger _logger = Logger();
  static const String _cloudVisionApiKeyKey = 'cloud_vision_api_key';

  /// Google Cloud Vision API 키를 저장합니다
  Future<void> setCloudVisionApiKey(String apiKey) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_cloudVisionApiKeyKey, apiKey);
      _logger.i('Cloud Vision API 키가 저장되었습니다');
    } catch (e) {
      _logger.e('API 키 저장 오류: $e');
      rethrow;
    }
  }

  /// Google Cloud Vision API 키를 가져옵니다
  Future<String?> getCloudVisionApiKey() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_cloudVisionApiKeyKey);
    } catch (e) {
      _logger.e('API 키 조회 오류: $e');
      return null;
    }
  }

  /// Cloud Vision API 키가 설정되어 있는지 확인합니다
  Future<bool> hasCloudVisionApiKey() async {
    final apiKey = await getCloudVisionApiKey();
    return apiKey != null && apiKey.isNotEmpty;
  }

  /// Cloud Vision API 키를 삭제합니다
  Future<void> removeCloudVisionApiKey() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_cloudVisionApiKeyKey);
      _logger.i('Cloud Vision API 키가 삭제되었습니다');
    } catch (e) {
      _logger.e('API 키 삭제 오류: $e');
      rethrow;
    }
  }

  /// API 키의 유효성을 간단히 검증합니다
  bool isValidApiKey(String? apiKey) {
    if (apiKey == null || apiKey.isEmpty) return false;

    // Google API 키 형식 기본 검증 (AIza로 시작)
    if (!apiKey.startsWith('AIza')) return false;

    // 길이 검증 (일반적으로 39자)
    if (apiKey.length < 35 || apiKey.length > 45) return false;

    return true;
  }
}

/// OCR 서비스 설정을 위한 클래스
class OCRServiceConfig {
  final bool useCloudVision;
  final String? apiKey;
  final bool mlkitAvailable;

  OCRServiceConfig({
    required this.useCloudVision,
    this.apiKey,
    required this.mlkitAvailable,
  });

  bool get canUseCloudVision => useCloudVision && apiKey != null && apiKey!.isNotEmpty;
  bool get canUseMLKit => mlkitAvailable;
  bool get hasAnyOCRService => canUseMLKit || canUseCloudVision;

  /// 사용 가능한 OCR 서비스 우선순위
  /// 1. ML Kit (빠르고 오프라인)
  /// 2. Cloud Vision (더 정확하지만 온라인 필요)
  String get primaryOCRService {
    if (canUseMLKit) return 'mlkit';
    if (canUseCloudVision) return 'cloud_vision';
    return 'none';
  }

  Map<String, dynamic> toMap() {
    return {
      'useCloudVision': useCloudVision,
      'hasApiKey': apiKey != null,
      'mlkitAvailable': mlkitAvailable,
      'canUseCloudVision': canUseCloudVision,
      'canUseMLKit': canUseMLKit,
      'hasAnyOCRService': hasAnyOCRService,
      'primaryOCRService': primaryOCRService,
    };
  }
}