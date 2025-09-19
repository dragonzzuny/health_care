import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import '../../core/ai/unified_ai_service.dart';

/// 각 페이지에서 AI 기능을 쉽게 사용할 수 있도록 하는 통합 레이어
/// 식단, 운동, 수면, 상담 페이지에서 공통으로 사용하는 AI 인터페이스 제공
class AIIntegrationLayer {
  final Logger _logger = Logger();
  final UnifiedAIService _aiService;

  AIIntegrationLayer({required UnifiedAIService aiService})
      : _aiService = aiService;

  // ========== 식단 페이지 통합 ==========

  /// 식단 페이지에서 사용하는 AI 추천 기능
  Future<DietPageResult> getDietRecommendations({
    required String userId,
    required String mealType,
    Map<String, dynamic>? userPreferences,
    List<String>? allergies,
    String? healthGoal,
  }) async {
    try {
      _logger.i('Getting diet recommendations for user: $userId, meal: $mealType');

      // 사용자 프로필 구성
      final userProfile = await _buildUserProfile(userId, userPreferences);
      
      // 식이 제한사항 처리
      final restrictions = _processDietaryRestrictions(allergies, userPreferences);
      
      // 영양 목표 설정
      final nutritionalGoals = _buildNutritionalGoals(healthGoal, userProfile);

      // AI 서비스 호출
      final recommendation = await _aiService.generateDietRecommendation(
        userProfile: userProfile,
        dietaryRestrictions: restrictions,
        nutritionalGoals: nutritionalGoals,
        mealType: mealType,
      );

      return DietPageResult.success(
        recommendation: recommendation,
        mealType: mealType,
        timestamp: DateTime.now(),
      );

    } catch (e) {
      _logger.e('Error getting diet recommendations: $e');
      return DietPageResult.error('식단 추천을 가져오는 중 오류가 발생했습니다: $e');
    }
  }

  /// 식단 분석 기능
  Future<DietAnalysisResult> analyzeMeal({
    required String userId,
    required List<String> foodItems,
    required String mealType,
    Map<String, double>? portions,
  }) async {
    try {
      _logger.i('Analyzing meal for user: $userId');

      // 음식 데이터 전처리
      final mealData = _preprocessMealData(foodItems, portions);
      
      // 영양 분석을 위한 프롬프트 생성
      final analysisPrompt = _buildMealAnalysisPrompt(mealData, mealType);
      
      // AI 분석 수행
      final userProfile = await _buildUserProfile(userId, null);
      final consultation = await _aiService.generateHealthConsultation(
        userMessage: analysisPrompt,
        userProfile: userProfile,
      );

      return DietAnalysisResult.success(
        analysis: consultation.response,
        nutritionalBreakdown: mealData,
        suggestions: consultation.followUpSuggestions,
      );

    } catch (e) {
      _logger.e('Error analyzing meal: $e');
      return DietAnalysisResult.error('식단 분석 중 오류가 발생했습니다: $e');
    }
  }

  // ========== 운동 페이지 통합 ==========

  /// 운동 페이지에서 사용하는 AI 계획 기능
  Future<ExercisePageResult> getExercisePlan({
    required String userId,
    required String fitnessLevel,
    required Map<String, int> weeklyAvailability,
    List<String>? equipment,
    List<String>? goals,
    Map<String, dynamic>? physicalLimitations,
  }) async {
    try {
      _logger.i('Getting exercise plan for user: $userId, level: $fitnessLevel');

      // 사용자 프로필 구성
      final userProfile = await _buildUserProfile(userId, physicalLimitations);
      
      // 운동 목표 처리
      final exerciseGoals = goals ?? ['general_fitness'];
      
      // 장비 목록 처리
      final availableEquipment = equipment ?? [];

      // AI 서비스 호출
      final recommendation = await _aiService.generateExerciseRecommendation(
        userProfile: userProfile,
        fitnessLevel: fitnessLevel,
        availableTime: weeklyAvailability,
        equipment: availableEquipment,
        goals: exerciseGoals,
      );

      return ExercisePageResult.success(
        recommendation: recommendation,
        fitnessLevel: fitnessLevel,
        weeklyCommitment: weeklyAvailability.values.fold(0, (a, b) => a + b),
        timestamp: DateTime.now(),
      );

    } catch (e) {
      _logger.e('Error getting exercise plan: $e');
      return ExercisePageResult.error('운동 계획을 가져오는 중 오류가 발생했습니다: $e');
    }
  }

