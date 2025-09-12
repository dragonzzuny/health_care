import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

enum LLMModel {
  gemma1B,
  exaone24B,
  gpt4o,
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
  bool _isGemmaLoaded = false;
  bool _isExaoneLoaded = false;

  // Model availability status
  bool get isGemmaAvailable => _isGemmaLoaded;
  bool get isExaoneAvailable => _isExaoneLoaded;
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

  Future<LLMResponse> processRequest(LLMRequest request) async {
    final selectedModel = _selectModel(request);
    _logger.i('Selected model: $selectedModel for request: ${request.message.substring(0, 50)}...');

    switch (selectedModel) {
      case LLMModel.gemma1B:
        return await _processWithGemma(request);
      case LLMModel.exaone24B:
        return await _processWithExaone(request);
      case LLMModel.gpt4o:
        return await _processWithGPT4o(request);
    }
  }

  LLMModel _selectModel(LLMRequest request) {
    // If offline mode is forced, use available offline models
    if (_currentMode == LLMMode.offline || !_isOnline) {
      // Prioritize Gemma3 for all offline queries
      if (_isGemmaLoaded) {
        return LLMModel.gemma1B;
      } else if (_isExaoneLoaded) {
        return LLMModel.exaone24B;
      } else {
        throw Exception('No offline models available');
      }
    }

    // If online mode is forced, use GPT-4o
    if (_currentMode == LLMMode.online) {
      return LLMModel.gpt4o;
    }

    // Hybrid mode - intelligent routing with Gemma3 preference
    if (request.isMultimodal) {
      return LLMModel.gpt4o; // Multimodal requires cloud model
    }

    // Use Gemma3 for most queries, only escalate to cloud for very complex ones
    if (_isVeryComplexQuery(request.message)) {
      return LLMModel.gpt4o; // Only very complex queries go to cloud
    }

    // Prefer Gemma3 for all text queries (including Korean)
    if (_isGemmaLoaded) {
      return LLMModel.gemma1B;
    }

    // Fallback to EXAONE if Gemma not available
    if (_isExaoneLoaded) {
      return LLMModel.exaone24B;
    }

    // Final fallback to cloud if no offline models available
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
      // Simulate Gemma processing
      await Future.delayed(const Duration(milliseconds: 500));
      
      final response = _generateBasicResponse(request.message, 'Gemma');
      
      return LLMResponse(
        response: response,
        usedModel: LLMModel.gemma1B,
        confidence: 0.8,
        timestamp: DateTime.now(),
        metadata: {'processing_time_ms': 500, 'model_version': 'gemma-1b-q4'},
      );
    } catch (e) {
      _logger.e('Gemma processing failed: $e');
      rethrow;
    }
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
    
    if (lowerMessage.contains('안녕') || lowerMessage.contains('hello')) {
      return '안녕하세요! ${modelName == 'Gemma' ? 'Gemma3' : modelName} AI 건강 상담사입니다. 🏥\n\n건강과 관련된 다양한 질문을 도와드릴 수 있어요. 식단, 운동, 수면 등 무엇이든 물어보세요!';
    }
    
    if (lowerMessage.contains('식단') || lowerMessage.contains('음식') || lowerMessage.contains('칼로리')) {
      return '${modelName == 'Gemma' ? 'Gemma3' : modelName}가 식단 조언을 드립니다! 🍎\n\n균형잡힌 식단의 기본원칙:\n• 탄수화물 50-60% (현미, 귀리 등)\n• 단백질 15-20% (생선, 닭가슴살, 콩류)\n• 지방 20-30% (견과류, 올리브오일)\n• 충분한 채소와 과일\n\n현재 드시는 음식이나 목표가 있으시면 더 구체적인 조언을 드릴 수 있어요!';
    }
    
    if (lowerMessage.contains('운동') || lowerMessage.contains('헬스') || lowerMessage.contains('근육')) {
      return '${modelName == 'Gemma' ? 'Gemma3' : modelName}의 운동 가이드입니다! 💪\n\n초보자 추천 계획:\n• 주 3-4회, 30-45분\n• 유산소: 빠른 걷기, 조깅, 수영\n• 근력: 스쿼트, 푸시업, 플랭크\n• 점진적 강도 증가\n\n현재 운동 경험이나 목표를 알려주시면 맞춤 계획을 제안해드릴게요!';
    }
    
    if (lowerMessage.contains('수면') || lowerMessage.contains('잠') || lowerMessage.contains('불면')) {
      return '${modelName == 'Gemma' ? 'Gemma3' : modelName}의 수면 개선 조언입니다! 😴\n\n좋은 수면을 위한 습관:\n• 규칙적인 수면시간 (7-8시간)\n• 취침 1시간 전 디지털 기기 금지\n• 실내온도 18-22°C 유지\n• 카페인은 오후 2시 이후 금지\n• 가벼운 스트레칭이나 명상\n\n현재 수면 패턴에 문제가 있으시다면 더 자세히 상담해드릴게요!';
    }
    
    if (lowerMessage.contains('스트레스') || lowerMessage.contains('우울') || lowerMessage.contains('불안')) {
      return '${modelName == 'Gemma' ? 'Gemma3' : modelName}가 스트레스 관리를 도와드립니다! 🧘‍♀️\n\n효과적인 스트레스 관리법:\n• 규칙적인 운동 (엔도르핀 분비)\n• 심호흡과 명상 (하루 10분)\n• 충분한 수면과 휴식\n• 취미활동과 사회적 관계\n• 긍정적 사고 훈련\n\n지속적인 증상이 있다면 전문의 상담도 권해드려요.';
    }
    
    return '${modelName == 'Gemma' ? 'Gemma3' : modelName}입니다! 😊\n\n더 구체적인 건강 상담을 위해 다음을 알려주세요:\n• 현재 상황이나 증상\n• 목표나 궁금한 점\n• 생활 패턴\n\n개인 맞춤형 조언을 드릴 수 있도록 도와드리겠습니다!';
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
}

// Riverpod providers
final llmRouterProvider = Provider<LLMRouter>((ref) {
  return LLMRouter();
});

final llmModeProvider = StateProvider<LLMMode>((ref) {
  return LLMMode.hybrid;
});

final llmOnlineStatusProvider = StateProvider<bool>((ref) {
  return true;
});

