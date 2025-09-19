import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import '../llm/llm_router.dart';
import '../cache/ai_cache_service.dart';
import 'user_data_preprocessor.dart';
import 'specialized_prompts.dart';

/// 식단, 운동, 수면, 상담 기능을 위한 통합 AI 서비스
/// Gemma3 모델을 활용하여 각 도메인별 맞춤형 응답 제공
class UnifiedAIService {
  final Logger _logger = Logger();
  final LLMRouter _llmRouter;
  final AICacheService _cacheService;
  final UserDataPreprocessor _dataPreprocessor;
  final SpecializedPrompts _prompts;

  UnifiedAIService({
    required LLMRouter llmRouter,
    required AICacheService cacheService,
    required UserDataPreprocessor dataPreprocessor,
    required SpecializedPrompts prompts,
  })  : _llmRouter = llmRouter,
        _cacheService = cacheService,
        _dataPreprocessor = dataPreprocessor,
        _prompts = prompts;

  /// 식단 추천 생성
  /// [userProfile] 사용자 기본 정보 (연령, 체중, 키, 활동량 등)
  /// [dietaryRestrictions] 알레르기, 금기사항, 선호도
  /// [nutritionalGoals] 영양 목표 (다이어트, 근육증가, 건강유지 등)
  /// [mealType] 아침, 점심, 저녁, 간식
  Future<DietRecommendation> generateDietRecommendation({
    required Map<String, dynamic> userProfile,
    required List<String> dietaryRestrictions,
    required Map<String, dynamic> nutritionalGoals,
    required String mealType,
    String? previousConsultationData,
  }) async {
    try {
      _logger.i('Generating diet recommendation for meal type: $mealType');

      // 1. 캐시 확인
      final cacheKey = _generateCacheKey('diet', {
        'profile': userProfile,
        'restrictions': dietaryRestrictions,
        'goals': nutritionalGoals,
        'mealType': mealType,
      });

      final cachedResult = await _cacheService.get(cacheKey);
      if (cachedResult != null) {
        _logger.i('Returning cached diet recommendation');
        return DietRecommendation.fromJson(cachedResult);
      }

      // 2. 데이터 전처리
      final processedData = await _dataPreprocessor.prepareDietData(
        userProfile: userProfile,
        dietaryRestrictions: dietaryRestrictions,
        nutritionalGoals: nutritionalGoals,
        mealType: mealType,
        consultationHistory: previousConsultationData,
      );

      // 3. 특화된 프롬프트 생성
      final prompt = _prompts.buildDietPrompt(processedData);

      // 4. Gemma3 모델 호출
      final llmRequest = LLMRequest(
        message: prompt,
        context: processedData['context'],
        metadata: {
          'feature': 'diet',
          'mealType': mealType,
          'userId': userProfile['userId'],
        },
      );

      final llmResponse = await _llmRouter.processRequest(llmRequest);

      // 5. 응답 파싱 및 구조화
      final recommendation = await _parseDietResponse(
        llmResponse.response,
        processedData,
      );

      // 6. 캐시 저장 (24시간)
      await _cacheService.set(
        cacheKey,
        recommendation.toJson(),
        duration: const Duration(hours: 24),
      );

      _logger.i('Diet recommendation generated successfully');
      return recommendation;
    } catch (e) {
      _logger.e('Error generating diet recommendation: $e');
      rethrow;
    }
  }

  /// 운동 계획 생성
  /// [userProfile] 사용자 기본 정보
  /// [fitnessLevel] 체력 수준 (초급, 중급, 고급)
  /// [availableTime] 운동 가능 시간
  /// [equipment] 보유 운동기구
  /// [goals] 운동 목표 (근력증가, 체중감량, 지구력향상 등)
  Future<ExerciseRecommendation> generateExerciseRecommendation({
    required Map<String, dynamic> userProfile,
    required String fitnessLevel,
    required Map<String, int> availableTime, // 요일별 시간
    required List<String> equipment,
    required List<String> goals,
    String? previousConsultationData,
  }) async {
    try {
      _logger.i('Generating exercise recommendation for fitness level: $fitnessLevel');

      final cacheKey = _generateCacheKey('exercise', {
        'profile': userProfile,
        'level': fitnessLevel,
        'time': availableTime,
        'equipment': equipment,
        'goals': goals,
      });

      final cachedResult = await _cacheService.get(cacheKey);
      if (cachedResult != null) {
        _logger.i('Returning cached exercise recommendation');
        return ExerciseRecommendation.fromJson(cachedResult);
      }

      final processedData = await _dataPreprocessor.prepareExerciseData(
        userProfile: userProfile,
        fitnessLevel: fitnessLevel,
        availableTime: availableTime,
        equipment: equipment,
        goals: goals,
        consultationHistory: previousConsultationData,
      );

      final prompt = _prompts.buildExercisePrompt(processedData);

      final llmRequest = LLMRequest(
        message: prompt,
        context: processedData['context'],
        metadata: {
          'feature': 'exercise',
          'fitnessLevel': fitnessLevel,
          'userId': userProfile['userId'],
        },
      );

      final llmResponse = await _llmRouter.processRequest(llmRequest);

      final recommendation = await _parseExerciseResponse(
        llmResponse.response,
        processedData,
      );

      await _cacheService.set(
        cacheKey,
        recommendation.toJson(),
        duration: const Duration(days: 7), // 주간 계획이므로 1주일 캐시
      );

      _logger.i('Exercise recommendation generated successfully');
      return recommendation;
    } catch (e) {
      _logger.e('Error generating exercise recommendation: $e');
      rethrow;
    }
  }

