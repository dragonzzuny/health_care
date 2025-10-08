import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/insight_reasoning.dart';
import '../models/graph_node.dart';
import '../services/health_analysis_service.dart';
import '../../activity/providers/activity_providers.dart';
import '../../report/providers/report_providers.dart';
import '../../../shared/models/health_data_model.dart';

/// HealthAnalysisService Provider
final healthAnalysisServiceProvider = Provider<HealthAnalysisService>((ref) {
  return HealthAnalysisService();
});

/// 주간 건강 인사이트 분석 Provider
final weeklyHealthInsightsProvider = FutureProvider<List<InsightReasoning>>((ref) async {
  final service = ref.watch(healthAnalysisServiceProvider);

  // 주간 활동 데이터
  final weeklyActivities = await ref.watch(weeklyActivitiesProvider.future);

  // 활동 리포트
  final activityReport = await ref.watch(weeklyActivityReportProvider.future);

  // 영양 리포트
  final nutritionReport = await ref.watch(weeklyNutritionReportProvider.future);

  // DailyActivity를 HealthData로 변환
  final healthDataList = weeklyActivities.map((activity) {
    return HealthData(
      id: '${activity.userId}_${activity.date.toIso8601String()}',
      userId: activity.userId,
      date: activity.date,
      steps: activity.steps,
      caloriesBurned: activity.caloriesBurned.toDouble(),
      distance: activity.distanceMeters / 1000.0, // 미터를 킬로미터로 변환
      activeMinutes: activity.activeMinutes,
      waterIntake: null,
      sleepData: null,
      foodEntries: const [],
      exerciseEntries: const [],
      bodyMeasurement: null,
    );
  }).toList();

  // 분석 실행
  final insights = await service.analyzeWeeklyHealth(
    weeklyData: healthDataList,
    activityReport: activityReport,
    nutritionReport: nutritionReport,
  );

  return insights;
});

/// 특정 인사이트 선택 Provider
final selectedInsightProvider = StateProvider<InsightReasoning?>((ref) => null);

/// 활동 패턴 인사이트만 필터링
final activityInsightProvider = Provider<AsyncValue<InsightReasoning?>>((ref) {
  final insights = ref.watch(weeklyHealthInsightsProvider);

  return insights.when(
    data: (list) {
      final activityInsight = list.where((i) => i.category == HealthCategory.activity).firstOrNull;
      return AsyncValue.data(activityInsight);
    },
    loading: () => const AsyncValue.loading(),
    error: (err, stack) => AsyncValue.error(err, stack),
  );
});

/// 영양 인사이트만 필터링
final nutritionInsightProvider = Provider<AsyncValue<InsightReasoning?>>((ref) {
  final insights = ref.watch(weeklyHealthInsightsProvider);

  return insights.when(
    data: (list) {
      final nutritionInsight = list.where((i) => i.category == HealthCategory.nutrition).firstOrNull;
      return AsyncValue.data(nutritionInsight);
    },
    loading: () => const AsyncValue.loading(),
    error: (err, stack) => AsyncValue.error(err, stack),
  );
});

/// 수면 인사이트만 필터링
final sleepInsightProvider = Provider<AsyncValue<InsightReasoning?>>((ref) {
  final insights = ref.watch(weeklyHealthInsightsProvider);

  return insights.when(
    data: (list) {
      final sleepInsight = list.where((i) => i.category == HealthCategory.sleep).firstOrNull;
      return AsyncValue.data(sleepInsight);
    },
    loading: () => const AsyncValue.loading(),
    error: (err, stack) => AsyncValue.error(err, stack),
  );
});

/// 종합 건강 인사이트만 필터링
final overallInsightProvider = Provider<AsyncValue<InsightReasoning?>>((ref) {
  final insights = ref.watch(weeklyHealthInsightsProvider);

  return insights.when(
    data: (list) {
      final overallInsight = list.where((i) => i.category == HealthCategory.overall).firstOrNull;
      return AsyncValue.data(overallInsight);
    },
    loading: () => const AsyncValue.loading(),
    error: (err, stack) => AsyncValue.error(err, stack),
  );
});

/// 우선순위 높은 인사이트만 필터링
final highPriorityInsightsProvider = Provider<AsyncValue<List<InsightReasoning>>>((ref) {
  final insights = ref.watch(weeklyHealthInsightsProvider);

  return insights.when(
    data: (list) {
      final highPriority = list.where((i) => i.priority == InsightPriority.high).toList();
      return AsyncValue.data(highPriority);
    },
    loading: () => const AsyncValue.loading(),
    error: (err, stack) => AsyncValue.error(err, stack),
  );
});
