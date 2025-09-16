import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/repositories/activity_repository.dart';
import '../../../shared/providers/database_providers.dart';
import '../../../core/mock/mock_food_data.dart'; // 사용자 ID
import '../../step_tracker/providers/step_tracker_providers.dart';

// 현재 사용자 ID
const String currentUserId = MockFoodData.userId;

/// 활동 리포지토리 프로바이더
final activityRepositoryProvider = Provider<ActivityRepository>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return ActivityRepository(database);
});

/// 오늘의 활동 데이터 프로바이더
final todayActivityProvider = FutureProvider<DailyActivity?>((ref) async {
  final repository = ref.watch(activityRepositoryProvider);
  final today = DateTime.now();
  return await repository.getDailyActivity(currentUserId, today);
});

/// 활동 목표 프로바이더
final activityGoalsProvider = FutureProvider<ActivityGoal?>((ref) async {
  final repository = ref.watch(activityRepositoryProvider);
  return await repository.getActivityGoals(currentUserId);
});

/// 오늘의 목표 달성률 프로바이더 (실제 걸음 수 연동)
final todayGoalProgressProvider = FutureProvider<Map<String, double>>((ref) async {
  try {
    // 실제 걸음 수 진행률 가져오기
    final stepProgress = await ref.read(refreshableDailyGoalProgressProvider.future);

    // 목표값들 (하드코딩, 추후 사용자 설정으로 변경 가능)
    const int dailyStepGoal = 10000;
    const int dailyCalorieGoal = 400;
    const int dailyActiveMinuteGoal = 30;
    const double dailyDistanceGoal = 8.0; // km

    // 실제 걸음 수 데이터 가져오기
    final todaySteps = await ref.read(refreshableTodayStepsProvider.future);
    final estimatedCalories = todaySteps * 0.04;
    final estimatedDistance = todaySteps * 0.0008;

    // Mock 데이터베이스에서 활동 시간 가져오기
    final repository = ref.watch(activityRepositoryProvider);
    final today = DateTime.now();
    final dbProgress = await repository.getGoalProgress(currentUserId, today);

    return {
      'steps': stepProgress,
      'calories': (estimatedCalories / dailyCalorieGoal).clamp(0.0, 1.0),
      'activeMinutes': dbProgress['activeMinutes'] ?? 0.0,
      'distance': (estimatedDistance / dailyDistanceGoal).clamp(0.0, 1.0),
    };
  } catch (e) {
    // 에러 발생시 Mock 데이터 사용
    final repository = ref.watch(activityRepositoryProvider);
    final today = DateTime.now();
    return await repository.getGoalProgress(currentUserId, today);
  }
});

/// 오늘의 활동 요약 프로바이더 (실제 Step Tracker 연동)
final todayActivitySummaryProvider = FutureProvider<Map<String, double>>((ref) async {
  try {
    // 실제 걸음 수 데이터 가져오기
    final todaySteps = await ref.read(refreshableTodayStepsProvider.future);

    // Mock 데이터베이스에서 다른 활동 데이터 가져오기
    final repository = ref.watch(activityRepositoryProvider);
    final today = DateTime.now();
    final dbSummary = await repository.getDailyActivitySummary(currentUserId, today);

    // 실제 걸음 수로 업데이트하고 칼로리 재계산
    final stepsDouble = todaySteps.toDouble();
    final estimatedCalories = stepsDouble * 0.04; // 1걸음당 약 0.04 칼로리
    final estimatedDistance = stepsDouble * 0.0008; // 1걸음당 약 0.8m

    return {
      'steps': stepsDouble,
      'calories': estimatedCalories,
      'activeMinutes': dbSummary['activeMinutes'] ?? 0.0,
      'distance': estimatedDistance,
    };
  } catch (e) {
    // 에러 발생시 Mock 데이터 사용
    final repository = ref.watch(activityRepositoryProvider);
    final today = DateTime.now();
    return await repository.getDailyActivitySummary(currentUserId, today);
  }
});

/// 주간 활동 데이터 프로바이더
final weeklyActivitiesProvider = FutureProvider<List<DailyActivity>>((ref) async {
  final repository = ref.watch(activityRepositoryProvider);
  return await repository.getWeeklyActivities(currentUserId);
});

/// 주간 활동 통계 프로바이더
final weeklyStatsProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final repository = ref.watch(activityRepositoryProvider);
  return await repository.getWeeklyStats(currentUserId);
});