  /// 수면 개선 방안 생성
  /// [userProfile] 사용자 기본 정보
  /// [sleepPatterns] 수면 패턴 데이터
  /// [sleepIssues] 수면 문제점
  /// [lifestyle] 생활 패턴 정보
  Future<SleepRecommendation> generateSleepRecommendation({
    required Map<String, dynamic> userProfile,
    required Map<String, dynamic> sleepPatterns,
    required List<String> sleepIssues,
    required Map<String, dynamic> lifestyle,
    String? previousConsultationData,
  }) async {
    try {
      _logger.i('Generating sleep recommendation for issues: $sleepIssues');

      final cacheKey = _generateCacheKey('sleep', {
        'profile': userProfile,
        'patterns': sleepPatterns,
        'issues': sleepIssues,
        'lifestyle': lifestyle,
      });

      final cachedResult = await _cacheService.get(cacheKey);
      if (cachedResult != null) {
        _logger.i('Returning cached sleep recommendation');
        return SleepRecommendation.fromJson(cachedResult);
      }

      final processedData = await _dataPreprocessor.prepareSleepData(
        userProfile: userProfile,
        sleepPatterns: sleepPatterns,
        sleepIssues: sleepIssues,
        lifestyle: lifestyle,
        consultationHistory: previousConsultationData,
      );

      final prompt = _prompts.buildSleepPrompt(processedData);

      final llmRequest = LLMRequest(
        message: prompt,
        context: processedData['context'],
        metadata: {
          'feature': 'sleep',
          'issues': sleepIssues,
          'userId': userProfile['userId'],
        },
      );

      final llmResponse = await _llmRouter.processRequest(llmRequest);

      final recommendation = await _parseSleepResponse(
        llmResponse.response,
        processedData,
      );

      await _cacheService.set(
        cacheKey,
        recommendation.toJson(),
        duration: const Duration(days: 3), // 수면 패턴은 자주 변하므로 3일 캐시
      );

      _logger.i('Sleep recommendation generated successfully');
      return recommendation;
    } catch (e) {
      _logger.e('Error generating sleep recommendation: $e');
      rethrow;
    }
  }

  /// 건강 상담 (기존 기능 확장)
  Future<ConsultationRecommendation> generateHealthConsultation({
    required String userMessage,
    required Map<String, dynamic> userProfile,
    String? conversationHistory,
  }) async {
    try {
      _logger.i('Generating health consultation');

      final cacheKey = _generateCacheKey('consultation', {
        'message': userMessage,
        'profile': userProfile,
      });

      // 상담은 실시간성이 중요하므로 짧은 캐시 시간 (1시간)
      final cachedResult = await _cacheService.get(cacheKey);
      if (cachedResult != null) {
        final cached = ConsultationRecommendation.fromJson(cachedResult);
        // 캐시된 결과가 1시간 이내인 경우만 사용
        if (DateTime.now().difference(cached.timestamp).inHours < 1) {
          _logger.i('Returning cached consultation');
          return cached;
        }
      }

      final processedData = await _dataPreprocessor.prepareConsultationData(
        userMessage: userMessage,
        userProfile: userProfile,
        conversationHistory: conversationHistory,
      );

      final prompt = _prompts.buildConsultationPrompt(processedData);

      final llmRequest = LLMRequest(
        message: prompt,
        context: processedData['context'],
        metadata: {
          'feature': 'consultation',
          'userId': userProfile['userId'],
        },
      );

      final llmResponse = await _llmRouter.processRequest(llmRequest);

      final recommendation = await _parseConsultationResponse(
        llmResponse.response,
        processedData,
      );

      await _cacheService.set(
        cacheKey,
        recommendation.toJson(),
        duration: const Duration(hours: 1),
      );

      _logger.i('Health consultation generated successfully');
      return recommendation;
    } catch (e) {
      _logger.e('Error generating health consultation: $e');
      rethrow;
    }
  }

  String _generateCacheKey(String feature, Map<String, dynamic> params) {
    final keyData = {
      'feature': feature,
      'params': params,
    };
    return 'ai_${feature}_${keyData.hashCode.abs()}';
  }

  Future<DietRecommendation> _parseDietResponse(
    String response,
    Map<String, dynamic> processedData,
  ) async {
    // AI 응답을 파싱하여 구조화된 식단 추천으로 변환
    // TODO: JSON 파싱 로직 구현
    return DietRecommendation(
      mealType: processedData['mealType'],
      recommendations: response,
      nutritionalInfo: {},
      timestamp: DateTime.now(),
    );
  }

