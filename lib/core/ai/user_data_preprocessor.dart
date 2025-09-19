import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

/// 사용자 데이터를 Gemma3 모델에 최적화된 형태로 전처리하는 서비스
/// 각 기능별로 특화된 데이터 변환 및 컨텍스트 생성을 담당
class UserDataPreprocessor {
  final Logger _logger = Logger();

  /// 식단 추천을 위한 데이터 전처리
  Future<Map<String, dynamic>> prepareDietData({
    required Map<String, dynamic> userProfile,
    required List<String> dietaryRestrictions,
    required Map<String, dynamic> nutritionalGoals,
    required String mealType,
    String? consultationHistory,
  }) async {
    try {
      _logger.i('Preprocessing diet data for meal type: $mealType');

      // 기본 사용자 정보 추출
      final age = userProfile['age'] ?? 30;
      final weight = userProfile['weight'] ?? 70.0;
      final height = userProfile['height'] ?? 170.0;
      final gender = userProfile['gender'] ?? 'unknown';
      final activityLevel = userProfile['activityLevel'] ?? 'moderate';

      // BMI 계산
      final bmi = _calculateBMI(weight, height);
      final bmiCategory = _getBMICategory(bmi);

      // 기초대사율 계산
      final bmr = _calculateBMR(weight, height, age, gender);

      // 일일 칼로리 요구량 계산
      final dailyCalories = _calculateDailyCalories(bmr, activityLevel);

      // 식사별 칼로리 배분
      final mealCalories = _calculateMealCalories(dailyCalories, mealType);

      // 영양소 목표 계산
      final macroTargets = _calculateMacroTargets(
        mealCalories,
        nutritionalGoals,
      );

      // 제한사항 분석
      final processedRestrictions = _processRestrictions(dietaryRestrictions);

      // 상담 히스토리에서 식단 관련 정보 추출
      final consultationInsights = consultationHistory != null
          ? _extractDietInsightsFromConsultation(consultationHistory)
          : <String, dynamic>{};

      // 컨텍스트 구성
      final context = _buildDietContext({
        'userProfile': userProfile,
        'healthMetrics': {
          'bmi': bmi,
          'bmiCategory': bmiCategory,
          'bmr': bmr,
          'dailyCalories': dailyCalories,
        },
        'nutritionalGoals': nutritionalGoals,
        'consultationInsights': consultationInsights,
      });

      return {
        'userProfile': userProfile,
        'healthMetrics': {
          'age': age,
          'weight': weight,
          'height': height,
          'gender': gender,
          'bmi': bmi,
          'bmiCategory': bmiCategory,
          'bmr': bmr,
          'activityLevel': activityLevel,
        },
        'mealType': mealType,
        'mealCalories': mealCalories,
        'macroTargets': macroTargets,
        'restrictions': processedRestrictions,
        'nutritionalGoals': nutritionalGoals,
        'consultationInsights': consultationInsights,
        'context': context,
      };
    } catch (e) {
      _logger.e('Error preprocessing diet data: $e');
      rethrow;
    }
  }

