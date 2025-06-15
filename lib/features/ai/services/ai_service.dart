import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:collection/collection.dart';
import '../../../core/constants/app_constants.dart';
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
        // main 브랜치 로직: 활성 가능한 첫 모델을 선택
        activeModel: availability.entries
            .where((e) => e.value)
            .map((e) => e.key)
            .firstOrNull,
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

      // 인터프리터 로드 (main 브랜치 대체 방식)
      _gemmaInterpreter =
          await Interpreter.fromAsset('assets/models/gemma-1b.tflite');

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

  // ... 이하 생략 (충돌 없는 기존 로직 유지) ...

  @override
  void dispose() {
    _gemmaInterpreter?.close();
    super.dispose();
  }
}

/// AI 서비스 프로바이더
final aiServiceProvider = StateNotifierProvider<AIService, AIServiceState>(
  (ref) {
    final dio = ref.watch(dioProvider);
    final apiService = ref.watch(apiServiceProvider);
    return AIService(dio, apiService);
  },
);

/// 현재 AI 응답 스트림
final aiResponseStreamProvider =
    StreamProvider<AIResponse>((ref) async* {
  // AI 응답을 스트리밍하는 로직
  // WebSocket 또는 Server-Sent Events 사용 가능
});
