import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/activity/providers/activity_providers.dart';
import '../../../features/food/providers/food_providers.dart';
import '../../../core/mock/mock_food_data.dart';

// 현재 사용자 ID
const String currentUserId = MockFoodData.userId;

/// 주간 활동 리포트 데이터 프로바이더
final weeklyActivityReportProvider =
    FutureProvider<Map<String, dynamic>>((ref) async {
  final weeklyStats = await ref.watch(weeklyStatsProvider.future);
  final weeklyActivities = await ref.watch(weeklyActivitiesProvider.future);
  final goals = await ref.watch(activityGoalsProvider.future);

  if (weeklyActivities.isEmpty || goals == null) {
    return _getDefaultActivityReport();
  }

  // 일별 걸음 수 데이터
  final dailySteps =
      weeklyActivities.map((activity) => activity.steps.toDouble()).toList();

  // 평균 계산
  final avgSteps = weeklyStats['averageSteps']?.toDouble() ?? 0.0;
  final totalActiveMinutes = weeklyStats['totalActiveMinutes']?.toInt() ?? 0;
  final totalCalories = weeklyStats['totalCalories']?.toInt() ?? 0;

  // 목표 대비 달성률
  final stepsProgress =
      goals.stepsGoal > 0 ? (avgSteps / goals.stepsGoal).clamp(0.0, 1.0) : 0.0;
  final caloriesProgress = goals.caloriesBurnedGoal > 0
      ? (totalCalories / (goals.caloriesBurnedGoal * 7))
      : 0.0;
  final activeMinutesProgress = goals.activeMinutesGoal > 0
      ? (totalActiveMinutes / (goals.activeMinutesGoal * 7))
      : 0.0;

  return {
    'avgSteps': avgSteps.round(),
    'stepsProgress': stepsProgress,
    'totalActiveMinutes': totalActiveMinutes,
    'activeMinutesProgress': activeMinutesProgress.clamp(0.0, 1.0),
    'totalCalories': totalCalories,
    'caloriesProgress': caloriesProgress.clamp(0.0, 1.0),
    'dailyStepsData': dailySteps,
    'daysActive': weeklyStats['daysActive'] ?? 0,
  };
});

/// 주간 영양 리포트 데이터 프로바이더
final weeklyNutritionReportProvider =
    FutureProvider<Map<String, dynamic>>((ref) async {

  try {
    final weeklyNutrition =
        await ref.watch(weeklyNutritionTrendProvider.future);

    if (weeklyNutrition.isEmpty) {
      return _getDefaultNutritionReport();
    }

    // 일별 칼로리 데이터
    final dailyCalories =
        weeklyNutrition.map((day) => day.totalCalories).toList();

    // 평균 계산
    final avgCalories =
        dailyCalories.fold(0.0, (sum, cal) => sum + cal) / dailyCalories.length;
    final avgProtein =
        weeklyNutrition.fold(0.0, (sum, day) => sum + day.totalProtein) /
            weeklyNutrition.length;
    final avgCarbs =
        weeklyNutrition.fold(0.0, (sum, day) => sum + day.totalCarbs) /
            weeklyNutrition.length;
    final avgFat = weeklyNutrition.fold(0.0, (sum, day) => sum + day.totalFat) /
        weeklyNutrition.length;

    // 목표 대비 달성률 (첫 번째 날의 목표 사용)
    final firstDay = weeklyNutrition.first;
    final calorieProgress =
        firstDay.calorieGoal > 0 ? (avgCalories / firstDay.calorieGoal) : 0.0;
    final proteinProgress =
        firstDay.proteinGoal > 0 ? (avgProtein / firstDay.proteinGoal) : 0.0;

    // 영양소 비율 계산 (칼로리 기준)
    final totalMacroCalories = (avgProtein * 4) + (avgCarbs * 4) + (avgFat * 9);
    final proteinRatio =
        totalMacroCalories > 0 ? (avgProtein * 4) / totalMacroCalories : 0.0;
    final carbsRatio =
        totalMacroCalories > 0 ? (avgCarbs * 4) / totalMacroCalories : 0.0;
    final fatRatio =
        totalMacroCalories > 0 ? (avgFat * 9) / totalMacroCalories : 0.0;

    return {
      'avgCalories': avgCalories.round(),
      'calorieProgress': calorieProgress.clamp(0.0, 1.0),
      'avgProtein': avgProtein.round(),
      'proteinProgress': proteinProgress.clamp(0.0, 1.0),
      'dailyCaloriesData': dailyCalories,
      'proteinRatio': proteinRatio,
      'carbsRatio': carbsRatio,
      'fatRatio': fatRatio,
      'waterIntake': 1.8, // 기본값 (실제로는 별도 테이블에서 가져와야 함)
      'waterProgress': 0.9,
    };
  } catch (e) {
    return _getDefaultNutritionReport();
  }
});