  /// 운동 계획을 위한 데이터 전처리
  Future<Map<String, dynamic>> prepareExerciseData({
    required Map<String, dynamic> userProfile,
    required String fitnessLevel,
    required Map<String, int> availableTime,
    required List<String> equipment,
    required List<String> goals,
    String? consultationHistory,
  }) async {
    try {
      _logger.i('Preprocessing exercise data for fitness level: $fitnessLevel');

      final age = userProfile['age'] ?? 30;
      final weight = userProfile['weight'] ?? 70.0;
      final height = userProfile['height'] ?? 170.0;
      final gender = userProfile['gender'] ?? 'unknown';

      // 체력 수준 분석
      final fitnessAnalysis = _analyzeFitnessLevel(fitnessLevel, age, gender);

      // 운동 시간 분석
      final timeAnalysis = _analyzeAvailableTime(availableTime);

      // 운동 목표 우선순위 분석
      final goalPriorities = _prioritizeExerciseGoals(goals, userProfile);

      // 장비 기반 운동 옵션 분석
      final equipmentOptions = _analyzeEquipment(equipment);

      // 상담에서 운동 관련 정보 추출
      final consultationInsights = consultationHistory != null
          ? _extractExerciseInsightsFromConsultation(consultationHistory)
          : <String, dynamic>{};

      // 주간 운동 계획 구성
      final weeklyStructure = _buildWeeklyStructure(
        availableTime,
        fitnessLevel,
        goals,
      );

      final context = _buildExerciseContext({
        'userProfile': userProfile,
        'fitnessAnalysis': fitnessAnalysis,
        'goals': goals,
        'consultationInsights': consultationInsights,
      });

      return {
        'userProfile': userProfile,
        'fitnessLevel': fitnessLevel,
        'fitnessAnalysis': fitnessAnalysis,
        'availableTime': availableTime,
        'timeAnalysis': timeAnalysis,
        'equipment': equipment,
        'equipmentOptions': equipmentOptions,
        'goals': goals,
        'goalPriorities': goalPriorities,
        'weeklyStructure': weeklyStructure,
        'consultationInsights': consultationInsights,
        'context': context,
        'totalTime': timeAnalysis['totalWeeklyMinutes'],
      };
    } catch (e) {
      _logger.e('Error preprocessing exercise data: $e');
      rethrow;
    }
  }

  /// 수면 개선을 위한 데이터 전처리
  Future<Map<String, dynamic>> prepareSleepData({
    required Map<String, dynamic> userProfile,
    required Map<String, dynamic> sleepPatterns,
    required List<String> sleepIssues,
    required Map<String, dynamic> lifestyle,
    String? consultationHistory,
  }) async {
    try {
      _logger.i('Preprocessing sleep data for issues: $sleepIssues');

      final age = userProfile['age'] ?? 30;

      // 수면 패턴 분석
      final sleepAnalysis = _analyzeSleepPatterns(sleepPatterns, age);

      // 수면 문제 우선순위 분석
      final issuePriorities = _prioritizeSleepIssues(sleepIssues, sleepPatterns);

      // 생활 패턴이 수면에 미치는 영향 분석
      final lifestyleImpact = _analyzeLifestyleImpact(lifestyle, sleepPatterns);

      // 상담에서 수면 관련 정보 추출
      final consultationInsights = consultationHistory != null
          ? _extractSleepInsightsFromConsultation(consultationHistory)
          : <String, dynamic>{};

      // 수면 목표 설정
      final sleepGoals = _calculateSleepGoals(age, sleepPatterns, sleepIssues);

      final context = _buildSleepContext({
        'userProfile': userProfile,
        'sleepAnalysis': sleepAnalysis,
        'sleepIssues': sleepIssues,
        'consultationInsights': consultationInsights,
      });

      return {
        'userProfile': userProfile,
        'sleepPatterns': sleepPatterns,
        'sleepAnalysis': sleepAnalysis,
        'sleepIssues': sleepIssues,
        'issuePriorities': issuePriorities,
        'lifestyle': lifestyle,
        'lifestyleImpact': lifestyleImpact,
        'sleepGoals': sleepGoals,
        'consultationInsights': consultationInsights,
        'context': context,
      };
    } catch (e) {
      _logger.e('Error preprocessing sleep data: $e');
      rethrow;
    }
  }

