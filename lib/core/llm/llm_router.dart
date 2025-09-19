import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'model_downloader.dart';
import 'llama_cpp_ffi.dart';
import 'gemini_api_service.dart';
import '../config/app_config.dart';

enum LLMModel {
  gemma1B,
  exaone24B,
  gpt4o,
  geminiFlash,
}

enum LLMMode {
  offline,
  online,
  hybrid,
}

class LLMRequest {
  final String message;
  final String? context;
  final Map<String, dynamic>? metadata;
  final bool isMultimodal;
  final List<String>? imageUrls;

  const LLMRequest({
    required this.message,
    this.context,
    this.metadata,
    this.isMultimodal = false,
    this.imageUrls,
  });
}

class LLMResponse {
  final String response;
  final LLMModel usedModel;
  final double confidence;
  final Map<String, dynamic>? metadata;
  final DateTime timestamp;

  const LLMResponse({
    required this.response,
    required this.usedModel,
    required this.confidence,
    this.metadata,
    required this.timestamp,
  });
}

class LLMRouter {
  final Logger _logger = Logger();
  LLMMode _currentMode = LLMMode.hybrid;
  bool _isOnline = true;
  bool _isGemmaLoaded = false;  // 실제 상태로 변경
  bool _isExaoneLoaded = false;
  bool _isGeminiAvailable = false;
  
  // Dependencies
  ModelDownloader? _modelDownloader;
  LlamaCppFFI? _llamaFFI;
  GeminiApiService? _geminiService;
  
  // Initialize with dependencies
  void initialize(
    ModelDownloader modelDownloader,
    LlamaCppFFI llamaFFI, {
    String? geminiApiKey,
    String? geminiModelId,
  }) {
    _modelDownloader = modelDownloader;
    _llamaFFI = llamaFFI;
    _llamaFFI?.registerLlamaServerResolver(
      () async => await _modelDownloader?.ensureLlamaServerBinary(),
    );
    
    // Initialize Gemini API service
    if (geminiApiKey != null && geminiApiKey.isNotEmpty) {
      _geminiService = GeminiApiService(
        apiKey: geminiApiKey,
        defaultModelId: geminiModelId,
      );
      _checkGeminiAvailability();
    }

    _checkModelAvailability();
  }

  void setGeminiApiCredentials({required String apiKey, String? modelId}) {
    _geminiService = GeminiApiService(
      apiKey: apiKey,
      defaultModelId: modelId,
    );
    _checkGeminiAvailability();
  }

  Future<void> _checkGeminiAvailability() async {
    if (_geminiService != null) {
      try {
        _isGeminiAvailable = await _geminiService!.testConnection();
        _logger.i('Gemini API availability: ${_isGeminiAvailable ? "✅ Available" : "❌ Not available"}');
      } catch (e) {
        // Even if test connection fails, assume Gemini might work for actual requests
        // This handles temporary 503 errors
        _isGeminiAvailable = true;
        _logger.i('🔄 Gemini API test failed but marking as available for retry on actual requests');
        _logger.w('Connection test error: $e');
      }
    } else {
      _logger.e('❌ Gemini service is null - cannot check availability');
    }
  }

  // Model availability status
  bool get isGemmaAvailable => _isGemmaLoaded;
  bool get isExaoneAvailable => _isExaoneLoaded;
  bool get isGeminiAvailable => _isGeminiAvailable;
  bool get isOnline => _isOnline;
  LLMMode get currentMode => _currentMode;

  void setMode(LLMMode mode) {
    _currentMode = mode;
    _logger.i('LLM mode changed to: $mode');
  }

  void setOnlineStatus(bool isOnline) {
    _isOnline = isOnline;
    _logger.i('Online status changed to: $isOnline');
  }

  void setModelStatus({bool? gemmaLoaded, bool? exaoneLoaded}) {
    if (gemmaLoaded != null) _isGemmaLoaded = gemmaLoaded;
    if (exaoneLoaded != null) _isExaoneLoaded = exaoneLoaded;
    _logger.i('Model status - Gemma: $_isGemmaLoaded, EXAONE: $_isExaoneLoaded');
  }

