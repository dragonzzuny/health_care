// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChallengeImpl _$$ChallengeImplFromJson(Map<String, dynamic> json) =>
    _$ChallengeImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      type: $enumDecode(_$ChallengeTypeEnumMap, json['type']),
      category: $enumDecode(_$ChallengeCategoryEnumMap, json['category']),
      targetValue: (json['targetValue'] as num).toInt(),
      unit: json['unit'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      status: $enumDecode(_$ChallengeStatusEnumMap, json['status']),
      currentProgress: (json['currentProgress'] as num?)?.toInt() ?? 0,
      points: (json['points'] as num?)?.toInt() ?? 0,
      isCustom: json['isCustom'] as bool? ?? false,
      createdBy: json['createdBy'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$$ChallengeImplToJson(_$ChallengeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'type': _$ChallengeTypeEnumMap[instance.type]!,
      'category': _$ChallengeCategoryEnumMap[instance.category]!,
      'targetValue': instance.targetValue,
      'unit': instance.unit,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'status': _$ChallengeStatusEnumMap[instance.status]!,
      'currentProgress': instance.currentProgress,
      'points': instance.points,
      'isCustom': instance.isCustom,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
    };

const _$ChallengeTypeEnumMap = {
  ChallengeType.daily: 'daily',
  ChallengeType.weekly: 'weekly',
  ChallengeType.personal: 'personal',
};

const _$ChallengeCategoryEnumMap = {
  ChallengeCategory.steps: 'steps',
  ChallengeCategory.sleep: 'sleep',
  ChallengeCategory.water: 'water',
  ChallengeCategory.exercise: 'exercise',
  ChallengeCategory.custom: 'custom',
};

const _$ChallengeStatusEnumMap = {
  ChallengeStatus.active: 'active',
  ChallengeStatus.completed: 'completed',
  ChallengeStatus.failed: 'failed',
  ChallengeStatus.paused: 'paused',
};

_$ChallengeProgressImpl _$$ChallengeProgressImplFromJson(
        Map<String, dynamic> json) =>
    _$ChallengeProgressImpl(
      challengeId: json['challengeId'] as String,
      date: DateTime.parse(json['date'] as String),
      progressValue: (json['progressValue'] as num).toInt(),
      isCompleted: json['isCompleted'] as bool,
      notes: json['notes'] as String?,
      recordedAt: json['recordedAt'] == null
          ? null
          : DateTime.parse(json['recordedAt'] as String),
    );

Map<String, dynamic> _$$ChallengeProgressImplToJson(
        _$ChallengeProgressImpl instance) =>
    <String, dynamic>{
      'challengeId': instance.challengeId,
      'date': instance.date.toIso8601String(),
      'progressValue': instance.progressValue,
      'isCompleted': instance.isCompleted,
      'notes': instance.notes,
      'recordedAt': instance.recordedAt?.toIso8601String(),
    };

_$UserChallengeStatsImpl _$$UserChallengeStatsImplFromJson(
        Map<String, dynamic> json) =>
    _$UserChallengeStatsImpl(
      totalChallenges: (json['totalChallenges'] as num).toInt(),
      completedChallenges: (json['completedChallenges'] as num).toInt(),
      activeChallenges: (json['activeChallenges'] as num).toInt(),
      totalPoints: (json['totalPoints'] as num).toInt(),
      completionRate: (json['completionRate'] as num).toDouble(),
      recentCompleted: (json['recentCompleted'] as List<dynamic>)
          .map((e) => Challenge.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentActive: (json['currentActive'] as List<dynamic>)
          .map((e) => Challenge.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastUpdated: json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$$UserChallengeStatsImplToJson(
        _$UserChallengeStatsImpl instance) =>
    <String, dynamic>{
      'totalChallenges': instance.totalChallenges,
      'completedChallenges': instance.completedChallenges,
      'activeChallenges': instance.activeChallenges,
      'totalPoints': instance.totalPoints,
      'completionRate': instance.completionRate,
      'recentCompleted': instance.recentCompleted,
      'currentActive': instance.currentActive,
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
    };