  /// 상담을 위한 데이터 전처리
  Future<Map<String, dynamic>> prepareConsultationData({
    required String userMessage,
    required Map<String, dynamic> userProfile,
    String? conversationHistory,
  }) async {
    try {
      _logger.i('Preprocessing consultation data');

      // 사용자 메시지 분석
      final messageAnalysis = _analyzeUserMessage(userMessage);

      // 건강 프로필 요약
      final healthSummary = _createHealthSummary(userProfile);

      // 대화 히스토리 요약
      final conversationSummary = conversationHistory != null
          ? _summarizeConversationHistory(conversationHistory)
          : null;

      final context = _buildConsultationContext({
        'userMessage': userMessage,
        'userProfile': userProfile,
        'messageAnalysis': messageAnalysis,
        'healthSummary': healthSummary,
      });

      return {
        'userMessage': userMessage,
        'messageAnalysis': messageAnalysis,
        'userProfile': userProfile,
        'healthSummary': healthSummary,
        'conversationHistory': conversationHistory,
        'conversationSummary': conversationSummary,
        'context': context,
      };
    } catch (e) {
      _logger.e('Error preprocessing consultation data: $e');
      rethrow;
    }
  }

  // ========== 계산 메서드들 ==========

  double _calculateBMI(double weight, double height) {
    final heightInMeters = height / 100;
    return weight / (heightInMeters * heightInMeters);
  }

  String _getBMICategory(double bmi) {
    if (bmi < 18.5) return '저체중';
    if (bmi < 25) return '정상';
    if (bmi < 30) return '과체중';
    return '비만';
  }

  double _calculateBMR(double weight, double height, int age, String gender) {
    // Harris-Benedict 공식
    if (gender.toLowerCase() == 'male') {
      return 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
    } else {
      return 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
    }
  }

  double _calculateDailyCalories(double bmr, String activityLevel) {
    final multipliers = {
      'sedentary': 1.2,
      'light': 1.375,
      'moderate': 1.55,
      'active': 1.725,
      'very_active': 1.9,
    };
    return bmr * (multipliers[activityLevel] ?? 1.55);
  }

  double _calculateMealCalories(double dailyCalories, String mealType) {
    final ratios = {
      'breakfast': 0.25,
      'lunch': 0.35,
      'dinner': 0.30,
      'snack': 0.10,
    };
    return dailyCalories * (ratios[mealType] ?? 0.25);
  }

  Map<String, double> _calculateMacroTargets(
    double calories,
    Map<String, dynamic> goals,
  ) {
    // 기본 매크로 비율 (탄수화물:단백질:지방 = 50:20:30)
    var carbRatio = 0.50;
    var proteinRatio = 0.20;
    var fatRatio = 0.30;

    // 목표에 따른 비율 조정
    final goalType = goals['type'] ?? 'maintain';
    switch (goalType) {
      case 'weight_loss':
        carbRatio = 0.40;
        proteinRatio = 0.30;
        fatRatio = 0.30;
        break;
      case 'muscle_gain':
        carbRatio = 0.45;
        proteinRatio = 0.30;
        fatRatio = 0.25;
        break;
      case 'low_carb':
        carbRatio = 0.20;
        proteinRatio = 0.30;
        fatRatio = 0.50;
        break;
    }

    return {
      'carbs': (calories * carbRatio) / 4, // 1g = 4kcal
      'protein': (calories * proteinRatio) / 4, // 1g = 4kcal
      'fat': (calories * fatRatio) / 9, // 1g = 9kcal
    };
  }

  // ========== 분석 메서드들 ==========

  Map<String, dynamic> _processRestrictions(List<String> restrictions) {
    final allergens = <String>[];
    final dietary = <String>[];
    final medical = <String>[];

    for (final restriction in restrictions) {
      final lower = restriction.toLowerCase();
      if (_isAllergen(lower)) {
        allergens.add(restriction);
      } else if (_isDietaryPreference(lower)) {
        dietary.add(restriction);
      } else if (_isMedicalRestriction(lower)) {
        medical.add(restriction);
      }
    }

    return {
      'allergens': allergens,
      'dietary': dietary,
      'medical': medical,
      'all': restrictions,
    };
  }

  bool _isAllergen(String restriction) {
    const allergens = [
      'nuts', '견과류', 'dairy', '유제품', 'eggs', '계란',
      'shellfish', '갑각류', 'fish', '생선', 'soy', '콩',
      'wheat', '밀', 'gluten', '글루텐'
    ];
    return allergens.any((allergen) => restriction.contains(allergen));
  }