  // Check if models are actually available
  Future<void> _checkModelAvailability() async {
    try {
      _logger.i('Checking offline model availability...');

      var gemmaAvailable = false;
      if (_modelDownloader != null) {
        gemmaAvailable = await _modelDownloader!.isModelDownloaded(ModelType.gemma1B);
        final shouldDownloadGemma = !_isGeminiAvailable;
        if (!gemmaAvailable && shouldDownloadGemma) {
          final gemmaPath = await _modelDownloader!.ensureModelDownloaded(ModelType.gemma1B);
          gemmaAvailable = gemmaPath != null;
          if (gemmaAvailable) {
            _logger.i('Gemma3 1B model downloaded successfully');
          }
        }

        final exaoneAvailable = await _modelDownloader!.isModelDownloaded(ModelType.exaone24B);
        _isExaoneLoaded = exaoneAvailable;

        if (gemmaAvailable) {
          await _modelDownloader!.ensureLlamaServerBinary();
        }
      }

      _isGemmaLoaded = gemmaAvailable;

      _logger.i('Model availability updated:');
      _logger.i('  Gemma (local): ${_isGemmaLoaded ? "✅ Available" : "❌ Not downloaded"}');
      _logger.i('  Gemini API: ${_isGeminiAvailable ? "✅ Configured" : "❌ Not configured"}');
      _logger.i('  EXAONE: ${_isExaoneLoaded ? "✅ Available" : "❌ Not downloaded"}');

      if (_llamaFFI != null) {
        final ffiInitialized = await _llamaFFI!.initialize();
        _logger.i('llama.cpp bridge initialization: ${ffiInitialized ? "✅ Success" : "❌ Failed"}');

        if (_isGemmaLoaded) {
          final gemmaPath = await _modelDownloader!.getModelPath(ModelType.gemma1B);
          final loaded = await _llamaFFI!.loadModel(gemmaPath);
          _logger.i('Gemma3 model loading: ${loaded ? "✅ Success" : "❌ Failed"}');
          if (loaded) {
            await _llamaFFI!.warmup();
          }
        }
      }
    } catch (e) {
      _logger.e('Error checking model availability: $e');
      if (!_isGeminiAvailable) {
        _isGemmaLoaded = false;
      }
    }
  }

  Future<LLMResponse> processRequest(LLMRequest request) async {
    try {
      final selectedModel = _selectModel(request);
      final messagePreview = request.message.length > 50 
          ? request.message.substring(0, 50) 
          : request.message;
      _logger.i('Selected model: $selectedModel for request: $messagePreview...');

      switch (selectedModel) {
        case LLMModel.gemma1B:
          return await _processWithGemma(request);
        case LLMModel.exaone24B:
          return await _processWithExaone(request);
        case LLMModel.gpt4o:
          return await _processWithGPT4o(request);
        case LLMModel.geminiFlash:
          return await _processWithGemini(request);
      }
    } catch (e) {
      _logger.e('LLM Router error: $e');
      // Fallback response
      return LLMResponse(
        response: _generateFallbackResponse(request.message),
        usedModel: LLMModel.gemma1B,
        confidence: 0.0,
        timestamp: DateTime.now(),
        metadata: {'error': e.toString(), 'fallback': true},
      );
    }
  }

