// Core Constants
class AppConstants {
  // App Info
  static const String appName = 'SignCare';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'AI 기반 개인 맞춤형 헬스케어 앱';
  
  // API
  static const String baseUrl = 'https://api.signcare.com';
  static const String apiVersion = 'v1';
  static const Duration apiTimeout = Duration(seconds: 30);
  
  // LLM Models
  static const String gemmaModelName = 'gemma-1b-q4';
  static const String exaoneModelName = 'exaone-2.4b-q4';
  static const int gemmaModelSize = 530; // MB
  static const int exaoneModelSize = 1200; // MB
  static const Duration llmIdleTimeout = Duration(minutes: 5);
  
  // Database
  static const String databaseName = 'signcare.db';
  static const int databaseVersion = 1;
  
  // Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userProfileKey = 'user_profile';
  static const String settingsKey = 'app_settings';
  static const String llmModelPathKey = 'llm_model_path';
  
  // Health Data
  static const int dailyStepsGoal = 10000;
  static const int weeklyActiveMinutesGoal = 150;
  static const double dailyWaterGoal = 2.0; // Liters
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double borderRadius = 12.0;
  static const double cardElevation = 2.0;
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
  
  // Validation
  static const int minPasswordLength = 8;
  static const int maxNameLength = 50;
  static const int maxMessageLength = 1000;
  
  // File Paths
  static const String modelsPath = 'assets/models/';
  static const String imagesPath = 'assets/images/';
  static const String lottiePath = 'assets/lottie/';
  
  // Error Messages
  static const String networkError = '네트워크 연결을 확인해주세요';
  static const String serverError = '서버 오류가 발생했습니다';
  static const String unknownError = '알 수 없는 오류가 발생했습니다';
  static const String validationError = '입력 정보를 확인해주세요';
}

