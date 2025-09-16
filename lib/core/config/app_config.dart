import 'package:logger/logger.dart';
import '../services/api_config_service.dart';

/// 앱 설정을 위한 헬퍼 클래스
/// 개발자가 코드에서 직접 API 키를 설정할 수 있습니다
class AppConfig {
  static final ApiConfigService _apiConfig = ApiConfigService();

  /// Google Cloud Vision API 키를 설정합니다
  ///
  /// 사용법:
  /// ```dart
  /// await AppConfig.setGoogleVisionApiKey('AIza...');
  /// ```
  ///
  /// API 키가 없으면 ML Kit만 사용됩니다
  /// API 키가 있으면 Cloud Vision API도 함께 사용됩니다
  static Future<void> setGoogleVisionApiKey(String apiKey) async {
    if (!_apiConfig.isValidApiKey(apiKey)) {
      throw ArgumentError('유효하지 않은 API 키입니다. Google API 키는 AIza로 시작해야 합니다.');
    }
    await _apiConfig.setCloudVisionApiKey(apiKey);
  }

  /// 현재 설정된 API 키 상태를 확인합니다
  static Future<bool> hasGoogleVisionApiKey() async {
    return await _apiConfig.hasCloudVisionApiKey();
  }

  /// API 키를 제거합니다 (ML Kit만 사용)
  static Future<void> removeGoogleVisionApiKey() async {
    await _apiConfig.removeCloudVisionApiKey();
  }

  static final Logger _logger = Logger();

  /// 앱 초기화 시 API 키를 설정하는 헬퍼 메서드
  ///
  /// main.dart에서 다음과 같이 사용:
  /// ```dart
  /// void main() async {
  ///   WidgetsFlutterBinding.ensureInitialized();
  ///
  ///   // 환경 변수나 안전한 저장소에서 API 키 로드
  ///   await AppConfig.initializeFromEnvironment();
  ///
  ///   runApp(MyApp());
  /// }
  /// ```
  static Future<void> initializeFromEnvironment() async {
    // 환경 변수나 안전한 설정에서 API 키 로드
    final apiKey = await _loadApiKeyFromEnvironment();

    if (apiKey != null && apiKey.isNotEmpty) {
      await setGoogleVisionApiKey(apiKey);
      _logger.i('Google Vision API 키가 설정되었습니다. 고정밀 OCR을 사용할 수 있습니다.');
    } else {
      _logger.w('API 키가 없습니다. ML Kit OCR만 사용됩니다.');
    }
  }

  /// 환경 변수나 안전한 저장소에서 API 키를 로드합니다
  /// 실제 구현에서는 다음 중 하나를 사용하세요:
  /// 1. Flutter dotenv (.env 파일)
  /// 2. Flutter secure storage
  /// 3. Android: strings.xml, iOS: Info.plist
  /// 4. 외부 설정 서버
  static Future<String?> _loadApiKeyFromEnvironment() async {
    // TODO: 실제 환경에서는 다음 중 하나를 구현하세요

    // 옵션 1: dotenv 사용 (추천)
    // await dotenv.load(fileName: ".env");
    // return dotenv.env['GOOGLE_VISION_API_KEY'];

    // 옵션 2: Flutter secure storage 사용
    // const storage = FlutterSecureStorage();
    // return await storage.read(key: 'google_vision_api_key');

    // 현재는 null 반환 (ML Kit만 사용)
    return null;
  }

  /// API 키 없이 초기화 (ML Kit만 사용)
  static Future<void> initializeWithoutApiKey() async {
    await removeGoogleVisionApiKey();
    _logger.i('ML Kit OCR만 사용하도록 설정되었습니다.');
  }
}

/// 보안 가이드라인
///
/// ⚠️ 중요: API 키는 절대 코드에 하드코딩하지 마세요!
///
/// 안전한 API 키 관리 방법:
///
/// 1. **flutter_dotenv 사용 (추천)**
///    ```yaml
///    dependencies:
///      flutter_dotenv: ^5.1.0
///    ```
///    .env 파일:
///    ```
///    GOOGLE_VISION_API_KEY=AIza...
///    ```
///
/// 2. **Flutter Secure Storage**
///    ```yaml
///    dependencies:
///      flutter_secure_storage: ^9.0.0
///    ```
///
/// 3. **네이티브 플랫폼 설정**
///    - Android: strings.xml에 저장
///    - iOS: Info.plist에 저장
///
/// 4. **외부 설정 서버에서 로드**
///    - Firebase Remote Config
///    - AWS Parameter Store
///    - 자체 설정 API
class SecurityGuidelines {
  // 이 클래스는 문서화 목적으로만 사용됩니다
  // 실제 API 키는 여기에 저장하지 마세요!
}