  LLMModel _selectModel(LLMRequest request) {
    _logger.i('🤖 Model selection - Mode: $_currentMode, Online: $_isOnline');
    _logger.i('📊 Availability - Gemini: $_isGeminiAvailable, Gemma: $_isGemmaLoaded, EXAONE: $_isExaoneLoaded');
    
    // If offline mode is forced, use available offline models only
    if (_currentMode == LLMMode.offline || !_isOnline) {
      _logger.i('🔄 Offline mode selected');
      if (_isGemmaLoaded) {
        return LLMModel.gemma1B;
      } else if (_isExaoneLoaded) {
        return LLMModel.exaone24B;
      } else {
        throw Exception('No offline models available');
      }
    }

    // If online mode is forced, prefer Gemini API over other cloud models
    if (_currentMode == LLMMode.online) {
      _logger.i('🌐 Online mode selected');
      if (_isGeminiAvailable) {
        _logger.i('✅ Selecting Gemini Flash for online mode');
        return LLMModel.geminiFlash;
      }
      _logger.w('⚠️ Gemini not available, falling back to GPT-4o simulation');
      return LLMModel.gpt4o;
    }

    // Hybrid mode - prefer Gemini API for most queries (fastest and most reliable)
    _logger.i('🔄 Hybrid mode selected');
    if (_isGeminiAvailable) {
      _logger.i('✅ Selecting Gemini Flash for hybrid mode');
      return LLMModel.geminiFlash;
    }

    // Fallback to local models if Gemini is not available
    _logger.w('⚠️ Gemini not available, checking local models');
    if (_isGemmaLoaded) {
      _logger.i('📱 Falling back to Gemma');
      return LLMModel.gemma1B;
    }

    if (_isExaoneLoaded) {
      _logger.i('📱 Falling back to EXAONE');
      return LLMModel.exaone24B;
    }

    // Final fallback to GPT-4o simulation
    _logger.w('⚠️ No models available, using GPT-4o simulation');
    return LLMModel.gpt4o;
  }

  bool _isKoreanText(String text) {
    // Simple Korean character detection
    final koreanRegex = RegExp(r'[ㄱ-ㅎ가-힣]');
    final koreanMatches = koreanRegex.allMatches(text).length;
    return koreanMatches > text.length * 0.3; // 30% Korean characters
  }

  bool _isVeryComplexQuery(String text) {
    // Only very complex queries that really need GPT-4o
    final veryComplexIndicators = [
      'comprehensive analysis', '종합적 분석', 
      'detailed diagnosis', '정밀 진단',
      'treatment plan', '치료 계획',
      'medical emergency', '응급상황',
      'drug interaction', '약물 상호작용'
    ];
    
    final lowerText = text.toLowerCase();
    return veryComplexIndicators.any((indicator) => lowerText.contains(indicator)) ||
           text.length > 500 || // Very long queries only
           text.split(' ').length > 50; // Very many words
  }

  bool _isComplexQuery(String text) {
    // Keep original method for other uses
    final complexIndicators = [
      'analyze', '분석', 'compare', '비교', 'explain', '설명',
      'diagnosis', '진단', 'treatment', '치료', 'medical', '의료'
    ];
    
    final lowerText = text.toLowerCase();
    return complexIndicators.any((indicator) => lowerText.contains(indicator)) ||
           text.length > 200 || // Long queries
           text.split(' ').length > 30; // Many words
  }

  Future<LLMResponse> _processWithGemma(LLMRequest request) async {
    try {
      final startTime = DateTime.now();
      _logger.i('Processing with Gemma model...');
      
      // Try to use actual model via HTTP server or enhanced simulation
      if (_llamaFFI != null && _llamaFFI!.isInitialized && _isGemmaLoaded) {
        try {
          final result = await _llamaFFI!.generateText(
            _buildPrompt(request),
            maxTokens: 150,
            temperature: 0.7,
          );
          
          return LLMResponse(
            response: result.text,
            usedModel: LLMModel.gemma1B,
            confidence: 0.85,
            timestamp: DateTime.now(),
            metadata: {
              'model_version': 'gemma-3-1b-it-Q4_K_M',
              'tokens_generated': result.tokensGenerated,
              'tokens_per_second': result.tokensPerSecond,
              'inference_method': result.metadata['inference_method'] ?? 'enhanced_simulation',
              'model_path': result.metadata['model_path'],
            },
          );
        } catch (e) {
          _logger.e('Gemma generation failed: $e, falling back to basic simulation');
          return _processWithSimulation(request, 'Gemma');
        }
      }
      
      // Fallback to basic simulation
      return _processWithSimulation(request, 'Gemma');
      
    } catch (e) {
      _logger.e('Gemma processing failed: $e');
      rethrow;
    }
  }