  bool _isDietaryPreference(String restriction) {
    const preferences = [
      'vegetarian', '채식', 'vegan', '비건', 'halal', '할랄',
      'kosher', '코셔', 'keto', '케토', 'paleo', '팔레오'
    ];
    return preferences.any((pref) => restriction.contains(pref));
  }

  bool _isMedicalRestriction(String restriction) {
    const medical = [
      'diabetes', '당뇨', 'hypertension', '고혈압', 'kidney', '신장',
      'heart', '심장', 'liver', '간', 'cholesterol', '콜레스테롤'
    ];
    return medical.any((condition) => restriction.contains(condition));
  }

  Map<String, dynamic> _analyzeFitnessLevel(String level, int age, String gender) {
    // 체력 수준별 기준 정의
    final baseIntensity = {
      'beginner': 0.6,
      'intermediate': 0.75,
      'advanced': 0.85,
    };

    // 나이별 조정
    var ageMultiplier = 1.0;
    if (age > 50) ageMultiplier = 0.9;
    if (age > 60) ageMultiplier = 0.8;

    final intensity = (baseIntensity[level] ?? 0.6) * ageMultiplier;

    return {
      'level': level,
      'intensity': intensity,
      'ageMultiplier': ageMultiplier,
      'recommendedHeartRate': _calculateTargetHeartRate(age, intensity),
    };
  }

  Map<String, int> _calculateTargetHeartRate(int age, double intensity) {
    final maxHR = 220 - age;
    final targetHR = (maxHR * intensity).round();
    return {
      'max': maxHR,
      'target': targetHR,
      'zone_lower': (targetHR * 0.85).round(),
      'zone_upper': (targetHR * 0.95).round(),
    };
  }

  // ========== 컨텍스트 구성 메서드들 ==========

  String _buildDietContext(Map<String, dynamic> data) {
    final userProfile = data['userProfile'];
    final healthMetrics = data['healthMetrics'];
    final consultationInsights = data['consultationInsights'];

    return '''
사용자 건강 프로필:
- 나이: ${healthMetrics['age']}세, 성별: ${healthMetrics['gender']}
- 체중: ${healthMetrics['weight']}kg, 키: ${healthMetrics['height']}cm
- BMI: ${healthMetrics['bmi'].toStringAsFixed(1)} (${healthMetrics['bmiCategory']})
- 활동 수준: ${healthMetrics['activityLevel']}
- 기초대사율: ${healthMetrics['bmr'].toStringAsFixed(0)}kcal

상담 이력 중 식단 관련 정보:
${consultationInsights.isNotEmpty ? consultationInsights['summary'] : '없음'}
''';
  }

  String _buildExerciseContext(Map<String, dynamic> data) {
    final userProfile = data['userProfile'];
    final fitnessAnalysis = data['fitnessAnalysis'];
    final consultationInsights = data['consultationInsights'];

    return '''
사용자 운동 프로필:
- 나이: ${userProfile['age']}세, 성별: ${userProfile['gender']}
- 체력 수준: ${fitnessAnalysis['level']} (권장 강도: ${(fitnessAnalysis['intensity'] * 100).toStringAsFixed(0)}%)
- 목표 심박수: ${fitnessAnalysis['recommendedHeartRate']['target']}bpm

상담 이력 중 운동 관련 정보:
${consultationInsights.isNotEmpty ? consultationInsights['summary'] : '없음'}
''';
  }