/// 운동 타입별 분포 프로바이더
final workoutTypeDistributionProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final workoutStats = await ref.watch(workoutTypeStatsProvider.future);

  if (workoutStats.isEmpty) {
    return [
      {'type': '유산소', 'value': 40.0, 'count': 4},
      {'type': '근력', 'value': 30.0, 'count': 3},
      {'type': '요가', 'value': 20.0, 'count': 2},
      {'type': '기타', 'value': 10.0, 'count': 1},
    ];
  }

  final totalWorkouts =
      workoutStats.values.fold(0, (sum, stat) => sum + (stat['count'] as int));

  if (totalWorkouts == 0) {
    return [
      {'type': '운동 기록 없음', 'value': 100.0, 'count': 0},
    ];
  }

  return workoutStats.entries.map((entry) {
    final type = _getWorkoutTypeKorean(entry.key);
    final count = entry.value['count'] as int;
    final percentage = (count / totalWorkouts) * 100;

    return {
      'type': type,
      'value': percentage,
      'count': count,
      'totalDuration': entry.value['totalDuration'] as int,
      'totalCalories': entry.value['totalCalories'] as int,
    };
  }).toList();
});

/// 종합 건강 점수 프로바이더
final healthScoreProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final activityReport = await ref.watch(weeklyActivityReportProvider.future);
  final nutritionReport = await ref.watch(weeklyNutritionReportProvider.future);

  // 활동 점수 (0-100)
  final activityScore = _calculateActivityScore(
    activityReport['stepsProgress'] ?? 0.0,
    activityReport['activeMinutesProgress'] ?? 0.0,
    activityReport['caloriesProgress'] ?? 0.0,
  );

  // 식단 점수 (0-100)
  final nutritionScore = _calculateNutritionScore(
    nutritionReport['calorieProgress'] ?? 0.0,
    nutritionReport['proteinProgress'] ?? 0.0,
    nutritionReport['waterProgress'] ?? 0.0,
  );

  // 수면 점수 (임시 고정값, 실제로는 수면 데이터에서 계산)
  final sleepScore = 85;

  // 종합 점수 (가중 평균)
  final overallScore =
      ((activityScore * 0.4) + (nutritionScore * 0.4) + (sleepScore * 0.2))
          .round();

  return {
    'overall': overallScore,
    'activity': activityScore,
    'nutrition': nutritionScore,
    'sleep': sleepScore,
  };
});