  Future<String?> _getModelPath(ModelType type) async {
    if (_modelDownloader == null) return null;
    
    try {
      final modelInfo = _modelDownloader!.getModelInfo(type);
      final home = Platform.environment['HOME'] ??
          Platform.environment['USERPROFILE'] ??
          Directory.current.path;
      final modelPath = '$home/.signcare_models/${modelInfo.fileName}';
      
      final file = File(modelPath);
      if (await file.exists()) {
        return modelPath;
      }
    } catch (e) {
      _logger.e('Error getting model path: $e');
    }
    
    return null;
  }

  String _buildPrompt(LLMRequest request) {
    // Build a proper prompt for Gemma3
    final context = request.context ?? '';
    return '''$context

사용자: ${request.message}
AI 건강상담사:''';
  }

  Future<LLMResponse> _processWithSimulation(LLMRequest request, String modelName) async {
    // Enhanced simulation with more realistic timing
    final complexity = _estimateComplexity(request.message);
    final simulatedDelay = Duration(milliseconds: 300 + (complexity * 20));
    
    await Future.delayed(simulatedDelay);
    
    final response = _generateBasicResponse(request.message, modelName);
    
    return LLMResponse(
      response: response,
      usedModel: LLMModel.gemma1B,
      confidence: 0.75, // Lower confidence for simulation
      timestamp: DateTime.now(),
      metadata: {
        'processing_time_ms': simulatedDelay.inMilliseconds,
        'model_version': 'gemma-simulation',
        'inference_method': 'simulation',
        'estimated_complexity': complexity,
      },
    );
  }

  int _estimateComplexity(String message) {
    // Simple complexity estimation based on message length and keywords
    int complexity = (message.length / 10).round();
    
    final complexKeywords = ['분석', '진단', '치료', '처방', '검사', '수술', '병원'];
    for (final keyword in complexKeywords) {
      if (message.contains(keyword)) {
        complexity += 5;
      }
    }
    
    return complexity.clamp(1, 20);
  }

  Future<LLMResponse> _processWithExaone(LLMRequest request) async {
    try {
      // Simulate EXAONE processing
      await Future.delayed(const Duration(milliseconds: 800));
      
      final response = _generateBasicResponse(request.message, 'EXAONE');
      
      return LLMResponse(
        response: response,
        usedModel: LLMModel.exaone24B,
        confidence: 0.9,
        timestamp: DateTime.now(),
        metadata: {'processing_time_ms': 800, 'model_version': 'exaone-2.4b-q4'},
      );
    } catch (e) {
      _logger.e('EXAONE processing failed: $e');
      rethrow;
    }
  }

  Future<LLMResponse> _processWithGPT4o(LLMRequest request) async {
    try {
      // Simulate GPT-4o API call
      await Future.delayed(const Duration(milliseconds: 1500));
      
      final response = _generateAdvancedResponse(request.message);
      
      return LLMResponse(
        response: response,
        usedModel: LLMModel.gpt4o,
        confidence: 0.95,
        timestamp: DateTime.now(),
        metadata: {'processing_time_ms': 1500, 'model_version': 'gpt-4o'},
      );
    } catch (e) {
      _logger.e('GPT-4o processing failed: $e');
      rethrow;
    }
  }

