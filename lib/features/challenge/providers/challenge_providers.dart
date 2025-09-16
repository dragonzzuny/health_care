import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/challenge_data.dart';
import '../services/challenge_service.dart';

// Challenge Service Provider
final challengeServiceProvider = Provider<ChallengeService>((ref) {
  return ChallengeService();
});

// All User Challenges Provider
final userChallengesProvider = FutureProvider<List<Challenge>>((ref) async {
  final service = ref.read(challengeServiceProvider);
  return await service.getUserChallenges();
});

// Active Challenges Provider
final activeChallengesProvider = FutureProvider<List<Challenge>>((ref) async {
  final service = ref.read(challengeServiceProvider);
  return await service.getActiveChallenges();
});

// Completed Challenges Provider
final completedChallengesProvider = FutureProvider<List<Challenge>>((ref) async {
  final service = ref.read(challengeServiceProvider);
  return await service.getCompletedChallenges();
});

// Daily Challenges Provider
final dailyChallengesProvider = FutureProvider<List<Challenge>>((ref) async {
  final service = ref.read(challengeServiceProvider);
  return await service.getChallengesByType(ChallengeType.daily);
});

// Weekly Challenges Provider
final weeklyChallengesProvider = FutureProvider<List<Challenge>>((ref) async {
  final service = ref.read(challengeServiceProvider);
  return await service.getChallengesByType(ChallengeType.weekly);
});

// Personal Challenges Provider
final personalChallengesProvider = FutureProvider<List<Challenge>>((ref) async {
  final service = ref.read(challengeServiceProvider);
  return await service.getChallengesByType(ChallengeType.personal);
});

// User Challenge Stats Provider
final userChallengeStatsProvider = FutureProvider<UserChallengeStats>((ref) async {
  final service = ref.read(challengeServiceProvider);
  return await service.getUserStats();
});

// Challenge Manager State Notifier
class ChallengeManagerNotifier extends StateNotifier<AsyncValue<List<Challenge>>> {
  ChallengeManagerNotifier(this.ref) : super(const AsyncValue.loading()) {
    _loadChallenges();
  }

  final Ref ref;

  Future<void> _loadChallenges() async {
    try {
      final service = ref.read(challengeServiceProvider);
      final challenges = await service.getUserChallenges();
      state = AsyncValue.data(challenges);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  // 챌린지 진행률 업데이트
  Future<void> updateProgress() async {
    try {
      final service = ref.read(challengeServiceProvider);
      await service.updateChallengeProgress();

      // 관련 프로바이더들 새로고침
      ref.invalidate(userChallengesProvider);
      ref.invalidate(activeChallengesProvider);
      ref.invalidate(userChallengeStatsProvider);
      ref.invalidate(dailyChallengesProvider);
      ref.invalidate(weeklyChallengesProvider);

      await _loadChallenges();
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  // 새 개인 챌린지 생성
  Future<Challenge?> createPersonalChallenge({
    required String title,
    required String description,
    required ChallengeCategory category,
    required int targetValue,
    required String unit,
    required DateTime startDate,
    required DateTime endDate,
    int points = 100,
  }) async {
    try {
      final service = ref.read(challengeServiceProvider);
      final challenge = await service.createPersonalChallenge(
        title: title,
        description: description,
        category: category,
        targetValue: targetValue,
        unit: unit,
        startDate: startDate,
        endDate: endDate,
        points: points,
      );

      // 상태 및 관련 프로바이더들 새로고침
      await _loadChallenges();
      ref.invalidate(personalChallengesProvider);
      ref.invalidate(activeChallengesProvider);
      ref.invalidate(userChallengeStatsProvider);

      return challenge;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return null;
    }
  }

  // 수동 진행률 업데이트
  Future<void> updateManualProgress(String challengeId, int progressValue) async {
    try {
      final service = ref.read(challengeServiceProvider);
      await service.updateManualProgress(challengeId, progressValue);

      // 상태 및 관련 프로바이더들 새로고침
      await _loadChallenges();
      ref.invalidate(activeChallengesProvider);
      ref.invalidate(userChallengeStatsProvider);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  // 챌린지 삭제
  Future<void> deleteChallenge(String challengeId) async {
    try {
      final service = ref.read(challengeServiceProvider);
      await service.deleteChallenge(challengeId);

      // 상태 및 관련 프로바이더들 새로고침
      await _loadChallenges();
      ref.invalidate(activeChallengesProvider);
      ref.invalidate(personalChallengesProvider);
      ref.invalidate(userChallengeStatsProvider);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  // 일일 챌린지 리셋
  Future<void> resetDailyChallenges() async {
    try {
      final service = ref.read(challengeServiceProvider);
      await service.resetDailyChallenges();

      // 상태 및 관련 프로바이더들 새로고침
      await _loadChallenges();
      ref.invalidate(dailyChallengesProvider);
      ref.invalidate(activeChallengesProvider);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  // 데이터 새로고침
  void refreshData() {
    _loadChallenges();
    ref.invalidate(userChallengesProvider);
    ref.invalidate(activeChallengesProvider);
    ref.invalidate(completedChallengesProvider);
    ref.invalidate(userChallengeStatsProvider);
    ref.invalidate(dailyChallengesProvider);
    ref.invalidate(weeklyChallengesProvider);
    ref.invalidate(personalChallengesProvider);
  }
}

final challengeManagerProvider = StateNotifierProvider<ChallengeManagerNotifier, AsyncValue<List<Challenge>>>((ref) {
  return ChallengeManagerNotifier(ref);
});

// Auto-refresh provider for challenge progress (every 5 minutes)
final challengeAutoRefreshProvider = StreamProvider<int>((ref) {
  return Stream.periodic(const Duration(minutes: 5), (count) => count);
});

// Challenge completion rate provider
final challengeCompletionRateProvider = FutureProvider<double>((ref) async {
  final stats = await ref.read(userChallengeStatsProvider.future);
  return stats.completionRate;
});

// Today's challenge progress provider
final todayChallengeProgressProvider = FutureProvider<Map<String, double>>((ref) async {
  final dailyChallenges = await ref.read(dailyChallengesProvider.future);
  final Map<String, double> progressMap = {};

  for (final challenge in dailyChallenges) {
    if (challenge.status == ChallengeStatus.active || challenge.status == ChallengeStatus.completed) {
      final progress = challenge.targetValue > 0
        ? (challenge.currentProgress / challenge.targetValue).clamp(0.0, 1.0)
        : 0.0;
      progressMap[challenge.id] = progress;
    }
  }

  return progressMap;
});

// Challenge points earned today provider
final todayPointsEarnedProvider = FutureProvider<int>((ref) async {
  final completedChallenges = await ref.read(completedChallengesProvider.future);
  final today = DateTime.now();

  return completedChallenges
      .where((challenge) =>
          challenge.completedAt != null &&
          challenge.completedAt!.year == today.year &&
          challenge.completedAt!.month == today.month &&
          challenge.completedAt!.day == today.day)
      .fold<int>(0, (sum, challenge) => sum + challenge.points);
});