  /// 운동 기록 분석 기능
  Future<ExerciseAnalysisResult> analyzeWorkout({
    required String userId,
    required List<Map<String, dynamic>> workoutData,
    String? userFeedback,
  }) async {
    try {
      _logger.i('Analyzing workout for user: $userId');

      // 운동 데이터 전처리
      final analysisPrompt = _buildWorkoutAnalysisPrompt(workoutData, userFeedback);
      
      // AI 분석 수행
      final userProfile = await _buildUserProfile(userId, null);
      final consultation = await _aiService.generateHealthConsultation(
        userMessage: analysisPrompt,
        userProfile: userProfile,
      );

      return ExerciseAnalysisResult.success(
        analysis: consultation.response,
        workoutSummary: _summarizeWorkout(workoutData),
        improvements: consultation.followUpSuggestions,
      );

    } catch (e) {
      _logger.e('Error analyzing workout: $e');
      return ExerciseAnalysisResult.error('운동 분석 중 오류가 발생했습니다: $e');
    }
  }

  // ========== 수면 페이지 통합 ==========

  /// 수면 페이지에서 사용하는 AI 분석 기능
  Future<SleepPageResult> getSleepAnalysis({
    required String userId,
    required Map<String, dynamic> sleepData,
    List<String>? sleepIssues,
    Map<String, dynamic>? lifestyleFactors,
  }) async {
    try {
      _logger.i('Getting sleep analysis for user: $userId');

      // 사용자 프로필 구성
      final userProfile = await _buildUserProfile(userId, lifestyleFactors);
      
      // 수면 패턴 분석
      final sleepPatterns = _processSleepData(sleepData);
      
      // 수면 문제 목록 처리
      final issues = sleepIssues ?? [];
      
      // 생활 패턴 정보 구성
      final lifestyle = lifestyleFactors ?? {};

      // AI 서비스 호출
      final recommendation = await _aiService.generateSleepRecommendation(
        userProfile: userProfile,
        sleepPatterns: sleepPatterns,
        sleepIssues: issues,
        lifestyle: lifestyle,
      );

      return SleepPageResult.success(
        recommendation: recommendation,
        sleepQuality: _calculateSleepQuality(sleepPatterns),
        timestamp: DateTime.now(),
      );

    } catch (e) {
      _logger.e('Error getting sleep analysis: $e');
      return SleepPageResult.error('수면 분석을 가져오는 중 오류가 발생했습니다: $e');
    }
  }

  /// 수면 개선 제안 기능
  Future<SleepImprovementResult> getSleepImprovementSuggestions({
    required String userId,
    required String primaryIssue,
    Map<String, dynamic>? currentHabits,
  }) async {
    try {
      _logger.i('Getting sleep improvement suggestions for: $primaryIssue');

      // 개선 제안을 위한 프롬프트 생성
      final improvementPrompt = _buildSleepImprovementPrompt(primaryIssue, currentHabits);
      
      // AI 상담 수행
      final userProfile = await _buildUserProfile(userId, currentHabits);
      final consultation = await _aiService.generateHealthConsultation(
        userMessage: improvementPrompt,
        userProfile: userProfile,
      );

      return SleepImprovementResult.success(
        suggestions: consultation.response,
        actionItems: consultation.followUpSuggestions,
        relatedTopics: consultation.relatedTopics,
      );

    } catch (e) {
      _logger.e('Error getting sleep improvement suggestions: $e');
      return SleepImprovementResult.error('수면 개선 제안을 가져오는 중 오류가 발생했습니다: $e');
    }
  }

  // ========== 상담 페이지 통합 (기존 확장) ==========