  String _generateBasicResponse(String message, String modelName) {
    // Enhanced responses for offline models (especially Gemma3)
    final lowerMessage = message.toLowerCase();
    final modelDisplayName = modelName == 'Gemma' ? 'Gemma3' : modelName;
    
    // 인사말 응답
    if (lowerMessage.contains('안녕') || lowerMessage.contains('hello') || lowerMessage.contains('hi')) {
      return '안녕하세요! ${modelDisplayName} AI 건강 상담사입니다. 🏥\n\n저는 SignCare 앱을 통해 여러분의 건강 관리를 도와드리고 있어요. 식단, 운동, 수면, 스트레스 관리 등 건강과 관련된 어떤 질문이든 편하게 물어보세요!\n\n오늘 어떤 건강 고민이 있으신가요?';
    }
    
    // 당뇨/혈당 관련
    if (lowerMessage.contains('당뇨') || lowerMessage.contains('혈당') || lowerMessage.contains('인슐린')) {
      return '${modelDisplayName}가 당뇨 관리에 대해 상세히 안내해드릴게요! 🩺\n\n**당뇨 관리의 핵심:**\n• **혈당 모니터링**: 식전/식후 정기 측정\n• **식단 관리**: 복합탄수화물 위주, 단순당 제한\n• **규칙적인 운동**: 주 150분 이상 유산소 운동\n• **체중 관리**: 적정 체중 유지\n• **정기 검진**: 당화혈색소(HbA1c) 체크\n\n**추천 음식**: 현미, 귀리, 채소, 생선, 견과류\n**주의 음식**: 흰쌀, 단 음료, 과자, 튀긴음식\n\n현재 혈당 수치나 복용 중인 약물이 있으시면 알려주세요!';
    }
    
    // 식단/영양 관련  
    if (lowerMessage.contains('식단') || lowerMessage.contains('음식') || lowerMessage.contains('칼로리') || lowerMessage.contains('영양')) {
      return '${modelDisplayName}가 맞춤 식단 조언을 드립니다! 🍎\n\n**건강한 식단의 황금비율:**\n• **탄수화물 50-60%**: 현미, 귀리, 고구마\n• **단백질 15-20%**: 닭가슴살, 생선, 두부, 콩류\n• **지방 20-30%**: 견과류, 아보카도, 올리브오일\n• **비타민/무기질**: 다양한 채소와 과일\n\n**하루 권장 섭취:**\n• 물 8-10컵 (2L 이상)\n• 채소 5-6접시\n• 과일 2-3개\n• 단백질 매끼 손바닥 크기\n\n현재 식단 패턴이나 특별한 목표(다이어트, 근육증가 등)가 있으시면 더 구체적으로 도움드릴게요!';
    }
    
    // 운동 관련
    if (lowerMessage.contains('운동') || lowerMessage.contains('헬스') || lowerMessage.contains('근육') || lowerMessage.contains('다이어트')) {
      return '${modelDisplayName}의 맞춤 운동 가이드입니다! 💪\n\n**초보자 4주 프로그램:**\n\n**1-2주차 (적응기):**\n• 빠른 걷기 20-30분 (주 3회)\n• 기본 스쿼트 10회 3세트\n• 벽 푸시업 5-10회 3세트\n• 플랭크 10-20초 3세트\n\n**3-4주차 (발전기):**\n• 조깅/수영 30-40분 (주 3-4회)\n• 일반 푸시업 도전\n• 런지, 버피 추가\n• 플랭크 30-60초\n\n**운동 시 주의사항:**\n• 충분한 워밍업과 쿨다운\n• 점진적 강도 증가\n• 주 1-2회 휴식일 확보\n\n현재 운동 경험 수준과 목표를 알려주시면 더 정확한 계획을 세워드릴게요!';
    }
    
    // 수면 관련
    if (lowerMessage.contains('수면') || lowerMessage.contains('잠') || lowerMessage.contains('불면') || lowerMessage.contains('피곤')) {
      return '${modelDisplayName}의 수면 개선 전문 가이드입니다! 😴\n\n**완벽한 수면을 위한 7가지 원칙:**\n\n**1. 수면 패턴 규칙화**\n• 매일 같은 시간에 잠자리에 들기\n• 7-8시간 충분한 수면 확보\n• 주말에도 2시간 이상 늦게 자지 않기\n\n**2. 수면 환경 최적화**\n• 실내온도 18-22°C 유지\n• 암막커튼으로 빛 차단\n• 조용하고 편안한 환경\n\n**3. 취침 전 루틴**\n• 1시간 전 스마트폰/TV 금지\n• 따뜻한 목욕이나 차 한잔\n• 가벼운 스트레칭이나 명상\n• 카페인은 오후 2시 이후 금지\n\n불면 증상이 2주 이상 지속되면 수면클리닉 상담을 권해드려요.';
    }
    
    // 스트레스/정신건강 관련
    if (lowerMessage.contains('스트레스') || lowerMessage.contains('우울') || lowerMessage.contains('불안') || lowerMessage.contains('마음')) {
      return '${modelDisplayName}가 마음 건강 관리를 도와드립니다! 🧘‍♀️\n\n**스트레스 관리 5단계 전략:**\n\n**1단계 - 즉시 완화법**\n• 4-7-8 호흡법 (4초 들숨, 7초 멈춤, 8초 날숨)\n• 5-4-3-2-1 기법 (보이는 것 5개, 들리는 것 4개...)\n\n**2단계 - 일상 관리**\n• 규칙적인 운동 (세로토닌 증가)\n• 충분한 수면 (7-8시간)\n• 균형잡힌 식사\n\n**3단계 - 마음챙김**\n• 명상 앱 활용 (하루 10분)\n• 감사 일기 쓰기\n• 취미활동 즐기기\n\n**4단계 - 사회적 지지**\n• 가족, 친구와 대화\n• 운동 동호회 참여\n• 전문가 상담 (필요시)\n\n지속적인 우울감이나 불안감이 있으시다면 정신건강 전문의 상담을 권합니다.';
    }
    
    // 체중관리 관련
    if (lowerMessage.contains('살') || lowerMessage.contains('체중') || lowerMessage.contains('비만') || lowerMessage.contains('다이어트')) {
      return '${modelDisplayName}의 건강한 체중관리 가이드입니다! ⚖️\n\n**과학적 체중감량 공식:**\n\n**칼로리 계산:**\n• 기초대사율 + 활동대사율 - 500kcal = 1주일에 0.5kg 감량\n• 급격한 감량보다는 월 2-3kg이 건강한 속도\n\n**3:7의 법칙:**\n• 운동 30% : 식단 70%\n• 유산소 70% : 근력운동 30%\n\n**단계별 식단 관리:**\n**1주차**: 간식 줄이기, 물 많이 마시기\n**2-3주차**: 밥량 20% 줄이고 채소 늘리기\n**4주차**: 규칙적인 식사시간 정착\n\n**추천 운동 조합:**\n• 유산소 30-45분 (주 4-5회)\n• 근력운동 20-30분 (주 2-3회)\n• 일상 활동량 늘리기 (계단, 도보)\n\n현재 키, 몸무게, 목표를 알려주시면 더 정확한 계획을 세워드릴게요!';
    }

    // 일반적인 응답
    return '${modelDisplayName} 건강 상담사입니다! 😊\n\n**상담 가능한 영역:**\n🏥 **질병 관리**: 당뇨, 고혈압, 심혈관 질환\n🍎 **영양 관리**: 식단 계획, 칼로리 계산\n💪 **운동 처방**: 맞춤 운동 계획, 재활 운동\n😴 **수면 개선**: 불면증, 수면 패턴 교정\n🧘‍♀️ **스트레스 관리**: 명상, 이완 기법\n⚖️ **체중 관리**: 다이어트, 건강한 증량\n\n**더 정확한 상담을 위해 알려주세요:**\n• 현재 건강 상태나 증상\n• 복용 중인 약물이나 기존 질환\n• 생활 패턴 (식사, 운동, 수면)\n• 구체적인 목표나 궁금한 점\n\n언제든 편하게 질문해주세요! 개인 맞춤형 건강 조언을 제공해드리겠습니다.';
  }