/// 목표 달성률 프로바이더
final goalAchievementProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final activityReport = await ref.watch(weeklyActivityReportProvider.future);
  final nutritionReport = await ref.watch(weeklyNutritionReportProvider.future);
  final goals = await ref.watch(activityGoalsProvider.future);

  return [
    {
      'title': '일일 걸음 수',
      'progress': activityReport['stepsProgress'] ?? 0.0,
      'current': activityReport['avgSteps'] ?? 0,
      'target': goals?.stepsGoal ?? 10000,
      'unit': '걸음',
    },
    {
      'title': '주간 운동 시간',
      'progress': activityReport['activeMinutesProgress'] ?? 0.0,
      'current': ((activityReport['totalActiveMinutes'] ?? 0) / 60.0),
      'target': ((goals?.activeMinutesGoal ?? 60) * 7 / 60.0),
      'unit': '시간',
    },
    {
      'title': '수분 섭취량',
      'progress': nutritionReport['waterProgress'] ?? 0.0,
      'current': nutritionReport['waterIntake'] ?? 0.0,
      'target': 2.0,
      'unit': 'L',
    },
    {
      'title': '칼로리 섭취',
      'progress': nutritionReport['calorieProgress'] ?? 0.0,
      'current': nutritionReport['avgCalories'] ?? 0,
      'target': 1800,
      'unit': 'kcal',
    },
  ];
});

/// AI 인사이트 프로바이더 (분석 기반 제안)
final aiInsightsProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final nutritionReport = await ref.watch(weeklyNutritionReportProvider.future);
  final weeklyActivities = await ref.watch(weeklyActivitiesProvider.future);

  List<Map<String, dynamic>> insights = [];

  // 활동 패턴 분석
  if (weeklyActivities.isNotEmpty) {
    final weekendSteps = weeklyActivities.where((activity) {
      final weekday = activity.date.weekday;
      return weekday == 6 || weekday == 7; // 토요일, 일요일
    }).fold(0, (sum, activity) => sum + activity.steps);

    final weekdaySteps = weeklyActivities.where((activity) {
      final weekday = activity.date.weekday;
      return weekday >= 1 && weekday <= 5; // 월-금
    }).fold(0, (sum, activity) => sum + activity.steps);

    if (weekendSteps > weekdaySteps * 1.2) {
      insights.add({
        'title': '운동 패턴 분석',
        'description':
            '주말에 운동량이 증가하는 패턴을 보입니다. 평일 운동 시간을 늘리면 더 균형잡힌 활동이 가능할 것 같습니다.',
        'icon': 'fitness_center',
        'color': 'blue',
      });
    }
  }

  // 영양 섭취 분석
  final proteinProgress = nutritionReport['proteinProgress'] ?? 0.0;

  if (proteinProgress > 1.0) {
    insights.add({
      'title': '영양 균형',
      'description': '단백질 섭취량이 목표를 초과하고 있어 좋습니다. 다만 수분 섭취를 조금 더 늘리시면 좋겠습니다.',
      'icon': 'restaurant',
      'color': 'green',
    });
  } else if (proteinProgress < 0.8) {
    insights.add({
      'title': '단백질 부족',
      'description': '단백질 섭취량이 부족합니다. 계란, 닭가슴살, 두부 등을 식사에 추가해보세요.',
      'icon': 'restaurant',
      'color': 'orange',
    });
  }

  // 기본 인사이트 (데이터가 부족한 경우)
  if (insights.isEmpty) {
    insights.addAll([
      {
        'title': '운동 패턴 분석',
        'description': '꾸준한 운동 패턴을 보이고 있습니다. 이대로 유지하시면 좋겠습니다.',
        'icon': 'fitness_center',
        'color': 'blue',
      },
      {
        'title': '영양 균형',
        'description': '전반적으로 균형잡힌 식단을 유지하고 있습니다.',
        'icon': 'restaurant',
        'color': 'green',
      },
    ]);
  }

  return insights;
});

