import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/challenge_data.dart';
import '../../step_tracker/services/step_tracker_service.dart';
import '../../sleep/services/sleep_tracker_service.dart';

class ChallengeService {
  static final ChallengeService _instance = ChallengeService._internal();
  factory ChallengeService() => _instance;
  ChallengeService._internal();

  static const String _challengesKey = 'user_challenges';

  final StepTrackerService _stepTrackerService = StepTrackerService();
  final SleepTrackerService _sleepTrackerService = SleepTrackerService();

  // 사용자 챌린지 목록 가져오기
  Future<List<Challenge>> getUserChallenges() async {
    final prefs = await SharedPreferences.getInstance();
    final challengesJson = prefs.getString(_challengesKey);

    if (challengesJson == null) {
      // 첫 실행시 기본 챌린지들 생성
      await _initializeDefaultChallenges();
      return await getUserChallenges();
    }

    final challengesList = json.decode(challengesJson) as List;
    return challengesList.map((c) => Challenge.fromJson(c)).toList();
  }

  // 기본 챌린지들 초기화
  Future<void> _initializeDefaultChallenges() async {
    final dailyTemplates = ChallengeTemplates.getDailyTemplates();
    final weeklyTemplates = ChallengeTemplates.getWeeklyTemplates();

    final allChallenges = [...dailyTemplates, ...weeklyTemplates];
    await _saveChallenges(allChallenges);
  }

  // 챌린지 저장
  Future<void> _saveChallenges(List<Challenge> challenges) async {
    final prefs = await SharedPreferences.getInstance();
    final challengesJson = challenges.map((c) => c.toJson()).toList();
    await prefs.setString(_challengesKey, json.encode(challengesJson));
  }

  // 활성 챌린지 가져오기
  Future<List<Challenge>> getActiveChallenges() async {
    final challenges = await getUserChallenges();
    return challenges.where((c) => c.status == ChallengeStatus.active).toList();
  }

  // 완료된 챌린지 가져오기
  Future<List<Challenge>> getCompletedChallenges() async {
    final challenges = await getUserChallenges();
    return challenges.where((c) => c.status == ChallengeStatus.completed).toList();
  }

  // 타입별 챌린지 가져오기
  Future<List<Challenge>> getChallengesByType(ChallengeType type) async {
    final challenges = await getUserChallenges();
    return challenges.where((c) => c.type == type).toList();
  }

  // 새 챌린지 추가
  Future<Challenge> addChallenge(Challenge challenge) async {
    final challenges = await getUserChallenges();
    challenges.add(challenge);
    await _saveChallenges(challenges);
    return challenge;
  }

  // 챌린지 업데이트
  Future<void> updateChallenge(Challenge updatedChallenge) async {
    final challenges = await getUserChallenges();
    final index = challenges.indexWhere((c) => c.id == updatedChallenge.id);

    if (index != -1) {
      challenges[index] = updatedChallenge;
      await _saveChallenges(challenges);
    }
  }

  // 챌린지 삭제
  Future<void> deleteChallenge(String challengeId) async {
    final challenges = await getUserChallenges();
    challenges.removeWhere((c) => c.id == challengeId);
    await _saveChallenges(challenges);
  }

  // 챌린지 진행률 업데이트
  Future<void> updateChallengeProgress() async {
    final challenges = await getUserChallenges();
    final now = DateTime.now();
    bool hasUpdates = false;

    for (int i = 0; i < challenges.length; i++) {
      final challenge = challenges[i];

      // 만료된 챌린지 처리
      if (now.isAfter(challenge.endDate) && challenge.status == ChallengeStatus.active) {
        challenges[i] = challenge.copyWith(
          status: challenge.currentProgress >= challenge.targetValue
            ? ChallengeStatus.completed
            : ChallengeStatus.failed,
          completedAt: challenge.currentProgress >= challenge.targetValue ? now : null,
        );
        hasUpdates = true;
        continue;
      }

      // 활성 챌린지만 진행률 업데이트
      if (challenge.status != ChallengeStatus.active) continue;

      int newProgress = 0;

      switch (challenge.category) {
        case ChallengeCategory.steps:
          if (challenge.type == ChallengeType.daily) {
            newProgress = await _stepTrackerService.getTodaySteps();
          } else if (challenge.type == ChallengeType.weekly) {
            final weeklyStats = await _stepTrackerService.getWeeklyStepSummary();
            newProgress = weeklyStats.totalSteps;
          }
          break;

        case ChallengeCategory.sleep:
          if (challenge.type == ChallengeType.daily) {
            final todaySleep = await _sleepTrackerService.getTodaySleep();
            if (todaySleep != null) {
              newProgress = todaySleep.sleepDuration.inHours;
            }
          }
          break;

        case ChallengeCategory.water:
        case ChallengeCategory.exercise:
        case ChallengeCategory.custom:
          // 이런 카테고리는 수동으로 업데이트
          break;
      }

      if (newProgress != challenge.currentProgress) {
        final isCompleted = newProgress >= challenge.targetValue;
        challenges[i] = challenge.copyWith(
          currentProgress: newProgress,
          status: isCompleted ? ChallengeStatus.completed : ChallengeStatus.active,
          completedAt: isCompleted ? now : null,
        );
        hasUpdates = true;
      }
    }

    if (hasUpdates) {
      await _saveChallenges(challenges);
    }
  }

