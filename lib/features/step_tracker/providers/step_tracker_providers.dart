import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/step_data.dart';
import '../services/step_tracker_service.dart';

// Step Tracker Service Provider
final stepTrackerServiceProvider = Provider<StepTrackerService>((ref) {
  return StepTrackerService();
});

// Today's Step Count Provider
final todayStepsProvider = FutureProvider<int>((ref) async {
  final service = ref.read(stepTrackerServiceProvider);
  return await service.getTodaySteps();
});

// Daily Goal Progress Provider
final dailyGoalProgressProvider = FutureProvider<double>((ref) async {
  final service = ref.read(stepTrackerServiceProvider);
  return await service.getDailyGoalProgress();
});

// Daily Goal Achievement Provider
final dailyGoalAchievedProvider = FutureProvider<bool>((ref) async {
  final service = ref.read(stepTrackerServiceProvider);
  return await service.checkDailyGoalAchieved();
});

// Weekly Steps Provider
final weeklyStepsProvider = FutureProvider<List<StepData>>((ref) async {
  final service = ref.read(stepTrackerServiceProvider);
  return await service.getWeeklySteps();
});

// Weekly Step Summary Provider
final weeklyStepSummaryProvider = FutureProvider<WeeklyStepSummary>((ref) async {
  final service = ref.read(stepTrackerServiceProvider);
  return await service.getWeeklyStepSummary();
});

// Step Tracker Permission Provider
final stepTrackerPermissionProvider = FutureProvider<bool>((ref) async {
  final service = ref.read(stepTrackerServiceProvider);
  return await service.requestPermissions();
});

// Manual Step Refresh Provider
final stepRefreshProvider = StateProvider<int>((ref) => 0);

// Refreshable Today Steps Provider
final refreshableTodayStepsProvider = FutureProvider<int>((ref) async {
  // stepRefreshProvider가 변경될 때마다 새로고침
  ref.watch(stepRefreshProvider);
  final service = ref.read(stepTrackerServiceProvider);
  return await service.getTodaySteps();
});

// Refreshable Daily Goal Progress Provider
final refreshableDailyGoalProgressProvider = FutureProvider<double>((ref) async {
  ref.watch(stepRefreshProvider);
  final service = ref.read(stepTrackerServiceProvider);
  return await service.getDailyGoalProgress();
});

// Auto-refresh provider (매 분마다 새로고침)
final autoRefreshProvider = StreamProvider<int>((ref) {
  return Stream.periodic(const Duration(minutes: 1), (count) => count);
});

// User's Total Points Provider (모든 걸음 수 기반)
final userTotalPointsProvider = FutureProvider<int>((ref) async {
  final weeklySteps = await ref.read(weeklyStepsProvider.future);
  return weeklySteps.fold<int>(0, (total, stepData) => total + stepData.points);
});

// Step Tracker State Notifier for real-time updates
class StepTrackerNotifier extends StateNotifier<AsyncValue<StepData?>> {
  StepTrackerNotifier(this.ref) : super(const AsyncValue.loading()) {
    _loadTodaySteps();
  }

  final Ref ref;

  Future<void> _loadTodaySteps() async {
    try {
      final service = ref.read(stepTrackerServiceProvider);
      final steps = await service.getTodaySteps();
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      state = AsyncValue.data(StepData(
        date: today,
        steps: steps,
        points: steps,
      ));
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> refreshSteps() async {
    state = const AsyncValue.loading();
    await _loadTodaySteps();
  }

  Future<void> startTracking() async {
    // 권한 요청
    final service = ref.read(stepTrackerServiceProvider);
    await service.requestPermissions();

    // 데이터 로드
    await _loadTodaySteps();
  }
}

final stepTrackerNotifierProvider = StateNotifierProvider<StepTrackerNotifier, AsyncValue<StepData?>>((ref) {
  return StepTrackerNotifier(ref);
});