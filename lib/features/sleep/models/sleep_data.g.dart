// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sleep_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SleepSessionImpl _$$SleepSessionImplFromJson(Map<String, dynamic> json) =>
    _$SleepSessionImpl(
      id: json['id'] as String,
      bedTime: DateTime.parse(json['bedTime'] as String),
      wakeTime: DateTime.parse(json['wakeTime'] as String),
      sleepDuration:
          Duration(microseconds: (json['sleepDuration'] as num).toInt()),
      quality: $enumDecode(_$SleepQualityEnumMap, json['quality']),
      notes: json['notes'] as String?,
      isManualEntry: json['isManualEntry'] as bool? ?? false,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$SleepSessionImplToJson(_$SleepSessionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bedTime': instance.bedTime.toIso8601String(),
      'wakeTime': instance.wakeTime.toIso8601String(),
      'sleepDuration': instance.sleepDuration.inMicroseconds,
      'quality': _$SleepQualityEnumMap[instance.quality]!,
      'notes': instance.notes,
      'isManualEntry': instance.isManualEntry,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$SleepQualityEnumMap = {
  SleepQuality.excellent: 'excellent',
  SleepQuality.good: 'good',
  SleepQuality.fair: 'fair',
  SleepQuality.poor: 'poor',
  SleepQuality.terrible: 'terrible',
};

_$SleepStatsImpl _$$SleepStatsImplFromJson(Map<String, dynamic> json) =>
    _$SleepStatsImpl(
      averageSleepDuration:
          Duration(microseconds: (json['averageSleepDuration'] as num).toInt()),
      totalSleepTime:
          Duration(microseconds: (json['totalSleepTime'] as num).toInt()),
      totalSessions: (json['totalSessions'] as num).toInt(),
      averageQualityScore: (json['averageQualityScore'] as num).toDouble(),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      sessions: (json['sessions'] as List<dynamic>)
          .map((e) => SleepSession.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SleepStatsImplToJson(_$SleepStatsImpl instance) =>
    <String, dynamic>{
      'averageSleepDuration': instance.averageSleepDuration.inMicroseconds,
      'totalSleepTime': instance.totalSleepTime.inMicroseconds,
      'totalSessions': instance.totalSessions,
      'averageQualityScore': instance.averageQualityScore,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'sessions': instance.sessions,
    };

_$SleepGoalImpl _$$SleepGoalImplFromJson(Map<String, dynamic> json) =>
    _$SleepGoalImpl(
      targetSleepDuration:
          Duration(microseconds: (json['targetSleepDuration'] as num).toInt()),
      targetBedTime:
          Duration(microseconds: (json['targetBedTime'] as num).toInt()),
      targetWakeTime:
          Duration(microseconds: (json['targetWakeTime'] as num).toInt()),
      isActive: json['isActive'] as bool? ?? true,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$SleepGoalImplToJson(_$SleepGoalImpl instance) =>
    <String, dynamic>{
      'targetSleepDuration': instance.targetSleepDuration.inMicroseconds,
      'targetBedTime': instance.targetBedTime.inMicroseconds,
      'targetWakeTime': instance.targetWakeTime.inMicroseconds,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