  String _generateAdvancedResponse(String message) {
    // More sophisticated responses for cloud model
    final lowerMessage = message.toLowerCase();
    
    if (lowerMessage.contains('분석') || lowerMessage.contains('analyze')) {
      return '''건강 데이터 분석 결과를 말씀드리겠습니다.

현재 제공해주신 정보를 바탕으로 종합적인 분석을 수행했습니다:

1. **전반적인 건강 상태**: 양호한 편이지만 몇 가지 개선점이 있습니다.
2. **주요 관심 영역**: 식단 관리와 운동 패턴 최적화가 필요해 보입니다.
3. **권장사항**: 
   - 규칙적인 생활 패턴 유지
   - 균형잡힌 영양 섭취
   - 적절한 수분 섭취
   - 스트레스 관리

더 정확한 분석을 위해서는 추가적인 건강 데이터가 필요합니다. 구체적으로 어떤 부분에 대한 분석을 원하시나요?''';
    }
    
    return '''GPT-4o 모델을 통해 고도화된 응답을 제공합니다.

귀하의 질문에 대해 다각도로 분석한 결과:

• **즉시 실행 가능한 조치**: 현재 상황에서 바로 적용할 수 있는 방법들을 제안합니다.
• **중장기 계획**: 지속적인 건강 관리를 위한 단계별 접근법을 안내합니다.
• **개인 맞춤형 권장사항**: 귀하의 특성에 맞는 구체적인 가이드라인을 제공합니다.

추가적인 정보나 더 구체적인 상담이 필요하시면 언제든 말씀해 주세요.''';
  }

