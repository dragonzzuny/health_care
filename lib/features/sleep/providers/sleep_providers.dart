import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/sleep_data.dart';
import '../services/sleep_tracker_service.dart';

// Sleep Tracker Service Provider
final sleepTrackerServiceProvider = Provider<SleepTrackerService>((ref) {
  return SleepTrackerService();
});

// Current Sleep Status Provider
final currentSleepStatusProvider = FutureProvider<bool>((ref) async {
  final service = ref.read(sleepTrackerServiceProvider);
  return await service.isSleeping();
});

// Current Sleep Session Provider
final currentSleepSessionProvider = FutureProvider<Map<String, dynamic>?>((ref) async {
  final service = ref.read(sleepTrackerServiceProvider);
  return await service.getCurrentSleepSession();
});

// Today's Sleep Provider
final todaySleepProvider = FutureProvider<SleepSession?>((ref) async {
  final service = ref.read(sleepTrackerServiceProvider);
  return await service.getTodaySleep();
});

// Weekly Sleep Stats Provider
final weeklySleepStatsProvider = FutureProvider<SleepStats>((ref) async {
  final service = ref.read(sleepTrackerServiceProvider);
  return await service.getWeeklySleepStats();
});

// Sleep Goal Provider
final sleepGoalProvider = FutureProvider<SleepGoal?>((ref) async {
  final service = ref.read(sleepTrackerServiceProvider);
  return await service.getSleepGoal();
});

// All Sleep Sessions Provider
final allSleepSessionsProvider = FutureProvider<List<SleepSession>>((ref) async {
  final service = ref.read(sleepTrackerServiceProvider);
  return await service.getSleepSessions();
});

// Sleep Tracker State Notifier
class SleepTrackerNotifier extends StateNotifier<AsyncValue<SleepSession?>> {
  SleepTrackerNotifier(this.ref) : super(const AsyncValue.loading()) {
    _loadTodaySleep();
  }

  final Ref ref;

  Future<void> _loadTodaySleep() async {
    try {
      final service = ref.read(sleepTrackerServiceProvider);
      final todaySleep = await service.getTodaySleep();
      state = AsyncValue.data(todaySleep);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<String?> startSleep() async {
    try {
      final service = ref.read(sleepTrackerServiceProvider);
      final sessionId = await service.startSleep();

      // 상태 업데이트
      ref.invalidate(currentSleepStatusProvider);
      ref.invalidate(currentSleepSessionProvider);

      return sessionId;
    } catch (e) {
      return null;
    }
  }

  Future<SleepSession?> endSleep(SleepQuality quality, {String? notes}) async {
    try {
      final service = ref.read(sleepTrackerServiceProvider);
      final session = await service.endSleep(quality, notes: notes);

      if (session != null) {
        state = AsyncValue.data(session);

        // 관련 프로바이더들 새로고침
        ref.invalidate(currentSleepStatusProvider);
        ref.invalidate(currentSleepSessionProvider);
        ref.invalidate(weeklySleepStatsProvider);
        ref.invalidate(allSleepSessionsProvider);
      }

      return session;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return null;
    }
  }

  Future<SleepSession?> addManualSleepRecord({
    required DateTime bedTime,
    required DateTime wakeTime,
    required SleepQuality quality,
    String? notes,
  }) async {
    try {
      final service = ref.read(sleepTrackerServiceProvider);
      final session = await service.addManualSleepRecord(
        bedTime: bedTime,
        wakeTime: wakeTime,
        quality: quality,
        notes: notes,
      );

      // 상태 및 관련 프로바이더들 새로고침
      await _loadTodaySleep();
      ref.invalidate(weeklySleepStatsProvider);
      ref.invalidate(allSleepSessionsProvider);

      return session;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return null;
    }
  }

  Future<void> deleteSleepSession(String sessionId) async {
    try {
      final service = ref.read(sleepTrackerServiceProvider);
      await service.deleteSleepSession(sessionId);

      // 상태 및 관련 프로바이더들 새로고침
      await _loadTodaySleep();
      ref.invalidate(weeklySleepStatsProvider);
      ref.invalidate(allSleepSessionsProvider);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> setSleepGoal(SleepGoal goal) async {
    try {
      final service = ref.read(sleepTrackerServiceProvider);
      await service.setSleepGoal(goal);
      ref.invalidate(sleepGoalProvider);
    } catch (e) {
      // 에러 처리
    }
  }

  void refreshData() {
    _loadTodaySleep();
    ref.invalidate(weeklySleepStatsProvider);
    ref.invalidate(currentSleepStatusProvider);
    ref.invalidate(currentSleepSessionProvider);
  }
}

final sleepTrackerNotifierProvider = StateNotifierProvider<SleepTrackerNotifier, AsyncValue<SleepSession?>>((ref) {
  return SleepTrackerNotifier(ref);
});

// Auto-refresh provider for current sleep session (every minute)
final sleepSessionAutoRefreshProvider = StreamProvider<int>((ref) {
  return Stream.periodic(const Duration(minutes: 1), (count) => count);
});

// Sleep Quality Score Provider
final sleepQualityScoreProvider = FutureProvider<double>((ref) async {
  final stats = await ref.read(weeklySleepStatsProvider.future);
  return stats.averageQualityScore;
});

// Sleep Goal Achievement Provider
final sleepGoalAchievementProvider = FutureProvider<double>((ref) async {
  final goal = await ref.read(sleepGoalProvider.future);
  final todaySleep = await ref.read(todaySleepProvider.future);

  if (goal == null || todaySleep == null) return 0.0;

  final targetDuration = goal.targetSleepDuration;
  final actualDuration = todaySleep.sleepDuration;

  return (actualDuration.inMinutes / targetDuration.inMinutes).clamp(0.0, 1.0);
});