/// 오늘의 운동 세션 프로바이더
final todayWorkoutsProvider = FutureProvider<List<WorkoutSession>>((ref) async {
  final repository = ref.watch(activityRepositoryProvider);
  final today = DateTime.now();
  return await repository.getDailyWorkouts(currentUserId, today);
});

/// 최근 운동 세션 프로바이더
final recentWorkoutsProvider = FutureProvider<List<WorkoutSession>>((ref) async {
  final repository = ref.watch(activityRepositoryProvider);
  return await repository.getRecentWorkouts(currentUserId, limit: 5);
});

/// 최근 체중 기록 프로바이더
final latestWeightProvider = FutureProvider<WeightRecord?>((ref) async {
  final repository = ref.watch(activityRepositoryProvider);
  return await repository.getLatestWeight(currentUserId);
});

/// 체중 히스토리 프로바이더 (최근 30일)
final weightHistoryProvider = FutureProvider<List<WeightRecord>>((ref) async {
  final repository = ref.watch(activityRepositoryProvider);
  return await repository.getWeightHistory(currentUserId, days: 30);
});

/// 운동 타입별 통계 프로바이더 (최근 30일)
final workoutTypeStatsProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final repository = ref.watch(activityRepositoryProvider);
  return await repository.getWorkoutTypeStats(currentUserId, days: 30);
});

/// 월간 활동 데이터 프로바이더
final monthlyActivitiesProvider = FutureProvider.family<List<DailyActivity>, DateTime>((ref, month) async {
  final repository = ref.watch(activityRepositoryProvider);
  return await repository.getMonthlyActivities(currentUserId, month);
});

/// 활동 상태 프로바이더 (걸음 수, 칼로리 등의 실시간 상태)
final activityStatusProvider = Provider<Map<String, String>>((ref) {
  final todayActivity = ref.watch(todayActivityProvider);
  final goalProgress = ref.watch(todayGoalProgressProvider);
  
  return todayActivity.when(
    data: (activity) => goalProgress.when(
      data: (progress) {
        if (activity == null) {
          return {
            'steps': '0',
            'stepStatus': '시작 전',
            'calories': '0',
            'calorieStatus': '시작 전',
            'activeMinutes': '0',
            'activeStatus': '시작 전',
          };
        }
        
        return {
          'steps': activity.steps.toString(),
          'stepStatus': _getProgressStatus(progress['steps'] ?? 0.0),
          'calories': activity.caloriesBurned.toString(),
          'calorieStatus': _getProgressStatus(progress['calories'] ?? 0.0),
          'activeMinutes': activity.activeMinutes.toString(),
          'activeStatus': _getProgressStatus(progress['activeMinutes'] ?? 0.0),
        };
      },
      loading: () => {
        'steps': '로딩중...',
        'stepStatus': '로딩중',
        'calories': '로딩중...',
        'calorieStatus': '로딩중',
        'activeMinutes': '로딩중...',
        'activeStatus': '로딩중',
      },
      error: (_, __) => {
        'steps': '오류',
        'stepStatus': '오류',
        'calories': '오류',
        'calorieStatus': '오류',
        'activeMinutes': '오류',
        'activeStatus': '오류',
      },
    ),
    loading: () => {
      'steps': '로딩중...',
      'stepStatus': '로딩중',
      'calories': '로딩중...',
      'calorieStatus': '로딩중',
      'activeMinutes': '로딩중...',
      'activeStatus': '로딩중',
    },
    error: (_, __) => {
      'steps': '오류',
      'stepStatus': '오류',
      'calories': '오류',
      'calorieStatus': '오류',
      'activeMinutes': '오류',
      'activeStatus': '오류',
    },
  );
});

/// 운동 세션 추가/수정/삭제를 위한 StateNotifier
class WorkoutSessionNotifier extends StateNotifier<AsyncValue<void>> {
  WorkoutSessionNotifier(this._repository) : super(const AsyncValue.data(null));
  
  final ActivityRepository _repository;
  
