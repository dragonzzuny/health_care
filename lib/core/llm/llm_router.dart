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
      if (_isExaoneLoaded && _isKoreanText(request.message)) {
        return LLMModel.exaone24B;
      } else if (_isGemmaLoaded) {
        return LLMModel.gemma1B;
      } else {
        throw Exception('No offline models available');
      }
    }

    // If online mode is forced, use GPT-4o
    if (_currentMode == LLMMode.online) {
      return LLMModel.gpt4o;
    }

    // Hybrid mode - intelligent routing
    if (request.isMultimodal) {
      return LLMModel.gpt4o; // Multimodal requires cloud model
    }

    if (_isComplexQuery(request.message)) {
      return LLMModel.gpt4o; // Complex queries go to cloud
    }

    // For Korean text, prefer EXAONE if available
    if (_isKoreanText(request.message) && _isExaoneLoaded) {
      return LLMModel.exaone24B;
    }

    // Default to Gemma for simple queries
    if (_isGemmaLoaded) {
      return LLMModel.gemma1B;
    }

    // Fallback to cloud if no offline models available
    return LLMModel.gpt4o;
  }

  bool _isKoreanText(String text) {
    // Simple Korean character detection
    final koreanRegex = RegExp(r'[ㄱ-ㅎ가-힣]');
    final koreanMatches = koreanRegex.allMatches(text).length;
    return koreanMatches > text.length * 0.3; // 30% Korean characters
  }

  bool _isComplexQuery(String text) {
    // Heuristics for complex queries
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
    // Basic rule-based responses for offline models
    final lowerMessage = message.toLowerCase();
    
    if (lowerMessage.contains('안녕') || lowerMessage.contains('hello')) {
      return '안녕하세요! $modelName 모델이 응답드립니다. 건강과 관련된 질문을 해주세요.';
    }
    
    if (lowerMessage.contains('식단') || lowerMessage.contains('음식')) {
      return '균형잡힌 식단을 위해서는 탄수화물, 단백질, 지방을 적절한 비율로 섭취하는 것이 중요합니다. 현재 식단 기록을 확인해보시겠어요?';
    }
    
    if (lowerMessage.contains('운동') || lowerMessage.contains('헬스')) {
      return '규칙적인 운동은 건강 유지에 필수적입니다. 주 3-4회, 30분 이상의 유산소 운동과 근력 운동을 병행하시는 것을 권장합니다.';
    }
    
    if (lowerMessage.contains('수면') || lowerMessage.contains('잠')) {
      return '좋은 수면을 위해서는 규칙적인 수면 패턴, 적절한 수면 환경, 취침 전 스마트폰 사용 제한 등이 도움됩니다.';
    }
    
    return '$modelName 모델로 처리된 응답입니다. 더 구체적인 질문을 해주시면 더 도움이 될 것 같아요!';
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