  // 수동으로 챌린지 진행률 업데이트
  Future<void> updateManualProgress(String challengeId, int progressValue) async {
    final challenges = await getUserChallenges();
    final index = challenges.indexWhere((c) => c.id == challengeId);

    if (index != -1) {
      final challenge = challenges[index];
      final isCompleted = progressValue >= challenge.targetValue;

      challenges[index] = challenge.copyWith(
        currentProgress: progressValue,
        status: isCompleted ? ChallengeStatus.completed : ChallengeStatus.active,
        completedAt: isCompleted ? DateTime.now() : null,
      );

      await _saveChallenges(challenges);
    }
  }

  // 사용자 챌린지 통계 가져오기
  Future<UserChallengeStats> getUserStats() async {
    final challenges = await getUserChallenges();

    final totalChallenges = challenges.length;
    final completedChallenges = challenges.where((c) => c.status == ChallengeStatus.completed).length;
    final activeChallenges = challenges.where((c) => c.status == ChallengeStatus.active).length;
    final totalPoints = challenges
        .where((c) => c.status == ChallengeStatus.completed)
        .fold<int>(0, (sum, c) => sum + c.points);

    final completionRate = totalChallenges > 0 ? completedChallenges / totalChallenges : 0.0;

    final recentCompleted = challenges
        .where((c) => c.status == ChallengeStatus.completed)
        .toList()
      ..sort((a, b) => (b.completedAt ?? DateTime.now()).compareTo(a.completedAt ?? DateTime.now()));

    final currentActive = challenges
        .where((c) => c.status == ChallengeStatus.active)
        .toList();

    return UserChallengeStats(
      totalChallenges: totalChallenges,
      completedChallenges: completedChallenges,
      activeChallenges: activeChallenges,
      totalPoints: totalPoints,
      completionRate: completionRate,
      recentCompleted: recentCompleted.take(5).toList(),
      currentActive: currentActive,
      lastUpdated: DateTime.now(),
    );
  }

  // 새로운 개인 챌린지 생성
  Future<Challenge> createPersonalChallenge({
    required String title,
    required String description,
    required ChallengeCategory category,
    required int targetValue,
    required String unit,
    required DateTime startDate,
    required DateTime endDate,
    int points = 100,
  }) async {
    final challengeId = 'personal_${DateTime.now().millisecondsSinceEpoch}';

    final challenge = Challenge(
      id: challengeId,
      title: title,
      description: description,
      type: ChallengeType.personal,
      category: category,
      targetValue: targetValue,
      unit: unit,
      startDate: startDate,
      endDate: endDate,
      status: ChallengeStatus.active,
      points: points,
      isCustom: true,
      createdBy: 'user',
      createdAt: DateTime.now(),
    );

    return await addChallenge(challenge);
  }

  // 일일 챌린지 리셋 (자정에 호출)
  Future<void> resetDailyChallenges() async {
    final challenges = await getUserChallenges();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    bool hasUpdates = false;

    for (int i = 0; i < challenges.length; i++) {
      final challenge = challenges[i];

      if (challenge.type == ChallengeType.daily && !challenge.isCustom) {
        // 기본 일일 챌린지들은 매일 리셋
        challenges[i] = challenge.copyWith(
          currentProgress: 0,
          status: ChallengeStatus.active,
          startDate: today,
          endDate: DateTime(today.year, today.month, today.day, 23, 59, 59),
          completedAt: null,
        );
        hasUpdates = true;
      }
    }

    if (hasUpdates) {
      await _saveChallenges(challenges);
    }
  }
}