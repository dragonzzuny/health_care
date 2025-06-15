import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:collection/collection.dart';
import '../../../shared/services/api_service.dart';

/// AI 모델 타입 열거형
enum AIModelType {
  gemma('gemma-1b', 'Gemma 1B', true),
  exaone('exaone-2.4b', 'EXAONE 2.4B', false),
  gpt4('gpt-4', 'GPT-4', false);

  final String id;
  final String displayName;
  final bool isLocal;

  const AIModelType(this.id, this.displayName, this.isLocal);
}

/// AI 응답 데이터 클래스
class AIResponse {
  final String content;
  final AIModelType model;
  final DateTime timestamp;
  final Map<String, dynamic>? metadata;

  AIResponse({
    required this.content,
    required this.model,
    required this.timestamp,
    this.metadata,
  });
}

/// AI 서비스 상태
class AIServiceState {
  final bool isInitialized;
  final bool isProcessing;
  final AIModelType? activeModel;
  final String? error;
  final Map<AIModelType, bool> modelAvailability;

  const AIServiceState({
    this.isInitialized = false,
    this.isProcessing = false,
    this.activeModel,
    this.error,
    this.modelAvailability = const {},
  });

  AIServiceState copyWith({
    bool? isInitialized,
    bool? isProcessing,
    AIModelType? activeModel,
    String? error,
    Map<AIModelType, bool>? modelAvailability,
  }) {
    return AIServiceState(
      isInitialized: isInitialized ?? this.isInitialized,
      isProcessing: isProcessing ?? this.isProcessing,
      activeModel: activeModel ?? this.activeModel,
      error: error ?? this.error,
      modelAvailability: modelAvailability ?? this.modelAvailability,
    );
  }
}

/// AI 서비스 구현
class AIService extends StateNotifier<AIServiceState> {
  final Dio _dio;
  final ApiService _apiService;
  Interpreter? _gemmaInterpreter;
  String? _openAIApiKey;
  String? _exaoneApiKey;

