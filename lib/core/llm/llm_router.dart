import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

enum LLMModel {
  gemma1B, // Legacy - will be replaced by exaone4_1B
  exaone24B, // Legacy - will be replaced by medGemma4B
  gpt4o,
  exaone4_1B, // EXAONE 4.0 1.2B - Primary model for Korean
  medGemma4B, // MedGemma 4B - Medical specialized model
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
  bool _isGemmaLoaded = false; // Legacy
  bool _isExaoneLoaded = false; // Legacy
  bool _isExaone4Loaded = false; // EXAONE 4.0 1.2B
  bool _isMedGemmaLoaded = false; // MedGemma 4B

  // Model availability status
  bool get isGemmaAvailable => _isGemmaLoaded; // Legacy
  bool get isExaoneAvailable => _isExaoneLoaded; // Legacy
  bool get isExaone4Available => _isExaone4Loaded;
  bool get isMedGemmaAvailable => _isMedGemmaLoaded;
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

  void setModelStatus({
    bool? gemmaLoaded,
    bool? exaoneLoaded,
    bool? exaone4Loaded,
    bool? medGemmaLoaded,
  }) {
    if (gemmaLoaded != null) _isGemmaLoaded = gemmaLoaded;
    if (exaoneLoaded != null) _isExaoneLoaded = exaoneLoaded;
    if (exaone4Loaded != null) _isExaone4Loaded = exaone4Loaded;
    if (medGemmaLoaded != null) _isMedGemmaLoaded = medGemmaLoaded;
    _logger.i('Model status - Gemma: $_isGemmaLoaded, EXAONE 3.5: $_isExaoneLoaded, EXAONE 4.0: $_isExaone4Loaded, MedGemma: $_isMedGemmaLoaded');
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
      case LLMModel.exaone4_1B:
        return await _processWithExaone4(request);
      case LLMModel.medGemma4B:
        return await _processWithMedGemma(request);
    }
  }

  LLMModel _selectModel(LLMRequest request) {
    // If offline mode is forced, use available offline models
    if (_currentMode == LLMMode.offline || !_isOnline) {
      // Prioritize EXAONE 4.0 for Korean queries (primary model)
      if (_isExaone4Loaded) {
        return LLMModel.exaone4_1B;
      }
      // MedGemma for medical queries
      if (_isMedGemmaLoaded && _isMedicalQuery(request.message)) {
        return LLMModel.medGemma4B;
      }
      // Fallback to legacy models
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

    // Hybrid mode - intelligent routing with EXAONE 4.0 preference
    if (request.isMultimodal) {
      // MedGemma supports multimodal for medical imaging
      if (_isMedGemmaLoaded && _isMedicalQuery(request.message)) {
        return LLMModel.medGemma4B;
      }
      return LLMModel.gpt4o; // Fallback to cloud for multimodal
    }

    // Medical/health queries -> MedGemma 4B
    if (_isMedGemmaLoaded && _isMedicalQuery(request.message)) {
      return LLMModel.medGemma4B;
    }

    // Very complex queries -> GPT-4o
    if (_isVeryComplexQuery(request.message)) {
      return LLMModel.gpt4o;
    }

    // Default: EXAONE 4.0 for Korean text queries
    if (_isExaone4Loaded) {
      return LLMModel.exaone4_1B;
    }

    // Fallback to legacy models
    if (_isGemmaLoaded) {
      return LLMModel.gemma1B;
    }

    if (_isExaoneLoaded) {
      return LLMModel.exaone24B;
    }

    // Final fallback to cloud
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

  bool _isMedicalQuery(String text) {
    // Detect medical/health-related queries for MedGemma routing
    final medicalIndicators = [
      // Korean medical terms
      '증상', '질병', '통증', '아프', '건강', '병원', '약', '치료',
      '진단', '검사', '의사', '처방', '수술', '환자', '질환',
      '감염', '바이러스', '세균', '알레르기', '면역',
      // Specific health areas
      '혈압', '당뇨', '콜레스테롤', '심장', '간', '신장', '폐',
      '위', '장', '뇌', '두통', '복통', '요통',
      // Symptoms
      '열', '기침', '가래', '숨', '어지러', '메스꺼',
      '구토', '설사', '변비', '피로', '불면',
      // English medical terms
      'symptom', 'disease', 'pain', 'sick', 'health', 'medical',
      'doctor', 'prescription', 'diagnosis', 'treatment',
      'infection', 'virus', 'bacteria', 'allergy',
      'blood pressure', 'diabetes', 'cholesterol',
    ];

    final lowerText = text.toLowerCase();
    return medicalIndicators.any((indicator) =>
      lowerText.contains(indicator.toLowerCase())
    );
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

  Future<LLMResponse> _processWithExaone4(LLMRequest request) async {
    try {
      // Simulate EXAONE 4.0 1.2B processing with hybrid reasoning
      await Future.delayed(const Duration(milliseconds: 400));

      final response = _generateExaone4Response(request.message);

      return LLMResponse(
        response: response,
        usedModel: LLMModel.exaone4_1B,
        confidence: 0.88,
        timestamp: DateTime.now(),
        metadata: {
          'processing_time_ms': 400,
          'model_version': 'exaone-4.0-1.2b-q4',
          'reasoning_mode': 'fast', // or 'deep' based on complexity
        },
      );
    } catch (e) {
      _logger.e('EXAONE 4.0 processing failed: $e');
      rethrow;
    }
  }

  Future<LLMResponse> _processWithMedGemma(LLMRequest request) async {
    try {
      // Simulate MedGemma 4B processing
      await Future.delayed(const Duration(milliseconds: 700));

      final response = _generateMedGemmaResponse(request.message);

      return LLMResponse(
        response: response,
        usedModel: LLMModel.medGemma4B,
        confidence: 0.92,
        timestamp: DateTime.now(),
        metadata: {
          'processing_time_ms': 700,
          'model_version': 'medgemma-4b-q4',
          'specialized_domain': 'medical',
        },
      );
    } catch (e) {
      _logger.e('MedGemma processing failed: $e');
      rethrow;
    }
  }

  String _generateExaone4Response(String message) {
    // Enhanced Korean responses for EXAONE 4.0
    final lowerMessage = message.toLowerCase();

    if (lowerMessage.contains('안녕') || lowerMessage.contains('hello')) {
      return '안녕하세요! EXAONE 4.0 AI 건강 상담사입니다. 🏥\n\n저는 한국어에 특화된 AI로, 건강과 웰빙에 관한 다양한 질문에 답변드릴 수 있습니다. 궁금하신 점이 있으시면 편하게 물어보세요!';
    }

    if (lowerMessage.contains('식단') || lowerMessage.contains('음식') || lowerMessage.contains('칼로리')) {
      return '''EXAONE 4.0이 식단 조언을 드립니다! 🍎

**균형잡힌 식단의 핵심**:
• 탄수화물 50-60%: 현미, 귀리, 통밀 등 복합 탄수화물
• 단백질 15-20%: 생선, 닭가슴살, 두부, 콩류
• 지방 20-30%: 견과류, 아보카도, 올리브오일
• 풍부한 채소와 과일: 하루 5가지 색깔

**추가 팁**:
- 하루 8잔 이상 물 마시기
- 식사는 천천히, 꼭꼭 씹어먹기
- 가공식품 줄이고 자연식품 늘리기

현재 식습관이나 목표를 알려주시면 더 구체적인 조언을 드릴 수 있습니다!''';
    }

    if (lowerMessage.contains('운동') || lowerMessage.contains('헬스') || lowerMessage.contains('근육')) {
      return '''EXAONE 4.0의 운동 가이드입니다! 💪

**초보자를 위한 운동 계획**:
• 빈도: 주 3-4회, 30-45분
• 유산소 운동: 빠른 걷기, 조깅, 자전거, 수영
• 근력 운동: 스쿼트, 푸시업, 플랭크, 런지
• 유연성: 스트레칭, 요가 (매일 10분)

**운동 시 주의사항**:
- 준비운동 5-10분 필수
- 점진적으로 강도 증가
- 통증 느끼면 즉시 중단
- 충분한 휴식과 수분 섭취

현재 체력 수준과 목표를 말씀해주시면 맞춤 계획을 제안해드릴게요!''';
    }

    if (lowerMessage.contains('수면') || lowerMessage.contains('잠') || lowerMessage.contains('불면')) {
      return '''EXAONE 4.0의 수면 개선 가이드입니다! 😴

**좋은 수면을 위한 습관**:
• 규칙적인 수면 시간: 매일 같은 시간에 자고 일어나기
• 수면 환경 조성: 어둡고, 조용하고, 시원한 침실 (18-22°C)
• 취침 전 루틴: 따뜻한 샤워, 가벼운 스트레칭, 독서
• 카페인 제한: 오후 2시 이후 금지
• 디지털 기기: 취침 1시간 전 사용 중단

**수면 시간 권장**:
- 성인: 7-9시간
- 청소년: 8-10시간

지속적인 불면증은 전문의 상담을 권장드립니다. 현재 수면 패턴을 자세히 말씀해주시면 더 도움드릴 수 있어요!''';
    }

    return '''EXAONE 4.0입니다! 😊

건강한 생활을 위해 다음 정보를 알려주시면 더 구체적으로 도와드릴 수 있습니다:

• 현재 고민이나 증상
• 생활 습관 (식단, 운동, 수면)
• 건강 목표

언제든 편하게 질문해주세요!''';
  }

  String _generateMedGemmaResponse(String message) {
    // Medical-specialized responses for MedGemma
    final lowerMessage = message.toLowerCase();

    if (lowerMessage.contains('증상') || lowerMessage.contains('symptom')) {
      return '''MedGemma 의료 AI가 답변드립니다. 🩺

증상에 대해 자세히 말씀해주시면 더 정확한 정보를 제공할 수 있습니다:

**필요한 정보**:
1. 언제부터 증상이 시작되었나요?
2. 어떤 상황에서 증상이 심해지나요?
3. 현재 복용 중인 약이 있나요?
4. 기저 질환이 있으신가요?

**중요**: 저는 의료 정보를 제공하는 AI이지만, 정확한 진단과 치료는 반드시 의료 전문가와 상담하셔야 합니다.

응급 증상(심한 통증, 호흡곤란, 의식 저하 등)이 있다면 즉시 119에 연락하거나 응급실을 방문하세요.''';
    }

    if (lowerMessage.contains('약') || lowerMessage.contains('처방') || lowerMessage.contains('medication')) {
      return '''MedGemma 약물 정보 안내입니다. 💊

**안전한 약물 복용을 위한 원칙**:
• 처방된 용량과 시간 준수
• 임의로 복용 중단하지 않기
• 다른 약과의 상호작용 확인
• 알레르기 반응 주의 깊게 관찰

**약물 복용 시 기억할 점**:
1. 정확한 시간에 복용
2. 충분한 물과 함께 복용
3. 음주와 함께 복용 금지
4. 유통기한 확인

구체적인 약물명을 알려주시면 더 자세한 정보를 제공해드릴 수 있습니다.

**주의**: 약물 변경이나 중단은 반드시 의사와 상의하세요.''';
    }

    if (lowerMessage.contains('검사') || lowerMessage.contains('진단')) {
      return '''MedGemma 건강검진 정보입니다. 🔬

**정기 건강검진 권장 항목**:

**기본 검사** (연 1회):
• 혈압, 혈당, 콜레스테롤
• 간 기능, 신장 기능
• 소변 검사, 흉부 X-ray

**연령별 추가 검사**:
• 30대: 간염, 갑상선 검사
• 40대 이상: 위내시경, 대장내시경
• 50대 이상: 골밀도, 심장 검사

**만성질환 관리**:
당뇨, 고혈압 등이 있다면 3-6개월마다 정기 검사가 필요합니다.

검사 결과에 대한 구체적인 질문이 있으시면 말씀해주세요!''';
    }

    return '''MedGemma 의료 AI입니다. 🏥

전문적인 건강 상담을 위해 다음 중 궁금하신 분야를 선택해주세요:

• 증상 및 질병 정보
• 약물 및 처방 관련
• 건강검진 및 예방
• 만성질환 관리
• 영양 및 생활습관

**면책 고지**: 제공되는 정보는 참고용이며, 실제 진단 및 치료는 의료 전문가와 상담하시기 바랍니다.''';
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