  /// 운동 세션 추가
  Future<void> addWorkoutSession({
    required String type,
    required String name,
    required DateTime startTime,
    required DateTime endTime,
    required int duration,
    required String intensity,
    required int caloriesBurned,
    String? notes,
  }) async {
    state = const AsyncValue.loading();
    
    try {
      await _repository.createWorkoutSession(
        WorkoutSessionsCompanion.insert(
          userId: currentUserId,
          type: type,
          name: name,
          startTime: startTime,
          endTime: endTime,
          duration: duration,
          intensity: Value(intensity),
          caloriesBurned: Value(caloriesBurned),
          notes: Value(notes),
        ),
      );
      
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
  
  /// 운동 세션 업데이트
  Future<void> updateWorkoutSession({
    required int sessionId,
    String? name,
    DateTime? startTime,
    DateTime? endTime,
    int? duration,
    String? intensity,
    int? caloriesBurned,
    String? notes,
  }) async {
    state = const AsyncValue.loading();
    
    try {
      await _repository.updateWorkoutSession(
        sessionId,
        WorkoutSessionsCompanion(
          name: name != null ? Value(name) : const Value.absent(),
          startTime: startTime != null ? Value(startTime) : const Value.absent(),
          endTime: endTime != null ? Value(endTime) : const Value.absent(),
          duration: duration != null ? Value(duration) : const Value.absent(),
          intensity: intensity != null ? Value(intensity) : const Value.absent(),
          caloriesBurned: caloriesBurned != null ? Value(caloriesBurned) : const Value.absent(),
          notes: notes != null ? Value(notes) : const Value.absent(),
        ),
      );
      
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
  
  /// 운동 세션 삭제
  Future<void> deleteWorkoutSession(int sessionId) async {
    state = const AsyncValue.loading();
    
    try {
      await _repository.deleteWorkoutSession(sessionId);
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

/// 운동 세션 관리 프로바이더
final workoutSessionProvider = StateNotifierProvider<WorkoutSessionNotifier, AsyncValue<void>>((ref) {
  final repository = ref.watch(activityRepositoryProvider);
  return WorkoutSessionNotifier(repository);
});

/// 체중 기록 추가/수정/삭제를 위한 StateNotifier
class WeightRecordNotifier extends StateNotifier<AsyncValue<void>> {
  WeightRecordNotifier(this._repository) : super(const AsyncValue.data(null));
  
  final ActivityRepository _repository;
  
  /// 체중 기록 추가
  Future<void> addWeightRecord({
    required DateTime date,
    required double weight,
    double? bodyFatPercentage,
    double? muscleMass,
    String? notes,
  }) async {
    state = const AsyncValue.loading();
    
    try {
      await _repository.createWeightRecord(
        WeightRecordsCompanion.insert(
          userId: currentUserId,
          date: date,
          weight: weight,
          bodyFatPercentage: Value(bodyFatPercentage),
          muscleMass: Value(muscleMass),
          notes: Value(notes),
        ),
      );
      
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
  
  /// 체중 기록 업데이트
  Future<void> updateWeightRecord({
    required int recordId,
    double? weight,
    double? bodyFatPercentage,
    double? muscleMass,
    String? notes,
  }) async {
    state = const AsyncValue.loading();
    
    try {
      await _repository.updateWeightRecord(
        recordId,
        WeightRecordsCompanion(
          weight: weight != null ? Value(weight) : const Value.absent(),
          bodyFatPercentage: bodyFatPercentage != null ? Value(bodyFatPercentage) : const Value.absent(),
          muscleMass: muscleMass != null ? Value(muscleMass) : const Value.absent(),
          notes: notes != null ? Value(notes) : const Value.absent(),
        ),
      );
      
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
  
  /// 체중 기록 삭제
  Future<void> deleteWeightRecord(int recordId) async {
    state = const AsyncValue.loading();
    
    try {
      await _repository.deleteWeightRecord(recordId);
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

/// 체중 기록 관리 프로바이더
final weightRecordProvider = StateNotifierProvider<WeightRecordNotifier, AsyncValue<void>>((ref) {
  final repository = ref.watch(activityRepositoryProvider);
  return WeightRecordNotifier(repository);
});

/// 목표 달성률에 따른 상태 메시지
String _getProgressStatus(double progress) {
  if (progress >= 1.0) return '목표 달성!';
  if (progress >= 0.8) return '거의 다 왔어요!';
  if (progress >= 0.5) return '절반 완료!';
  if (progress >= 0.3) return '좋은 시작!';
  if (progress > 0.0) return '시작했어요!';
  return '시작해보세요';
}