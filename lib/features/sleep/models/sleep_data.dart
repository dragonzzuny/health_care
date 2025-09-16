import 'package:freezed_annotation/freezed_annotation.dart';

part 'sleep_data.freezed.dart';
part 'sleep_data.g.dart';

@freezed
class SleepSession with _$SleepSession {
  const factory SleepSession({
    required String id,
    required DateTime bedTime,
    required DateTime wakeTime,
    required Duration sleepDuration,
    required SleepQuality quality,
    String? notes,
    @Default(false) bool isManualEntry,
    DateTime? createdAt,
  }) = _SleepSession;

  factory SleepSession.fromJson(Map<String, dynamic> json) => _$SleepSessionFromJson(json);
}

@freezed
class SleepStats with _$SleepStats {
  const factory SleepStats({
    required Duration averageSleepDuration,
    required Duration totalSleepTime,
    required int totalSessions,
    required double averageQualityScore,
    required DateTime startDate,
    required DateTime endDate,
    required List<SleepSession> sessions,
  }) = _SleepStats;

  factory SleepStats.fromJson(Map<String, dynamic> json) => _$SleepStatsFromJson(json);
}

enum SleepQuality {
  excellent(5, '매우 좋음', '😴'),
  good(4, '좋음', '😊'),
  fair(3, '보통', '😐'),
  poor(2, '나쁨', '😔'),
  terrible(1, '매우 나쁨', '😫');

  const SleepQuality(this.score, this.label, this.emoji);

  final int score;
  final String label;
  final String emoji;
}

@freezed
class SleepGoal with _$SleepGoal {
  const factory SleepGoal({
    required Duration targetSleepDuration,
    required Duration targetBedTime,
    required Duration targetWakeTime,
    @Default(true) bool isActive,
    DateTime? createdAt,
  }) = _SleepGoal;

  factory SleepGoal.fromJson(Map<String, dynamic> json) => _$SleepGoalFromJson(json);
}