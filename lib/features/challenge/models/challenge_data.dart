import 'package:freezed_annotation/freezed_annotation.dart';

part 'challenge_data.freezed.dart';
part 'challenge_data.g.dart';

enum ChallengeType {
  daily('일간', '매일'),
  weekly('주간', '매주'),
  personal('개인', '개인설정');

  const ChallengeType(this.label, this.description);
  final String label;
  final String description;
}

enum ChallengeCategory {
  steps('걸음수', '👟'),
  sleep('수면', '😴'),
  water('물마시기', '💧'),
  exercise('운동', '💪'),
  custom('기타', '🎯');

  const ChallengeCategory(this.label, this.emoji);
  final String label;
  final String emoji;
}

enum ChallengeStatus {
  active('진행중'),
  completed('완료'),
  failed('실패'),
  paused('일시정지');

  const ChallengeStatus(this.label);
  final String label;
}

@freezed
class Challenge with _$Challenge {
  const factory Challenge({
    required String id,
    required String title,
    required String description,
    required ChallengeType type,
    required ChallengeCategory category,
    required int targetValue,
    required String unit,
    required DateTime startDate,
    required DateTime endDate,
    required ChallengeStatus status,
    @Default(0) int currentProgress,
    @Default(0) int points,
    @Default(false) bool isCustom,
    String? createdBy,
    DateTime? createdAt,
    DateTime? completedAt,
  }) = _Challenge;

  factory Challenge.fromJson(Map<String, dynamic> json) => _$ChallengeFromJson(json);
}

@freezed
class ChallengeProgress with _$ChallengeProgress {
  const factory ChallengeProgress({
    required String challengeId,
    required DateTime date,
    required int progressValue,
    required bool isCompleted,
    String? notes,
    DateTime? recordedAt,
  }) = _ChallengeProgress;

  factory ChallengeProgress.fromJson(Map<String, dynamic> json) => _$ChallengeProgressFromJson(json);
}

@freezed
class UserChallengeStats with _$UserChallengeStats {
  const factory UserChallengeStats({
    required int totalChallenges,
    required int completedChallenges,
    required int activeChallenges,
    required int totalPoints,
    required double completionRate,
    required List<Challenge> recentCompleted,
    required List<Challenge> currentActive,
    DateTime? lastUpdated,
  }) = _UserChallengeStats;

  factory UserChallengeStats.fromJson(Map<String, dynamic> json) => _$UserChallengeStatsFromJson(json);
}

// 사전 정의된 챌린지 템플릿
class ChallengeTemplates {
  static List<Challenge> getDailyTemplates() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

    return [
      Challenge(
        id: 'daily_steps_10k',
        title: '만보 걷기',
        description: '하루에 10,000걸음 걷기',
        type: ChallengeType.daily,
        category: ChallengeCategory.steps,
        targetValue: 10000,
        unit: '걸음',
        startDate: startOfDay,
        endDate: endOfDay,
        status: ChallengeStatus.active,
        points: 100,
        createdAt: now,
      ),
      Challenge(
        id: 'daily_sleep_8h',
        title: '충분한 수면',
        description: '하루에 8시간 잠자기',
        type: ChallengeType.daily,
        category: ChallengeCategory.sleep,
        targetValue: 8,
        unit: '시간',
        startDate: startOfDay,
        endDate: endOfDay,
        status: ChallengeStatus.active,
        points: 80,
        createdAt: now,
      ),
      Challenge(
        id: 'daily_water_8cups',
        title: '물 8잔 마시기',
        description: '하루에 물 8잔(2L) 마시기',
        type: ChallengeType.daily,
        category: ChallengeCategory.water,
        targetValue: 8,
        unit: '잔',
        startDate: startOfDay,
        endDate: endOfDay,
        status: ChallengeStatus.active,
        points: 60,
        createdAt: now,
      ),
    ];
  }

  static List<Challenge> getWeeklyTemplates() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6, hours: 23, minutes: 59, seconds: 59));

    return [
      Challenge(
        id: 'weekly_steps_70k',
        title: '주간 7만보 달성',
        description: '일주일 동안 총 70,000걸음 걷기',
        type: ChallengeType.weekly,
        category: ChallengeCategory.steps,
        targetValue: 70000,
        unit: '걸음',
        startDate: DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day),
        endDate: endOfWeek,
        status: ChallengeStatus.active,
        points: 500,
        createdAt: now,
      ),
      Challenge(
        id: 'weekly_exercise_5days',
        title: '주 5일 운동하기',
        description: '일주일에 5일 이상 운동하기',
        type: ChallengeType.weekly,
        category: ChallengeCategory.exercise,
        targetValue: 5,
        unit: '일',
        startDate: DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day),
        endDate: endOfWeek,
        status: ChallengeStatus.active,
        points: 300,
        createdAt: now,
      ),
    ];
  }
}