/// 개인 맞춤 권장사항 프로바이더
final recommendationsProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final activityReport = await ref.watch(weeklyActivityReportProvider.future);
  final nutritionReport = await ref.watch(weeklyNutritionReportProvider.future);

  List<Map<String, dynamic>> recommendations = [];

  // 활동 관련 권장사항
  final stepsProgress = activityReport['stepsProgress'] ?? 0.0;
  if (stepsProgress < 0.8) {
    recommendations.add({
      'category': '운동',
      'recommendation': '평일 점심시간에 15분 산책을 추가해보세요',
      'icon': 'directions_walk',
      'color': 'blue',
    });
  } else {
    recommendations.add({
      'category': '운동',
      'recommendation': '현재 활동량을 잘 유지하고 계십니다. 이대로 계속하세요!',
      'icon': 'fitness_center',
      'color': 'green',
    });
  }

  // 영양 관련 권장사항
  final proteinProgress = nutritionReport['proteinProgress'] ?? 0.0;
  if (proteinProgress < 0.9) {
    recommendations.add({
      'category': '식단',
      'recommendation': '오후 간식으로 견과류나 그릭요거트를 섭취하면 좋겠습니다',
      'icon': 'restaurant',
      'color': 'green',
    });
  } else {
    recommendations.add({
      'category': '식단',
      'recommendation': '영양소 섭취가 우수합니다. 현재 식단을 유지하세요',
      'icon': 'restaurant',
      'color': 'green',
    });
  }

  // 기본 수면 권장사항
  recommendations.add({
    'category': '수면',
    'recommendation': '취침 1시간 전 스마트폰 사용을 줄여보세요',
    'icon': 'bedtime',
    'color': 'indigo',
  });

  return recommendations;
});

// 헬퍼 함수들

/// 기본 활동 리포트 데이터
Map<String, dynamic> _getDefaultActivityReport() {
  return {
    'avgSteps': 8542,
    'stepsProgress': 0.85,
    'totalActiveMinutes': 272,
    'activeMinutesProgress': 0.91,
    'totalCalories': 2847,
    'caloriesProgress': 0.95,
    'dailyStepsData': [7500.0, 8200.0, 9100.0, 8800.0, 9500.0, 7800.0, 8900.0],
    'daysActive': 6,
  };
}

/// 기본 영양 리포트 데이터
Map<String, dynamic> _getDefaultNutritionReport() {
  return {
    'avgCalories': 1847,
    'calorieProgress': 0.92,
    'avgProtein': 78,
    'proteinProgress': 1.04,
    'dailyCaloriesData': [
      1800.0,
      1950.0,
      1750.0,
      2100.0,
      1850.0,
      2200.0,
      1900.0
    ],
    'proteinRatio': 0.25,
    'carbsRatio': 0.50,
    'fatRatio': 0.25,
    'waterIntake': 1.8,
    'waterProgress': 0.9,
  };
}

/// 운동 타입 한글 변환
String _getWorkoutTypeKorean(String type) {
  switch (type) {
    case 'running':
      return '달리기';
    case 'cycling':
      return '자전거';
    case 'swimming':
      return '수영';
    case 'strength_training':
      return '근력운동';
    case 'walking':
      return '걷기';
    case 'yoga':
      return '요가';
    default:
      return '기타';
  }
}

/// 활동 점수 계산
int _calculateActivityScore(double stepsProgress, double activeMinutesProgress,
    double caloriesProgress) {
  final score =
      ((stepsProgress + activeMinutesProgress + caloriesProgress) / 3 * 100)
          .round();
  return score.clamp(0, 100);
}

/// 영양 점수 계산
int _calculateNutritionScore(
    double calorieProgress, double proteinProgress, double waterProgress) {
  // 목표 달성률이 0.8-1.2 범위일 때 최고 점수
  final calorieScore = _getProgressScore(calorieProgress);
  final proteinScore = _getProgressScore(proteinProgress);
  final waterScore = _getProgressScore(waterProgress);

  final score = ((calorieScore + proteinScore + waterScore) / 3 * 100).round();
  return score.clamp(0, 100);
}

/// 진행률에 따른 점수 계산 (0.8-1.2가 최적)
double _getProgressScore(double progress) {
  if (progress >= 0.8 && progress <= 1.2) {
    return 1.0;
  } else if (progress >= 0.6 && progress < 0.8) {
    return 0.8;
  } else if (progress > 1.2 && progress <= 1.5) {
    return 0.8;
  } else {
    return 0.6;
  }
}