  String _buildSleepContext(Map<String, dynamic> data) {
    final userProfile = data['userProfile'];
    final sleepAnalysis = data['sleepAnalysis'];
    final consultationInsights = data['consultationInsights'];

    return '''
사용자 수면 프로필:
- 나이: ${userProfile['age']}세
- 평균 수면 시간: ${sleepAnalysis['averageSleepHours']}시간
- 수면 효율성: ${sleepAnalysis['efficiency']}%
- 주요 수면 문제: ${sleepAnalysis['mainIssues']}

상담 이력 중 수면 관련 정보:
${consultationInsights.isNotEmpty ? consultationInsights['summary'] : '없음'}
''';
  }

  String _buildConsultationContext(Map<String, dynamic> data) {
    final userProfile = data['userProfile'];
    final healthSummary = data['healthSummary'];
    final messageAnalysis = data['messageAnalysis'];

    return '''
사용자 기본 정보:
- 나이: ${userProfile['age']}세, 성별: ${userProfile['gender']}
- 건강 상태 요약: $healthSummary
- 질문 유형: ${messageAnalysis['category']}
- 관련 분야: ${messageAnalysis['topics']}
''';
  }

  // ========== 기타 분석 메서드들 ==========

  Map<String, dynamic> _analyzeAvailableTime(Map<String, int> time) {
    final totalMinutes = time.values.fold(0, (sum, minutes) => sum + minutes);
    final avgPerDay = totalMinutes / 7;
    final activeDays = time.values.where((minutes) => minutes > 0).length;

    return {
      'totalWeeklyMinutes': totalMinutes,
      'averagePerDay': avgPerDay,
      'activeDays': activeDays,
      'schedule': time,
    };
  }

  Map<String, dynamic> _prioritizeExerciseGoals(
    List<String> goals,
    Map<String, dynamic> userProfile,
  ) {
    // 목표 우선순위 계산 로직
    return {
      'primary': goals.isNotEmpty ? goals.first : 'general_fitness',
      'secondary': goals.length > 1 ? goals.sublist(1) : [],
      'all': goals,
    };
  }

  Map<String, dynamic> _analyzeEquipment(List<String> equipment) {
    final categories = {
      'cardio': <String>[],
      'strength': <String>[],
      'flexibility': <String>[],
      'bodyweight': equipment.isEmpty,
    };

    for (final item in equipment) {
      final lower = item.toLowerCase();
      if (_isCardioEquipment(lower)) {
        (categories['cardio'] as List).add(item);
      } else if (_isStrengthEquipment(lower)) {
        (categories['strength'] as List).add(item);
      } else if (_isFlexibilityEquipment(lower)) {
        (categories['flexibility'] as List).add(item);
      }
    }

    return categories;
  }

  bool _isCardioEquipment(String equipment) {
    const cardio = ['treadmill', 'bike', 'elliptical', 'rowing', 'jump rope'];
    return cardio.any((item) => equipment.contains(item));
  }

  bool _isStrengthEquipment(String equipment) {
    const strength = ['weights', 'dumbbells', 'barbell', 'resistance', 'kettlebell'];
    return strength.any((item) => equipment.contains(item));
  }

  bool _isFlexibilityEquipment(String equipment) {
    const flexibility = ['yoga', 'mat', 'foam roller', 'bands'];
    return flexibility.any((item) => equipment.contains(item));
  }

  Map<String, dynamic> _buildWeeklyStructure(
    Map<String, int> availableTime,
    String fitnessLevel,
    List<String> goals,
  ) {
    // 주간 운동 구조 생성 로직
    return {
      'totalSessions': availableTime.values.where((t) => t > 0).length,
      'structure': 'balanced', // strength + cardio + flexibility
    };
  }

  Map<String, dynamic> _analyzeSleepPatterns(
    Map<String, dynamic> patterns,
    int age,
  ) {
    final bedtime = patterns['averageBedtime'] ?? '23:00';
    final wakeTime = patterns['averageWakeTime'] ?? '07:00';
    final sleepHours = patterns['averageSleepHours'] ?? 7.0;
    final efficiency = patterns['sleepEfficiency'] ?? 85.0;

    return {
      'averageSleepHours': sleepHours,
      'efficiency': efficiency,
      'bedtime': bedtime,
      'wakeTime': wakeTime,
      'quality': _assessSleepQuality(sleepHours, efficiency, age),
      'mainIssues': _identifyMainSleepIssues(patterns),
    };
  }

