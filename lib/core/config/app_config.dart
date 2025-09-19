import 'dart:io';

class AppConfig {
  static late AppConfig _instance;
  static AppConfig get instance => _instance;
  static const String _defineGeminiApiKey =
      String.fromEnvironment('GEMINI_API_KEY', defaultValue: '');
  static const String _defineOpenAiApiKey =
      String.fromEnvironment('OPENAI_API_KEY', defaultValue: '');
  static const String _defineAnthropicApiKey =
      String.fromEnvironment('ANTHROPIC_API_KEY', defaultValue: '');
  static const String _defineDevelopmentMode =
      String.fromEnvironment('DEVELOPMENT_MODE', defaultValue: '');
  static const String _defineLogLevel =
      String.fromEnvironment('LOG_LEVEL', defaultValue: '');
  static const String _defineGeminiModelId =
      String.fromEnvironment('GEMINI_MODEL_ID', defaultValue: '');
  
  final Map<String, String> _config = {};
  
  // API Keys
  String? get geminiApiKey => _config['GEMINI_API_KEY'];
  String? get openaiApiKey => _config['OPENAI_API_KEY'];
  String? get anthropicApiKey => _config['ANTHROPIC_API_KEY'];
  String get geminiModelId =>
      _config['GEMINI_MODEL_ID']?.trim().isNotEmpty == true
          ? _normalizeModelId(_config['GEMINI_MODEL_ID']!)
          : 'gemma-3-27b-it';
  
  // App Settings
  bool get isDevelopmentMode => _config['DEVELOPMENT_MODE'] == 'true';
  String get logLevel => _config['LOG_LEVEL'] ?? 'info';
  
  AppConfig._();
  
  static Future<void> initialize() async {
    _instance = AppConfig._();
    await _instance._loadConfig();
  }
  
  Future<void> _loadConfig() async {
    // Load from environment variables first
    _loadFromEnvironment();
    
    // Then try to load from .env.local file (for development)
    await _loadFromFile('.env.local');
    
    // Finally load from .env file (defaults)
    await _loadFromFile('.env');
    
    _logConfigStatus();
  }
  
  void _loadFromEnvironment() {
    final compileTimeValues = {
      'GEMINI_API_KEY': _defineGeminiApiKey,
      'OPENAI_API_KEY': _defineOpenAiApiKey,
      'ANTHROPIC_API_KEY': _defineAnthropicApiKey,
      'DEVELOPMENT_MODE': _defineDevelopmentMode,
      'LOG_LEVEL': _defineLogLevel,
      'GEMINI_MODEL_ID': _defineGeminiModelId,
    };

    for (final entry in compileTimeValues.entries) {
      if (entry.value.isNotEmpty) {
        _config[entry.key] = entry.value;
      }
    }

    final envVars = [
      'GEMINI_API_KEY',
      'OPENAI_API_KEY',
      'ANTHROPIC_API_KEY',
      'DEVELOPMENT_MODE',
      'LOG_LEVEL',
      'GEMINI_MODEL_ID',
    ];

    for (final varName in envVars) {
      final value = Platform.environment[varName];
      if (value != null && value.isNotEmpty) {
        _config[varName] = value;
      }
    }
  }
  
  Future<void> _loadFromFile(String filename) async {
    try {
      final file = File(filename);
      if (!await file.exists()) {
        return;
      }
      
      final lines = await file.readAsLines();
      for (final line in lines) {
        final trimmed = line.trim();
        
        // Skip comments and empty lines
        if (trimmed.isEmpty || trimmed.startsWith('#')) {
          continue;
        }
        
        // Parse key=value pairs
        final parts = trimmed.split('=');
        if (parts.length >= 2) {
          final key = parts[0].trim();
          final value = parts.sublist(1).join('=').trim();
          
          // Don't override existing values
          if (!_config.containsKey(key) || _config[key]!.isEmpty) {
            _config[key] = value;
          }
        }
      }
    } catch (e) {
      print('Warning: Could not load config from $filename: $e');
    }
  }
  
  void _logConfigStatus() {
    print('🔧 AppConfig initialized:');
    print('   Gemini API Key: ${geminiApiKey != null && geminiApiKey!.isNotEmpty ? "✅ Configured" : "❌ Missing"}');
    print('   Gemini Model : $geminiModelId');
    print('   Development Mode: ${isDevelopmentMode ? "✅ Enabled" : "❌ Disabled"}');
    print('   Log Level: $logLevel');
    
    if (geminiApiKey == null || geminiApiKey!.isEmpty || geminiApiKey == 'your_gemini_api_key_here') {
      print('⚠️  Warning: Gemini API key not configured. Please set GEMINI_API_KEY in .env.local');
    }
  }
  
  // Helper method to set API key at runtime (for testing)
  void setGeminiApiKey(String apiKey) {
    _config['GEMINI_API_KEY'] = apiKey;
    print('🔑 Gemini API key updated at runtime');
  }

  void setGeminiModelId(String modelId) {
    _config['GEMINI_MODEL_ID'] = _normalizeModelId(modelId);
    print('🧠 Gemini 모델이 ${_config['GEMINI_MODEL_ID']} 로 설정되었습니다');
  }
  
  // Validate configuration
  bool isValid() {
    return geminiApiKey != null && 
           geminiApiKey!.isNotEmpty && 
           geminiApiKey != 'your_gemini_api_key_here' &&
           geminiApiKey != 'GEMINI_API_KEY';
  }

  Map<String, String> get configSummary => Map.from(_config);

  String _normalizeModelId(String raw) {
    final trimmed = raw.trim();
    if (trimmed.startsWith('models/')) {
      return trimmed.substring('models/'.length);
    }
    return trimmed;
  }
}