  Future<ExerciseRecommendation> _parseExerciseResponse(
    String response,
    Map<String, dynamic> processedData,
  ) async {
    // AI 응답을 파싱하여 구조화된 운동 계획으로 변환
    return ExerciseRecommendation(
      weeklyPlan: response,
      exercises: [],
      duration: processedData['totalTime'] ?? 0,
      timestamp: DateTime.now(),
    );
  }

  Future<SleepRecommendation> _parseSleepResponse(
    String response,
    Map<String, dynamic> processedData,
  ) async {
    // AI 응답을 파싱하여 구조화된 수면 개선 방안으로 변환
    return SleepRecommendation(
      recommendations: response,
      sleepSchedule: {},
      improvementTips: [],
      timestamp: DateTime.now(),
    );
  }

  Future<ConsultationRecommendation> _parseConsultationResponse(
    String response,
    Map<String, dynamic> processedData,
  ) async {
    // AI 응답을 파싱하여 구조화된 상담 결과로 변환
    return ConsultationRecommendation(
      response: response,
      followUpSuggestions: [],
      relatedTopics: [],
      timestamp: DateTime.now(),
    );
  }
}

/// 식단 추천 결과
class DietRecommendation {
  final String mealType;
  final String recommendations;
  final Map<String, dynamic> nutritionalInfo;
  final DateTime timestamp;

  DietRecommendation({
    required this.mealType,
    required this.recommendations,
    required this.nutritionalInfo,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'mealType': mealType,
        'recommendations': recommendations,
        'nutritionalInfo': nutritionalInfo,
        'timestamp': timestamp.toIso8601String(),
      };

  factory DietRecommendation.fromJson(Map<String, dynamic> json) =>
      DietRecommendation(
        mealType: json['mealType'],
        recommendations: json['recommendations'],
        nutritionalInfo: json['nutritionalInfo'],
        timestamp: DateTime.parse(json['timestamp']),
      );
}

/// 운동 계획 결과
class ExerciseRecommendation {
  final String weeklyPlan;
  final List<Map<String, dynamic>> exercises;
  final int duration;
  final DateTime timestamp;

  ExerciseRecommendation({
    required this.weeklyPlan,
    required this.exercises,
    required this.duration,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'weeklyPlan': weeklyPlan,
        'exercises': exercises,
        'duration': duration,
        'timestamp': timestamp.toIso8601String(),
      };

  factory ExerciseRecommendation.fromJson(Map<String, dynamic> json) =>
      ExerciseRecommendation(
        weeklyPlan: json['weeklyPlan'],
        exercises: List<Map<String, dynamic>>.from(json['exercises']),
        duration: json['duration'],
        timestamp: DateTime.parse(json['timestamp']),
      );
}

/// 수면 개선 방안 결과
class SleepRecommendation {
  final String recommendations;
  final Map<String, dynamic> sleepSchedule;
  final List<String> improvementTips;
  final DateTime timestamp;

  SleepRecommendation({
    required this.recommendations,
    required this.sleepSchedule,
    required this.improvementTips,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'recommendations': recommendations,
        'sleepSchedule': sleepSchedule,
        'improvementTips': improvementTips,
        'timestamp': timestamp.toIso8601String(),
      };

  factory SleepRecommendation.fromJson(Map<String, dynamic> json) =>
      SleepRecommendation(
        recommendations: json['recommendations'],
        sleepSchedule: json['sleepSchedule'],
        improvementTips: List<String>.from(json['improvementTips']),
        timestamp: DateTime.parse(json['timestamp']),
      );
}

/// 상담 결과
class ConsultationRecommendation {
  final String response;
  final List<String> followUpSuggestions;
  final List<String> relatedTopics;
  final DateTime timestamp;

  ConsultationRecommendation({
    required this.response,
    required this.followUpSuggestions,
    required this.relatedTopics,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'response': response,
        'followUpSuggestions': followUpSuggestions,
        'relatedTopics': relatedTopics,
        'timestamp': timestamp.toIso8601String(),
      };

  factory ConsultationRecommendation.fromJson(Map<String, dynamic> json) =>
      ConsultationRecommendation(
        response: json['response'],
        followUpSuggestions: List<String>.from(json['followUpSuggestions']),
        relatedTopics: List<String>.from(json['relatedTopics']),
        timestamp: DateTime.parse(json['timestamp']),
      );
}

// Riverpod Provider
final unifiedAIServiceProvider = Provider<UnifiedAIService>((ref) {
  final llmRouter = ref.watch(llmRouterProvider);
  final cacheService = ref.watch(aiCacheServiceProvider);
  final dataPreprocessor = ref.watch(userDataPreprocessorProvider);
  final prompts = ref.watch(specializedPromptsProvider);

  return UnifiedAIService(
    llmRouter: llmRouter,
    cacheService: cacheService,
    dataPreprocessor: dataPreprocessor,
    prompts: prompts,
  );
});