// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StepDataImpl _$$StepDataImplFromJson(Map<String, dynamic> json) =>
    _$StepDataImpl(
      date: DateTime.parse(json['date'] as String),
      steps: (json['steps'] as num).toInt(),
      points: (json['points'] as num).toInt(),
      dailyGoal: (json['dailyGoal'] as num?)?.toInt() ?? 10000,
    );

Map<String, dynamic> _$$StepDataImplToJson(_$StepDataImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'steps': instance.steps,
      'points': instance.points,
      'dailyGoal': instance.dailyGoal,
    };

_$WeeklyStepSummaryImpl _$$WeeklyStepSummaryImplFromJson(
        Map<String, dynamic> json) =>
    _$WeeklyStepSummaryImpl(
      weekStart: DateTime.parse(json['weekStart'] as String),
      totalSteps: (json['totalSteps'] as num).toInt(),
      totalPoints: (json['totalPoints'] as num).toInt(),
      dailySteps: (json['dailySteps'] as List<dynamic>)
          .map((e) => StepData.fromJson(e as Map<String, dynamic>))
          .toList(),
      averageSteps: (json['averageSteps'] as num).toDouble(),
      goalAchievedDays: (json['goalAchievedDays'] as num).toInt(),
    );

Map<String, dynamic> _$$WeeklyStepSummaryImplToJson(
        _$WeeklyStepSummaryImpl instance) =>
    <String, dynamic>{
      'weekStart': instance.weekStart.toIso8601String(),
      'totalSteps': instance.totalSteps,
      'totalPoints': instance.totalPoints,
      'dailySteps': instance.dailySteps,
      'averageSteps': instance.averageSteps,
      'goalAchievedDays': instance.goalAchievedDays,
    };