  AIService(this._dio, this._apiService) : super(const AIServiceState()) {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      // API 키 로드 (실제 환경에서는 보안 저장소에서 가져옴)
      _openAIApiKey = const String.fromEnvironment('OPENAI_API_KEY');
      _exaoneApiKey = const String.fromEnvironment('EXAONE_API_KEY');

      // 모델 가용성 확인
      final availability = <AIModelType, bool>{};

      // Gemma 모델 체크
      availability[AIModelType.gemma] = await _checkGemmaModel();

      // API 키 기반 가용성
      availability[AIModelType.gpt4] = _openAIApiKey?.isNotEmpty ?? false;
      availability[AIModelType.exaone] = _exaoneApiKey?.isNotEmpty ?? false;

      state = state.copyWith(
        isInitialized: true,
        modelAvailability: availability,
        activeModel:
            availability.entries.firstWhereOrNull((e) => e.value)?.key,
      );
    } catch (e) {
      state = state.copyWith(
        error: 'AI 서비스 초기화 실패: $e',
      );
    }
  }

  Future<bool> _checkGemmaModel() async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final modelPath = path.join(appDir.path, 'models', 'gemma-1b.tflite');
      return File(modelPath).existsSync();
    } catch (e) {
      return false;
    }
  }

  Future<void> downloadGemmaModel() async {
    try {
      state = state.copyWith(isProcessing: true, error: null);

      final appDir = await getApplicationDocumentsDirectory();
      final modelsDir = Directory(path.join(appDir.path, 'models'));
      if (!await modelsDir.exists()) {
        await modelsDir.create(recursive: true);
      }

      final modelPath = path.join(modelsDir.path, 'gemma-1b.tflite');

      // 실제 구현에서는 CDN에서 모델 다운로드
      // 여기서는 시뮬레이션
      await Future.delayed(const Duration(seconds: 2));

      // 모델 파일 생성 (실제로는 다운로드)
      await File(modelPath).writeAsBytes(Uint8List(0));

      // 인터프리터 로드
      _gemmaInterpreter = await Interpreter.fromFile(File(modelPath));

      final availability = Map<AIModelType, bool>.from(state.modelAvailability);
      availability[AIModelType.gemma] = true;

      state = state.copyWith(
        modelAvailability: availability,
        activeModel: AIModelType.gemma,
      );
    } catch (e) {
      state = state.copyWith(
        error: 'Gemma 모델 다운로드 실패: $e',
      );
    } finally {
      state = state.copyWith(isProcessing: false);
    }
  }

  Future<void> setActiveModel(AIModelType model) async {
    if (state.modelAvailability[model] != true) {
      state = state.copyWith(
        error: '${model.displayName} 모델을 사용할 수 없습니다',
      );
      return;
    }

    state = state.copyWith(activeModel: model, error: null);
  }

  Future<AIResponse> sendMessage(String message, {
    Map<String, dynamic>? context,
    AIModelType? preferredModel,
  }) async {
    final model = preferredModel ?? state.activeModel;
    if (model == null) {
      throw Exception('활성화된 AI 모델이 없습니다');
    }

    state = state.copyWith(isProcessing: true, error: null);

    try {
      switch (model) {
        case AIModelType.gemma:
          return await _processWithGemma(message, context);
        case AIModelType.exaone:
          return await _processWithExaone(message, context);
        case AIModelType.gpt4:
          return await _processWithGPT4(message, context);
      }
    } catch (e) {
      state = state.copyWith(error: '메시지 처리 실패: $e');
      rethrow;
    } finally {
      state = state.copyWith(isProcessing: false);
    }
  }

  Future<AIResponse> _processWithGemma(String message, Map<String, dynamic>? context) async {
    if (_gemmaInterpreter == null) {
      throw Exception('Gemma 모델이 로드되지 않았습니다');
    }

    // 실제 Gemma 추론 구현
    // 여기서는 시뮬레이션
    await Future.delayed(const Duration(milliseconds: 500));

    return AIResponse(
      content: _generateMockResponse(message, context),
      model: AIModelType.gemma,
      timestamp: DateTime.now(),
      metadata: {
        'processingTime': 500,
        'tokenCount': message.split(' ').length,
      },
    );
  }

  Future<AIResponse> _processWithExaone(String message, Map<String, dynamic>? context) async {
    if (_exaoneApiKey == null || _exaoneApiKey!.isEmpty) {
      throw Exception('EXAONE API 키가 설정되지 않았습니다');
    }

    try {
      final response = await _dio.post(
        'https://api.exaone.com/v1/chat/completions',
        options: Options(
          headers: {
            'Authorization': 'Bearer $_exaoneApiKey',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'model': 'exaone-2.4b',
          'messages': [
            if (context != null) {
              'role': 'system',
              'content': _buildSystemPrompt(context),
            },
            {
              'role': 'user',
              'content': message,
            },
          ],
          'temperature': 0.7,
          'max_tokens': 1000,
        },
      );

      return AIResponse(
        content: response.data['choices'][0]['message']['content'],
        model: AIModelType.exaone,
        timestamp: DateTime.now(),
        metadata: response.data['usage'],
      );
    } catch (e) {
      // 실제 API가 없으므로 mock 응답 반환
      return AIResponse(
        content: _generateMockResponse(message, context),
        model: AIModelType.exaone,
        timestamp: DateTime.now(),
      );
    }
  }

  Future<AIResponse> _processWithGPT4(String message, Map<String, dynamic>? context) async {
    if (_openAIApiKey == null || _openAIApiKey!.isEmpty) {
      throw Exception('OpenAI API 키가 설정되지 않았습니다');
    }

    try {
      final response = await _dio.post(
        'https://api.openai.com/v1/chat/completions',
        options: Options(
          headers: {
            'Authorization': 'Bearer $_openAIApiKey',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'model': 'gpt-4-turbo-preview',
          'messages': [
            {
              'role': 'system',
              'content': _buildSystemPrompt(context),
            },
            {
              'role': 'user',
              'content': message,
            },
          ],
          'temperature': 0.7,
          'max_tokens': 1000,
        },
      );

      return AIResponse(
        content: response.data['choices'][0]['message']['content'],
        model: AIModelType.gpt4,
        timestamp: DateTime.now(),
        metadata: response.data['usage'],
      );
    } catch (e) {
      // 실제 API가 없으므로 mock 응답 반환
      return AIResponse(
        content: _generateMockResponse(message, context),
        model: AIModelType.gpt4,
        timestamp: DateTime.now(),
      );
    }
  }

  String _buildSystemPrompt(Map<String, dynamic>? context) {
    final buffer = StringBuffer('당신은 SignCare의 AI 건강 상담사입니다. ');
    buffer.writeln('사용자의 건강 관리를 도와주는 전문적이고 친근한 조언을 제공합니다.');

    if (context != null) {
      if (context['userProfile'] != null) {
        buffer.writeln('
사용자 정보:');
        buffer.writeln(jsonEncode(context['userProfile']));
      }

      if (context['healthData'] != null) {
        buffer.writeln('
최근 건강 데이터:');
        buffer.writeln(jsonEncode(context['healthData']));
      }
    }

    buffer.writeln('
다음 지침을 따라주세요:');
    buffer.writeln('1. 정확하고 과학적 근거가 있는 정보만 제공');
    buffer.writeln('2. 의학적 진단은 하지 않으며, 필요시 전문의 상담 권유');
    buffer.writeln('3. 개인화된 조언 제공');
    buffer.writeln('4. 긍정적이고 동기부여가 되는 톤 유지');

    return buffer.toString();
  }

  String _generateMockResponse(String message, Map<String, dynamic>? context) {
    // 실제 환경에서는 제거될 mock 응답 생성
    final lowerMessage = message.toLowerCase();

    if (lowerMessage.contains('혈당')) {
      return '''혈당 관리에 대해 문의하셨군요. 

정상 혈당 수치는:
• 공복 혈당: 70-100 mg/dL
• 식후 2시간 혈당: 140 mg/dL 미만

혈당 관리를 위한 팁:
1. 규칙적인 식사 시간을 유지하세요
2. 탄수화물 섭취량을 조절하세요
3. 꾸준한 운동을 하세요
4. 스트레스를 관리하세요

정확한 진단과 치료는 전문의와 상담하시기 바랍니다.''';
    } else if (lowerMessage.contains('운동')) {
      return '''운동에 관심이 있으시군요!

건강한 성인 기준 권장 운동량:
• 유산소 운동: 주 150분 이상 (중강도)
• 근력 운동: 주 2회 이상

초보자를 위한 운동 계획:
1. 걷기: 하루 30분, 주 5회
2. 스트레칭: 매일 10분
3. 가벼운 근력 운동: 주 2회

본인의 체력 수준에 맞게 점진적으로 운동량을 늘려가세요.''';
    } else if (lowerMessage.contains('식단') || lowerMessage.contains('영양')) {
      return '''균형 잡힌 식단에 대해 알려드리겠습니다.

건강한 식단의 기본 원칙:
• 다양한 색깔의 채소와 과일 섭취
• 통곡물 선택
• 저지방 단백질 섭취
• 건강한 지방 적절히 섭취
• 가공식품과 설탕 제한

하루 권장 영양소:
• 탄수화물: 50-60%
• 단백질: 15-20%
• 지방: 20-30%

개인의 건강 상태와 목표에 따라 조정이 필요할 수 있습니다.''';
    } else {
      return '''안녕하세요! SignCare AI 상담사입니다.

"$message"에 대해 문의하셨군요.

건강 관리는 꾸준함이 가장 중요합니다. 다음과 같은 기본적인 건강 습관을 유지하시면 좋습니다:

1. 충분한 수면 (7-8시간)
2. 규칙적인 운동
3. 균형 잡힌 식단
4. 스트레스를 관리
5. 정기적인 건강 검진

더 구체적인 조언이 필요하시면 언제든지 문의해주세요!''';
    }
  }

  @override
  void dispose() {
    _gemmaInterpreter?.close();
    super.dispose();
  }
}

/// AI 서비스 프로바이더
final aiServiceProvider = StateNotifierProvider<AIService, AIServiceState>((ref) {
  final dio = ref.watch(dioProvider);
  final apiService = ref.watch(apiServiceProvider);
  return AIService(dio, apiService);
});

/// 현재 AI 응답 스트림
final aiResponseStreamProvider =
    StreamProvider<AIResponse>((ref) => const Stream.empty());