  /// 향상된 건강 상담 기능
  Future<ConsultationPageResult> getEnhancedConsultation({
    required String userId,
    required String userQuestion,
    String? conversationHistory,
    Map<String, dynamic>? contextData,
  }) async {
    try {
      _logger.i('Getting enhanced consultation for user: $userId');

      // 사용자 프로필 구성
      final userProfile = await _buildUserProfile(userId, contextData);
      
      // 컨텍스트 데이터 통합
      final enhancedProfile = _enhanceProfileWithContext(userProfile, contextData);

      // AI 상담 수행
      final consultation = await _aiService.generateHealthConsultation(
        userMessage: userQuestion,
        userProfile: enhancedProfile,
        conversationHistory: conversationHistory,
      );

      return ConsultationPageResult.success(
        consultation: consultation,
        relatedFeatures: _identifyRelatedFeatures(userQuestion),
        timestamp: DateTime.now(),
      );

    } catch (e) {
      _logger.e('Error getting enhanced consultation: $e');
      return ConsultationPageResult.error('상담을 가져오는 중 오류가 발생했습니다: $e');
    }
  }

  // ========== 공통 유틸리티 메서드들 ==========

  Future<Map<String, dynamic>> _buildUserProfile(
    String userId,
    Map<String, dynamic>? additionalData,
  ) async {
    // TODO: 실제 구현에서는 데이터베이스나 사용자 프로필 서비스에서 가져오기
    final baseProfile = {
      'userId': userId,
      'age': 30,
      'gender': 'unknown',
      'weight': 70.0,
      'height': 170.0,
      'activityLevel': 'moderate',
      'conditions': <String>[],
      'medications': <String>[],
    };

    if (additionalData != null) {
      additionalData.forEach((key, value) {
        if (key is String) {
          baseProfile[key] = value;
        }
      });
    }

    return baseProfile;
  }

  List<String> _processDietaryRestrictions(
    List<String>? allergies,
    Map<String, dynamic>? preferences,
  ) {
    final restrictions = <String>[];
    
    if (allergies != null) {
      restrictions.addAll(allergies);
    }
    
    if (preferences != null) {
      if (preferences['vegetarian'] == true) restrictions.add('채식주의');
      if (preferences['vegan'] == true) restrictions.add('비건');
      if (preferences['glutenFree'] == true) restrictions.add('글루텐 프리');
      if (preferences['dairyFree'] == true) restrictions.add('유제품 프리');
    }
    
    return restrictions;
  }

  Map<String, dynamic> _buildNutritionalGoals(
    String? healthGoal,
    Map<String, dynamic> userProfile,
  ) {
    switch (healthGoal) {
      case 'weight_loss':
        return {'type': 'weight_loss', 'calorie_deficit': 500};
      case 'muscle_gain':
        return {'type': 'muscle_gain', 'protein_emphasis': true};
      case 'maintenance':
        return {'type': 'maintain', 'balanced': true};
      default:
        return {'type': 'maintain', 'balanced': true};
    }
  }

  Map<String, dynamic> _preprocessMealData(
    List<String> foodItems,
    Map<String, double>? portions,
  ) {
    return {
      'foods': foodItems,
      'portions': portions ?? {},
      'estimatedCalories': foodItems.length * 150, // 임시 추정
    };
  }

  String _buildMealAnalysisPrompt(
    Map<String, dynamic> mealData,
    String mealType,
  ) {
    return '''
다음 ${mealType} 식단을 분석해주세요:
음식: ${mealData['foods'].join(', ')}
분량: ${mealData['portions']}

영양학적 평가와 개선점을 알려주세요.
''';
  }

  String _buildWorkoutAnalysisPrompt(
    List<Map<String, dynamic>> workoutData,
    String? feedback,
  ) {
    final workoutSummary = workoutData.map((w) => 
      '${w['exercise']}: ${w['sets']}세트 ${w['reps']}회'
    ).join(', ');
    
    return '''
다음 운동을 분석해주세요:
$workoutSummary

사용자 피드백: ${feedback ?? '없음'}

운동 효과와 개선점을 알려주세요.
''';
  }

  Map<String, dynamic> _processSleepData(Map<String, dynamic> sleepData) {
    return {
      'averageSleepHours': sleepData['sleepHours'] ?? 7.0,
      'averageBedtime': sleepData['bedtime'] ?? '23:00',
      'averageWakeTime': sleepData['wakeTime'] ?? '07:00',
      'sleepEfficiency': sleepData['efficiency'] ?? 85.0,
      'nightWakings': sleepData['wakings'] ?? 0,
    };
  }