  Future<LLMResponse> _processWithGemini(LLMRequest request) async {
    try {
      final startTime = DateTime.now();
      _logger.i('Processing with Gemini API...');
      
      if (_geminiService == null) {
        throw Exception('Gemini API service not initialized');
      }

      final result = await _geminiService!.generateHealthConsultation(
        userMessage: request.message,
        userContext: request.context,
      );
      
      final endTime = DateTime.now();
      final processingTime = endTime.difference(startTime);
      
      return LLMResponse(
        response: result,
        usedModel: LLMModel.geminiFlash,
        confidence: 0.95,
        timestamp: DateTime.now(),
        metadata: {
          'processing_time_ms': processingTime.inMilliseconds,
          'model_version': _geminiService?.defaultModelId ?? 'gemini-2.0-flash',
          'tokens_generated': result.split(' ').length,
          'inference_method': 'gemini_api',
          'api_provider': 'google',
        },
      );
      
    } catch (e) {
      _logger.e('Gemini processing failed: $e');
      rethrow;
    }
  }

  String _generateFallbackResponse(String message) {
    return '''안녕하세요! SignCare AI 건강 상담사입니다. 🏥

현재 시스템 초기화 중이라 간단한 응답만 가능합니다.

**기본 건강 관리 조언:**
• 하루 8잔 이상의 물 섭취
• 규칙적인 식사 시간 유지  
• 주 3회 이상 30분 운동
• 7-8시간 충분한 수면
• 스트레스 관리 및 명상

구체적인 건강 상담을 원하시면 잠시 후 다시 시도해주세요.
시스템이 완전히 로드되면 더 자세한 상담이 가능합니다! 😊''';
  }
}

// Riverpod providers
final llmRouterProvider = Provider<LLMRouter>((ref) {
  final router = LLMRouter();
  final modelDownloader = ref.watch(modelDownloaderProvider);
  final llamaFFI = ref.watch(llamaCppFFIProvider);
  
  // Temporary direct API key for testing
  final geminiApiKey = 'AIzaSyC2nB-AuLrDrIwvfM5hfXN0adnN22MwqE4';
  final geminiModelId = 'gemma-3-27b-it'; // Gemma 3 model

  router.initialize(
    modelDownloader,
    llamaFFI,
    geminiApiKey: geminiApiKey,
    geminiModelId: geminiModelId,
  );
  
  return router;
});

final llmModeProvider = StateProvider<LLMMode>((ref) {
  return LLMMode.hybrid;
});

final llmOnlineStatusProvider = StateProvider<bool>((ref) {
  return true;
});