  String _assessSleepQuality(double hours, double efficiency, int age) {
    final recommendedHours = age < 18 ? 9.0 : (age < 65 ? 8.0 : 7.0);
    
    if (hours >= recommendedHours && efficiency >= 85) return '양호';
    if (hours >= recommendedHours - 1 && efficiency >= 75) return '보통';
    return '개선 필요';
  }

  List<String> _identifyMainSleepIssues(Map<String, dynamic> patterns) {
    final issues = <String>[];
    
    if (patterns['fallAsleepTime'] != null && patterns['fallAsleepTime'] > 30) {
      issues.add('입면 장애');
    }
    if (patterns['nightWakings'] != null && patterns['nightWakings'] > 2) {
      issues.add('중간 각성');
    }
    if (patterns['earlyWaking'] != null && patterns['earlyWaking'] == true) {
      issues.add('조기 각성');
    }
    
    return issues;
  }

  Map<String, dynamic> _prioritizeSleepIssues(
    List<String> issues,
    Map<String, dynamic> patterns,
  ) {
    // 수면 문제 우선순위 분석
    return {
      'primary': issues.isNotEmpty ? issues.first : null,
      'secondary': issues.length > 1 ? issues.sublist(1) : [],
      'severity': _assessIssueSeverity(issues, patterns),
    };
  }

  String _assessIssueSeverity(List<String> issues, Map<String, dynamic> patterns) {
    if (issues.length >= 3) return '심각';
    if (issues.length == 2) return '보통';
    if (issues.length == 1) return '경미';
    return '없음';
  }

  Map<String, dynamic> _analyzeLifestyleImpact(
    Map<String, dynamic> lifestyle,
    Map<String, dynamic> sleepPatterns,
  ) {
    final factors = <String, String>{};
    
    if (lifestyle['caffeine'] != null && lifestyle['caffeine'] > 2) {
      factors['caffeine'] = '과다 섭취가 수면에 영향을 줄 수 있음';
    }
    if (lifestyle['screenTime'] != null && lifestyle['screenTime'] > 2) {
      factors['screenTime'] = '취침 전 화면 시청이 수면 질을 저하시킬 수 있음';
    }
    if (lifestyle['exercise'] != null && lifestyle['exercise'] == 'evening') {
      factors['exercise'] = '저녁 운동이 입면을 어렵게 할 수 있음';
    }
    
    return {
      'impactingFactors': factors,
      'overallImpact': factors.isEmpty ? '양호' : '개선 필요',
    };
  }

  Map<String, dynamic> _calculateSleepGoals(
    int age,
    Map<String, dynamic> patterns,
    List<String> issues,
  ) {
    final recommendedHours = age < 18 ? 9.0 : (age < 65 ? 8.0 : 7.0);
    final currentHours = patterns['averageSleepHours'] ?? 7.0;
    
    return {
      'targetSleepHours': recommendedHours,
      'currentSleepHours': currentHours,
      'targetEfficiency': 85.0,
      'currentEfficiency': patterns['sleepEfficiency'] ?? 75.0,
      'improvementNeeded': currentHours < recommendedHours || 
                          (patterns['sleepEfficiency'] ?? 75.0) < 85.0,
    };
  }

  Map<String, dynamic> _analyzeUserMessage(String message) {
    final categories = _categorizeMessage(message);
    final topics = _extractTopics(message);
    final urgency = _assessUrgency(message);
    
    return {
      'category': categories,
      'topics': topics,
      'urgency': urgency,
      'length': message.length,
      'complexity': _assessComplexity(message),
    };
  }