  String _buildSleepImprovementPrompt(
    String primaryIssue,
    Map<String, dynamic>? habits,
  ) {
    return '''
주요 수면 문제: $primaryIssue
현재 수면 습관: ${habits ?? '정보 없음'}

이 문제에 대한 구체적인 개선 방안을 제시해주세요.
''';
  }

  double _calculateSleepQuality(Map<String, dynamic> sleepPatterns) {
    final sleepHours = sleepPatterns['averageSleepHours'] as double;
    final efficiency = sleepPatterns['sleepEfficiency'] as double;
    
    // 간단한 수면 질 점수 계산
    final hoursScore = (sleepHours >= 7 && sleepHours <= 9) ? 50 : 30;
    final efficiencyScore = efficiency * 0.5;
    
    return (hoursScore + efficiencyScore).clamp(0, 100);
  }

  Map<String, dynamic> _summarizeWorkout(List<Map<String, dynamic>> workoutData) {
    final totalExercises = workoutData.length;
    final totalSets = workoutData.fold(0, (sum, w) => sum + (w['sets'] as int));
    final avgReps = workoutData.isNotEmpty 
        ? workoutData.fold(0, (sum, w) => sum + (w['reps'] as int)) / totalExercises
        : 0;
    
    return {
      'totalExercises': totalExercises,
      'totalSets': totalSets,
      'averageReps': avgReps,
      'estimatedDuration': totalSets * 2, // 분 단위 추정
    };
  }

  Map<String, dynamic> _enhanceProfileWithContext(
    Map<String, dynamic> profile,
    Map<String, dynamic>? contextData,
  ) {
    if (contextData == null) return profile;
    
    final enhanced = Map<String, dynamic>.from(profile);
    
    // 컨텍스트 데이터를 프로필에 통합
    if (contextData.containsKey('recentDiet')) {
      enhanced['recentDietPattern'] = contextData['recentDiet'];
    }
    if (contextData.containsKey('recentExercise')) {
      enhanced['recentExercisePattern'] = contextData['recentExercise'];
    }
    if (contextData.containsKey('recentSleep')) {
      enhanced['recentSleepPattern'] = contextData['recentSleep'];
    }
    
    return enhanced;
  }

  List<String> _identifyRelatedFeatures(String userQuestion) {
    final features = <String>[];
    final lowerQuestion = userQuestion.toLowerCase();
    
    if (lowerQuestion.contains('식단') || lowerQuestion.contains('음식')) {
      features.add('diet');
    }
    if (lowerQuestion.contains('운동') || lowerQuestion.contains('헬스')) {
      features.add('exercise');
    }
    if (lowerQuestion.contains('수면') || lowerQuestion.contains('잠')) {
      features.add('sleep');
    }
    
    return features;
  }
}

// ========== 결과 클래스들 ==========

/// 식단 페이지 결과
class DietPageResult {
  final DietRecommendation? recommendation;
  final String? error;
  final String? mealType;
  final DateTime? timestamp;

  DietPageResult._({
    this.recommendation,
    this.error,
    this.mealType,
    this.timestamp,
  });

  factory DietPageResult.success({
    required DietRecommendation recommendation,
    required String mealType,
    required DateTime timestamp,
  }) => DietPageResult._(
    recommendation: recommendation,
    mealType: mealType,
    timestamp: timestamp,
  );

  factory DietPageResult.error(String error) => DietPageResult._(error: error);

  bool get isSuccess => error == null;
}

/// 식단 분석 결과
class DietAnalysisResult {
  final String? analysis;
  final Map<String, dynamic>? nutritionalBreakdown;
  final List<String>? suggestions;
  final String? error;

  DietAnalysisResult._({
    this.analysis,
    this.nutritionalBreakdown,
    this.suggestions,
    this.error,
  });

  factory DietAnalysisResult.success({
    required String analysis,
    required Map<String, dynamic> nutritionalBreakdown,
    required List<String> suggestions,
  }) => DietAnalysisResult._(
    analysis: analysis,
    nutritionalBreakdown: nutritionalBreakdown,
    suggestions: suggestions,
  );

