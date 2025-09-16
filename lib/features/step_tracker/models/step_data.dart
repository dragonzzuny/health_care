import 'package:freezed_annotation/freezed_annotation.dart';

part 'step_data.freezed.dart';
part 'step_data.g.dart';

@freezed
class StepData with _$StepData {
  const factory StepData({
    required DateTime date,
    required int steps,
    required int points,
    @Default(10000) int dailyGoal,
  }) = _StepData;

  factory StepData.fromJson(Map<String, dynamic> json) => _$StepDataFromJson(json);
}

@freezed
class WeeklyStepSummary with _$WeeklyStepSummary {
  const factory WeeklyStepSummary({
    required DateTime weekStart,
    required int totalSteps,
    required int totalPoints,
    required List<StepData> dailySteps,
    required double averageSteps,
    required int goalAchievedDays,
  }) = _WeeklyStepSummary;

  factory WeeklyStepSummary.fromJson(Map<String, dynamic> json) => _$WeeklyStepSummaryFromJson(json);
}