  String _categorizeMessage(String message) {
    final lower = message.toLowerCase();
    
    if (lower.contains('아프') || lower.contains('증상') || lower.contains('병')) {
      return 'symptom_inquiry';
    }
    if (lower.contains('식단') || lower.contains('음식') || lower.contains('먹')) {
      return 'diet_inquiry';
    }
    if (lower.contains('운동') || lower.contains('헬스')) {
      return 'exercise_inquiry';
    }
    if (lower.contains('수면') || lower.contains('잠')) {
      return 'sleep_inquiry';
    }
    if (lower.contains('약') || lower.contains('처방')) {
      return 'medication_inquiry';
    }
    
    return 'general_health';
  }

  List<String> _extractTopics(String message) {
    final topics = <String>[];
    final lower = message.toLowerCase();
    
    const topicKeywords = {
      'diabetes': ['당뇨', '혈당', '인슐린'],
      'hypertension': ['고혈압', '혈압'],
      'heart': ['심장', '가슴'],
      'diet': ['식단', '음식', '칼로리'],
      'exercise': ['운동', '헬스', '근육'],
      'sleep': ['수면', '잠', '불면'],
      'stress': ['스트레스', '우울', '불안'],
    };
    
    for (final entry in topicKeywords.entries) {
      if (entry.value.any((keyword) => lower.contains(keyword))) {
        topics.add(entry.key);
      }
    }
    
    return topics;
  }

  String _assessUrgency(String message) {
    final lower = message.toLowerCase();
    const urgentKeywords = ['응급', '심각', '급하', '위험', '심한', '견딜 수 없'];
    
    if (urgentKeywords.any((keyword) => lower.contains(keyword))) {
      return 'high';
    }
    
    const moderateKeywords = ['아프', '불편', '걱정', '문제'];
    if (moderateKeywords.any((keyword) => lower.contains(keyword))) {
      return 'medium';
    }
    
    return 'low';
  }

  String _assessComplexity(String message) {
    if (message.length > 200) return 'high';
    if (message.length > 50) return 'medium';
    return 'low';
  }

  String _createHealthSummary(Map<String, dynamic> userProfile) {
    final summary = <String>[];
    
    if (userProfile['age'] != null) {
      summary.add('${userProfile['age']}세');
    }
    if (userProfile['conditions'] != null) {
      final conditions = userProfile['conditions'] as List<String>;
      if (conditions.isNotEmpty) {
        summary.add('기존 질환: ${conditions.join(', ')}');
      }
    }
    if (userProfile['medications'] != null) {
      final medications = userProfile['medications'] as List<String>;
      if (medications.isNotEmpty) {
        summary.add('복용 약물: ${medications.join(', ')}');
      }
    }
    
    return summary.isEmpty ? '특이사항 없음' : summary.join(', ');
  }

  String? _summarizeConversationHistory(String history) {
    // 대화 히스토리 요약 로직
    if (history.length > 500) {
      return '${history.substring(0, 200)}... (이전 대화 요약)';
    }
    return history;
  }

  Map<String, dynamic> _extractDietInsightsFromConsultation(String consultation) {
    // 상담 내용에서 식단 관련 정보 추출
    return {
      'summary': '이전 상담에서 언급된 식단 관련 내용 요약',
      'preferences': [],
      'restrictions': [],
    };
  }

  Map<String, dynamic> _extractExerciseInsightsFromConsultation(String consultation) {
    // 상담 내용에서 운동 관련 정보 추출
    return {
      'summary': '이전 상담에서 언급된 운동 관련 내용 요약',
      'limitations': [],
      'preferences': [],
    };
  }

  Map<String, dynamic> _extractSleepInsightsFromConsultation(String consultation) {
    // 상담 내용에서 수면 관련 정보 추출
    return {
      'summary': '이전 상담에서 언급된 수면 관련 내용 요약',
      'issues': [],
      'patterns': {},
    };
  }
}

// Riverpod Provider
final userDataPreprocessorProvider = Provider<UserDataPreprocessor>((ref) {
  return UserDataPreprocessor();
});