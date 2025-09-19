import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/llm/llm_router.dart';
import '../models/chat_models.dart';

// Chat-specific LLM integration provider
final chatLLMProvider = StateNotifierProvider<ChatLLMNotifier, ChatLLMState>((ref) {
  final llmRouter = ref.watch(llmRouterProvider);
  return ChatLLMNotifier(llmRouter);
});

class ChatLLMState {
  final List<ChatMessage> messages;
  final bool isLoading;
  final String? error;
  final LLMModel? lastUsedModel;

  const ChatLLMState({
    this.messages = const [],
    this.isLoading = false,
    this.error,
    this.lastUsedModel,
  });

  ChatLLMState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    String? error,
    LLMModel? lastUsedModel,
  }) {
    return ChatLLMState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      lastUsedModel: lastUsedModel ?? this.lastUsedModel,
    );
  }
}

class ChatLLMNotifier extends StateNotifier<ChatLLMState> {
  final LLMRouter _llmRouter;

  ChatLLMNotifier(this._llmRouter) : super(const ChatLLMState()) {
    _addWelcomeMessage();
  }

  void _addWelcomeMessage() {
    final welcomeMessage = ChatMessage(
      text: '안녕하세요! 저는 SignCare AI 건강 상담사입니다. 🏥\n\n건강과 관련된 궁금한 점이 있으시면 언제든 물어보세요. 식단, 운동, 수면, 스트레스 관리 등 다양한 주제로 도움을 드릴 수 있습니다.',
      isUser: false,
      timestamp: DateTime.now(),
    );

    state = state.copyWith(messages: [welcomeMessage]);
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // Add user message immediately
    final userMessage = ChatMessage(
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      messages: [...state.messages, userMessage],
      isLoading: true,
      error: null,
    );

    try {
      // Create LLM request with health context
      final request = LLMRequest(
        message: text,
        context: _buildHealthContext(),
        metadata: {
          'conversation_id': DateTime.now().millisecondsSinceEpoch.toString(),
          'user_type': 'health_consultation',
        },
      );

      // Process request through LLM Router
      final response = await _llmRouter.processRequest(request);

      // Add AI response
      final aiMessage = ChatMessage(
        text: response.response,
        isUser: false,
        timestamp: response.timestamp,
        modelUsed: response.usedModel,
        confidence: response.confidence,
      );

      state = state.copyWith(
        messages: [...state.messages, aiMessage],
        isLoading: false,
        lastUsedModel: response.usedModel,
      );
    } catch (e) {
      // Add error message
      final errorMessage = ChatMessage(
        text: '죄송합니다. 일시적인 오류가 발생했습니다. 다시 시도해 주세요.',
        isUser: false,
        timestamp: DateTime.now(),
        isError: true,
      );

      state = state.copyWith(
        messages: [...state.messages, errorMessage],
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  String _buildHealthContext() {
    return '''
당신은 SignCare AI 건강 상담사입니다. 다음 지침을 따라 응답해주세요:

1. 친근하고 전문적인 톤으로 응답하세요
2. 건강 관련 정보를 정확하고 신뢰할 수 있게 제공하세요
3. 심각한 증상의 경우 전문의 상담을 권하세요
4. 개인의 건강 상태에 맞는 맞춤형 조언을 제공하세요
5. 한국어로 응답하며, 의료 용어는 쉽게 설명해주세요

주요 상담 영역:
- 식단 관리 및 영양 상담
- 운동 및 체중 관리
- 수면 개선
- 스트레스 관리
- 건강 습관 형성
- 질병 예방

응답 형식:
- 구체적이고 실행 가능한 조언 제공
- 필요시 단계별 가이드 제시
- 관련된 이모지 적절히 사용
- 추가 질문이나 정보가 필요한 경우 안내
''';
  }

  void clearMessages() {
    state = const ChatLLMState();
    _addWelcomeMessage();
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void setLLMMode(LLMMode mode) {
    _llmRouter.setMode(mode);
  }

  void setOnlineStatus(bool isOnline) {
    _llmRouter.setOnlineStatus(isOnline);
  }

  void setModelStatus({bool? gemmaLoaded, bool? exaoneLoaded}) {
    _llmRouter.setModelStatus(
      gemmaLoaded: gemmaLoaded,
      exaoneLoaded: exaoneLoaded,
    );
  }

  // Get current LLM status for UI display
  Map<String, dynamic> getLLMStatus() {
    return {
      'mode': _llmRouter.currentMode,
      'isOnline': _llmRouter.isOnline,
      'gemmaAvailable': _llmRouter.isGemmaAvailable,
      'exaoneAvailable': _llmRouter.isExaoneAvailable,
      'geminiAvailable': _llmRouter.isGeminiAvailable,
      'lastUsedModel': state.lastUsedModel,
    };
  }
}

// Provider for quick action messages
final quickActionProvider = Provider<Map<String, String>>((ref) {
  return {
    '식단 상담': '현재 식단에 대한 조언을 받고 싶어요. 균형잡힌 식사를 위한 팁을 알려주세요.',
    '운동 추천': '제 상황에 맞는 운동 계획을 세워주세요. 어떤 운동을 어떻게 시작하면 좋을까요?',
    '수면 분석': '요즘 잠을 잘 못 자고 있어요. 수면의 질을 개선하는 방법을 알려주세요.',
    '스트레스 관리': '스트레스를 효과적으로 관리하는 방법과 릴렉스하는 방법을 알려주세요.',
    '건강 체크': '전반적인 건강 상태를 체크하고 개선점을 찾고 싶어요.',
  };
});
