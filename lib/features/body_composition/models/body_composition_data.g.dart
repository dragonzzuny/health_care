// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_composition_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BodyCompositionImpl _$$BodyCompositionImplFromJson(
        Map<String, dynamic> json) =>
    _$BodyCompositionImpl(
      id: json['id'] as String,
      measurementDate: DateTime.parse(json['measurementDate'] as String),
      weight: (json['weight'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      bodyFatPercentage: (json['bodyFatPercentage'] as num).toDouble(),
      muscleMass: (json['muscleMass'] as num).toDouble(),
      visceralFatLevel: (json['visceralFatLevel'] as num).toDouble(),
      bmr: (json['bmr'] as num).toDouble(),
      bodyWaterPercentage: (json['bodyWaterPercentage'] as num).toDouble(),
      proteinPercentage: (json['proteinPercentage'] as num).toDouble(),
      mineralPercentage: (json['mineralPercentage'] as num).toDouble(),
      bmi: (json['bmi'] as num).toDouble(),
      notes: json['notes'] as String?,
      isFromInBodyScan: json['isFromInBodyScan'] as bool? ?? false,
      inBodyImagePath: json['inBodyImagePath'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$BodyCompositionImplToJson(
        _$BodyCompositionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'measurementDate': instance.measurementDate.toIso8601String(),
      'weight': instance.weight,
      'height': instance.height,
      'bodyFatPercentage': instance.bodyFatPercentage,
      'muscleMass': instance.muscleMass,
      'visceralFatLevel': instance.visceralFatLevel,
      'bmr': instance.bmr,
      'bodyWaterPercentage': instance.bodyWaterPercentage,
      'proteinPercentage': instance.proteinPercentage,
      'mineralPercentage': instance.mineralPercentage,
      'bmi': instance.bmi,
      'notes': instance.notes,
      'isFromInBodyScan': instance.isFromInBodyScan,
      'inBodyImagePath': instance.inBodyImagePath,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_$BodyCompositionStatsImpl _$$BodyCompositionStatsImplFromJson(
        Map<String, dynamic> json) =>
    _$BodyCompositionStatsImpl(
      measurements: (json['measurements'] as List<dynamic>)
          .map((e) => BodyComposition.fromJson(e as Map<String, dynamic>))
          .toList(),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      averageWeight: (json['averageWeight'] as num).toDouble(),
      averageBodyFat: (json['averageBodyFat'] as num).toDouble(),
      averageMuscleMass: (json['averageMuscleMass'] as num).toDouble(),
      weightChange: (json['weightChange'] as num).toDouble(),
      bodyFatChange: (json['bodyFatChange'] as num).toDouble(),
      muscleMassChange: (json['muscleMassChange'] as num).toDouble(),
      latestMeasurement: json['latestMeasurement'] == null
          ? null
          : BodyComposition.fromJson(
              json['latestMeasurement'] as Map<String, dynamic>),
      firstMeasurement: json['firstMeasurement'] == null
          ? null
          : BodyComposition.fromJson(
              json['firstMeasurement'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$BodyCompositionStatsImplToJson(
        _$BodyCompositionStatsImpl instance) =>
    <String, dynamic>{
      'measurements': instance.measurements,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'averageWeight': instance.averageWeight,
      'averageBodyFat': instance.averageBodyFat,
      'averageMuscleMass': instance.averageMuscleMass,
      'weightChange': instance.weightChange,
      'bodyFatChange': instance.bodyFatChange,
      'muscleMassChange': instance.muscleMassChange,
      'latestMeasurement': instance.latestMeasurement,
      'firstMeasurement': instance.firstMeasurement,
    };

_$BodyMetricsImpl _$$BodyMetricsImplFromJson(Map<String, dynamic> json) =>
    _$BodyMetricsImpl(
      id: json['id'] as String,
      recordDate: DateTime.parse(json['recordDate'] as String),
      weight: (json['weight'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      bodyFatPercentage: (json['bodyFatPercentage'] as num?)?.toDouble(),
      muscleMass: (json['muscleMass'] as num?)?.toDouble(),
      waistSize: (json['waistSize'] as num?)?.toDouble(),
      chestSize: (json['chestSize'] as num?)?.toDouble(),
      armSize: (json['armSize'] as num?)?.toDouble(),
      thighSize: (json['thighSize'] as num?)?.toDouble(),
      notes: json['notes'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$BodyMetricsImplToJson(_$BodyMetricsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'recordDate': instance.recordDate.toIso8601String(),
      'weight': instance.weight,
      'height': instance.height,
      'bodyFatPercentage': instance.bodyFatPercentage,
      'muscleMass': instance.muscleMass,
      'waistSize': instance.waistSize,
      'chestSize': instance.chestSize,
      'armSize': instance.armSize,
      'thighSize': instance.thighSize,
      'notes': instance.notes,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_$UserBodyProfileImpl _$$UserBodyProfileImplFromJson(
        Map<String, dynamic> json) =>
    _$UserBodyProfileImpl(
      userId: json['userId'] as String,
      name: json['name'] as String,
      age: (json['age'] as num).toInt(),
      gender: json['gender'] as String,
      height: (json['height'] as num).toDouble(),
      currentWeight: (json['currentWeight'] as num).toDouble(),
      targetWeight: (json['targetWeight'] as num).toDouble(),
      fitnessLevel: $enumDecode(_$FitnessLevelEnumMap, json['fitnessLevel']),
      medicalConditions: json['medicalConditions'] as String?,
      allergies: (json['allergies'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      fitnessGoals: (json['fitnessGoals'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$UserBodyProfileImplToJson(
        _$UserBodyProfileImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'age': instance.age,
      'gender': instance.gender,
      'height': instance.height,
      'currentWeight': instance.currentWeight,
      'targetWeight': instance.targetWeight,
      'fitnessLevel': _$FitnessLevelEnumMap[instance.fitnessLevel]!,
      'medicalConditions': instance.medicalConditions,
      'allergies': instance.allergies,
      'fitnessGoals': instance.fitnessGoals,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$FitnessLevelEnumMap = {
  FitnessLevel.beginner: 'beginner',
  FitnessLevel.intermediate: 'intermediate',
  FitnessLevel.advanced: 'advanced',
};

_$InBodyResultImpl _$$InBodyResultImplFromJson(Map<String, dynamic> json) =>
    _$InBodyResultImpl(
      id: json['id'] as String,
      scanDate: DateTime.parse(json['scanDate'] as String),
      weight: (json['weight'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      bodyFatMass: (json['bodyFatMass'] as num).toDouble(),
      leanBodyMass: (json['leanBodyMass'] as num).toDouble(),
      totalBodyWater: (json['totalBodyWater'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
      mineral: (json['mineral'] as num).toDouble(),
      skeletalMuscleMass: (json['skeletalMuscleMass'] as num).toDouble(),
      bodyFatPercentage: (json['bodyFatPercentage'] as num).toDouble(),
      pbf: (json['pbf'] as num).toDouble(),
      vfl: (json['vfl'] as num).toDouble(),
      bmr: (json['bmr'] as num).toDouble(),
      wholeBodyPhaseAngle: (json['wholeBodyPhaseAngle'] as num).toDouble(),
      segmentalLeanMass:
          (json['segmentalLeanMass'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      segmentalFatMass: (json['segmentalFatMass'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      imagePath: json['imagePath'] as String?,
      notes: json['notes'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$InBodyResultImplToJson(_$InBodyResultImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'scanDate': instance.scanDate.toIso8601String(),
      'weight': instance.weight,
      'height': instance.height,
      'bodyFatMass': instance.bodyFatMass,
      'leanBodyMass': instance.leanBodyMass,
      'totalBodyWater': instance.totalBodyWater,
      'protein': instance.protein,
      'mineral': instance.mineral,
      'skeletalMuscleMass': instance.skeletalMuscleMass,
      'bodyFatPercentage': instance.bodyFatPercentage,
      'pbf': instance.pbf,
      'vfl': instance.vfl,
      'bmr': instance.bmr,
      'wholeBodyPhaseAngle': instance.wholeBodyPhaseAngle,
      'segmentalLeanMass': instance.segmentalLeanMass,
      'segmentalFatMass': instance.segmentalFatMass,
      'imagePath': instance.imagePath,
      'notes': instance.notes,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_$BodyCompositionReportImpl _$$BodyCompositionReportImplFromJson(
        Map<String, dynamic> json) =>
    _$BodyCompositionReportImpl(
      currentMeasurement: BodyComposition.fromJson(
          json['currentMeasurement'] as Map<String, dynamic>),
      previousMeasurement: json['previousMeasurement'] == null
          ? null
          : BodyComposition.fromJson(
              json['previousMeasurement'] as Map<String, dynamic>),
      bodyType: $enumDecode(_$BodyTypeEnumMap, json['bodyType']),
      idealWeight: (json['idealWeight'] as num).toDouble(),
      weightToLose: (json['weightToLose'] as num).toDouble(),
      weightToGain: (json['weightToGain'] as num).toDouble(),
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      metrics: Map<String, String>.from(json['metrics'] as Map),
      generatedAt: DateTime.parse(json['generatedAt'] as String),
    );

Map<String, dynamic> _$$BodyCompositionReportImplToJson(
        _$BodyCompositionReportImpl instance) =>
    <String, dynamic>{
      'currentMeasurement': instance.currentMeasurement,
      'previousMeasurement': instance.previousMeasurement,
      'bodyType': _$BodyTypeEnumMap[instance.bodyType]!,
      'idealWeight': instance.idealWeight,
      'weightToLose': instance.weightToLose,
      'weightToGain': instance.weightToGain,
      'recommendations': instance.recommendations,
      'metrics': instance.metrics,
      'generatedAt': instance.generatedAt.toIso8601String(),
    };

const _$BodyTypeEnumMap = {
  BodyType.underweight: 'underweight',
  BodyType.normal: 'normal',
  BodyType.overweight: 'overweight',
  BodyType.obese: 'obese',
};