  factory DietAnalysisResult.error(String error) => DietAnalysisResult._(error: error);

  bool get isSuccess => error == null;
}

/// 운동 페이지 결과
class ExercisePageResult {
  final ExerciseRecommendation? recommendation;
  final String? error;
  final String? fitnessLevel;
  final int? weeklyCommitment;
  final DateTime? timestamp;

  ExercisePageResult._({
    this.recommendation,
    this.error,
    this.fitnessLevel,
    this.weeklyCommitment,
    this.timestamp,
  });

  factory ExercisePageResult.success({
    required ExerciseRecommendation recommendation,
    required String fitnessLevel,
    required int weeklyCommitment,
    required DateTime timestamp,
  }) => ExercisePageResult._(
    recommendation: recommendation,
    fitnessLevel: fitnessLevel,
    weeklyCommitment: weeklyCommitment,
    timestamp: timestamp,
  );

  factory ExercisePageResult.error(String error) => ExercisePageResult._(error: error);

  bool get isSuccess => error == null;
}

/// 운동 분석 결과
class ExerciseAnalysisResult {
  final String? analysis;
  final Map<String, dynamic>? workoutSummary;
  final List<String>? improvements;
  final String? error;

  ExerciseAnalysisResult._({
    this.analysis,
    this.workoutSummary,
    this.improvements,
    this.error,
  });

  factory ExerciseAnalysisResult.success({
    required String analysis,
    required Map<String, dynamic> workoutSummary,
    required List<String> improvements,
  }) => ExerciseAnalysisResult._(
    analysis: analysis,
    workoutSummary: workoutSummary,
    improvements: improvements,
  );

  factory ExerciseAnalysisResult.error(String error) => ExerciseAnalysisResult._(error: error);

  bool get isSuccess => error == null;
}

/// 수면 페이지 결과
class SleepPageResult {
  final SleepRecommendation? recommendation;
  final String? error;
  final double? sleepQuality;
  final DateTime? timestamp;

  SleepPageResult._({
    this.recommendation,
    this.error,
    this.sleepQuality,
    this.timestamp,
  });

  factory SleepPageResult.success({
    required SleepRecommendation recommendation,
    required double sleepQuality,
    required DateTime timestamp,
  }) => SleepPageResult._(
    recommendation: recommendation,
    sleepQuality: sleepQuality,
    timestamp: timestamp,
  );

  factory SleepPageResult.error(String error) => SleepPageResult._(error: error);

  bool get isSuccess => error == null;
}

/// 수면 개선 결과
class SleepImprovementResult {
  final String? suggestions;
  final List<String>? actionItems;
  final List<String>? relatedTopics;
  final String? error;

  SleepImprovementResult._({
    this.suggestions,
    this.actionItems,
    this.relatedTopics,
    this.error,
  });

  factory SleepImprovementResult.success({
    required String suggestions,
    required List<String> actionItems,
    required List<String> relatedTopics,
  }) => SleepImprovementResult._(
    suggestions: suggestions,
    actionItems: actionItems,
    relatedTopics: relatedTopics,
  );

  factory SleepImprovementResult.error(String error) => SleepImprovementResult._(error: error);

  bool get isSuccess => error == null;
}

/// 상담 페이지 결과
class ConsultationPageResult {
  final ConsultationRecommendation? consultation;
  final String? error;
  final List<String>? relatedFeatures;
  final DateTime? timestamp;

  ConsultationPageResult._({
    this.consultation,
    this.error,
    this.relatedFeatures,
    this.timestamp,
  });

  factory ConsultationPageResult.success({
    required ConsultationRecommendation consultation,
    required List<String> relatedFeatures,
    required DateTime timestamp,
  }) => ConsultationPageResult._(
    consultation: consultation,
    relatedFeatures: relatedFeatures,
    timestamp: timestamp,
  );

  factory ConsultationPageResult.error(String error) => ConsultationPageResult._(error: error);

  bool get isSuccess => error == null;
}

// Riverpod Provider
final aiIntegrationProvider = Provider<AIIntegrationLayer>((ref) {
  final aiService = ref.watch(unifiedAIServiceProvider);
  return AIIntegrationLayer(aiService: aiService);
});