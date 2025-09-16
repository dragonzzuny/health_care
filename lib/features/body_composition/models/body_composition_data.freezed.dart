// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'body_composition_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BodyComposition _$BodyCompositionFromJson(Map<String, dynamic> json) {
  return _BodyComposition.fromJson(json);
}

/// @nodoc
mixin _$BodyComposition {
  String get id => throw _privateConstructorUsedError;
  DateTime get measurementDate => throw _privateConstructorUsedError;
  double get weight => throw _privateConstructorUsedError; // kg
  double get height => throw _privateConstructorUsedError; // cm
  double get bodyFatPercentage => throw _privateConstructorUsedError; // %
  double get muscleMass => throw _privateConstructorUsedError; // kg
  double get visceralFatLevel => throw _privateConstructorUsedError; // level
  double get bmr => throw _privateConstructorUsedError; // kcal (기초대사율)
  double get bodyWaterPercentage => throw _privateConstructorUsedError; // %
  double get proteinPercentage => throw _privateConstructorUsedError; // %
  double get mineralPercentage => throw _privateConstructorUsedError; // %
  double get bmi => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  bool get isFromInBodyScan => throw _privateConstructorUsedError;
  String? get inBodyImagePath => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this BodyComposition to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BodyComposition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BodyCompositionCopyWith<BodyComposition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BodyCompositionCopyWith<$Res> {
  factory $BodyCompositionCopyWith(
          BodyComposition value, $Res Function(BodyComposition) then) =
      _$BodyCompositionCopyWithImpl<$Res, BodyComposition>;
  @useResult
  $Res call(
      {String id,
      DateTime measurementDate,
      double weight,
      double height,
      double bodyFatPercentage,
      double muscleMass,
      double visceralFatLevel,
      double bmr,
      double bodyWaterPercentage,
      double proteinPercentage,
      double mineralPercentage,
      double bmi,
      String? notes,
      bool isFromInBodyScan,
      String? inBodyImagePath,
      DateTime? createdAt});
}

/// @nodoc
class _$BodyCompositionCopyWithImpl<$Res, $Val extends BodyComposition>
    implements $BodyCompositionCopyWith<$Res> {
  _$BodyCompositionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BodyComposition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? measurementDate = null,
    Object? weight = null,
    Object? height = null,
    Object? bodyFatPercentage = null,
    Object? muscleMass = null,
    Object? visceralFatLevel = null,
    Object? bmr = null,
    Object? bodyWaterPercentage = null,
    Object? proteinPercentage = null,
    Object? mineralPercentage = null,
    Object? bmi = null,
    Object? notes = freezed,
    Object? isFromInBodyScan = null,
    Object? inBodyImagePath = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      measurementDate: null == measurementDate
          ? _value.measurementDate
          : measurementDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
      bodyFatPercentage: null == bodyFatPercentage
          ? _value.bodyFatPercentage
          : bodyFatPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      muscleMass: null == muscleMass
          ? _value.muscleMass
          : muscleMass // ignore: cast_nullable_to_non_nullable
              as double,
      visceralFatLevel: null == visceralFatLevel
          ? _value.visceralFatLevel
          : visceralFatLevel // ignore: cast_nullable_to_non_nullable
              as double,
      bmr: null == bmr
          ? _value.bmr
          : bmr // ignore: cast_nullable_to_non_nullable
              as double,
      bodyWaterPercentage: null == bodyWaterPercentage
          ? _value.bodyWaterPercentage
          : bodyWaterPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      proteinPercentage: null == proteinPercentage
          ? _value.proteinPercentage
          : proteinPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      mineralPercentage: null == mineralPercentage
          ? _value.mineralPercentage
          : mineralPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      bmi: null == bmi
          ? _value.bmi
          : bmi // ignore: cast_nullable_to_non_nullable
              as double,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      isFromInBodyScan: null == isFromInBodyScan
          ? _value.isFromInBodyScan
          : isFromInBodyScan // ignore: cast_nullable_to_non_nullable
              as bool,
      inBodyImagePath: freezed == inBodyImagePath
          ? _value.inBodyImagePath
          : inBodyImagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BodyCompositionImplCopyWith<$Res>
    implements $BodyCompositionCopyWith<$Res> {
  factory _$$BodyCompositionImplCopyWith(_$BodyCompositionImpl value,
          $Res Function(_$BodyCompositionImpl) then) =
      __$$BodyCompositionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime measurementDate,
      double weight,
      double height,
      double bodyFatPercentage,
      double muscleMass,
      double visceralFatLevel,
      double bmr,
      double bodyWaterPercentage,
      double proteinPercentage,
      double mineralPercentage,
      double bmi,
      String? notes,
      bool isFromInBodyScan,
      String? inBodyImagePath,
      DateTime? createdAt});
}

/// @nodoc
class __$$BodyCompositionImplCopyWithImpl<$Res>
    extends _$BodyCompositionCopyWithImpl<$Res, _$BodyCompositionImpl>
    implements _$$BodyCompositionImplCopyWith<$Res> {
  __$$BodyCompositionImplCopyWithImpl(
      _$BodyCompositionImpl _value, $Res Function(_$BodyCompositionImpl) _then)
      : super(_value, _then);

  /// Create a copy of BodyComposition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? measurementDate = null,
    Object? weight = null,
    Object? height = null,
    Object? bodyFatPercentage = null,
    Object? muscleMass = null,
    Object? visceralFatLevel = null,
    Object? bmr = null,
    Object? bodyWaterPercentage = null,
    Object? proteinPercentage = null,
    Object? mineralPercentage = null,
    Object? bmi = null,
    Object? notes = freezed,
    Object? isFromInBodyScan = null,
    Object? inBodyImagePath = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$BodyCompositionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      measurementDate: null == measurementDate
          ? _value.measurementDate
          : measurementDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
      bodyFatPercentage: null == bodyFatPercentage
          ? _value.bodyFatPercentage
          : bodyFatPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      muscleMass: null == muscleMass
          ? _value.muscleMass
          : muscleMass // ignore: cast_nullable_to_non_nullable
              as double,
      visceralFatLevel: null == visceralFatLevel
          ? _value.visceralFatLevel
          : visceralFatLevel // ignore: cast_nullable_to_non_nullable
              as double,
      bmr: null == bmr
          ? _value.bmr
          : bmr // ignore: cast_nullable_to_non_nullable
              as double,
      bodyWaterPercentage: null == bodyWaterPercentage
          ? _value.bodyWaterPercentage
          : bodyWaterPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      proteinPercentage: null == proteinPercentage
          ? _value.proteinPercentage
          : proteinPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      mineralPercentage: null == mineralPercentage
          ? _value.mineralPercentage
          : mineralPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      bmi: null == bmi
          ? _value.bmi
          : bmi // ignore: cast_nullable_to_non_nullable
              as double,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      isFromInBodyScan: null == isFromInBodyScan
          ? _value.isFromInBodyScan
          : isFromInBodyScan // ignore: cast_nullable_to_non_nullable
              as bool,
      inBodyImagePath: freezed == inBodyImagePath
          ? _value.inBodyImagePath
          : inBodyImagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BodyCompositionImpl implements _BodyComposition {
  const _$BodyCompositionImpl(
      {required this.id,
      required this.measurementDate,
      required this.weight,
      required this.height,
      required this.bodyFatPercentage,
      required this.muscleMass,
      required this.visceralFatLevel,
      required this.bmr,
      required this.bodyWaterPercentage,
      required this.proteinPercentage,
      required this.mineralPercentage,
      required this.bmi,
      this.notes,
      this.isFromInBodyScan = false,
      this.inBodyImagePath,
      this.createdAt});

  factory _$BodyCompositionImpl.fromJson(Map<String, dynamic> json) =>
      _$$BodyCompositionImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime measurementDate;
  @override
  final double weight;
// kg
  @override
  final double height;
// cm
  @override
  final double bodyFatPercentage;
// %
  @override
  final double muscleMass;
// kg
  @override
  final double visceralFatLevel;
// level
  @override
  final double bmr;
// kcal (기초대사율)
  @override
  final double bodyWaterPercentage;
// %
  @override
  final double proteinPercentage;
// %
  @override
  final double mineralPercentage;
// %
  @override
  final double bmi;
  @override
  final String? notes;
  @override
  @JsonKey()
  final bool isFromInBodyScan;
  @override
  final String? inBodyImagePath;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'BodyComposition(id: $id, measurementDate: $measurementDate, weight: $weight, height: $height, bodyFatPercentage: $bodyFatPercentage, muscleMass: $muscleMass, visceralFatLevel: $visceralFatLevel, bmr: $bmr, bodyWaterPercentage: $bodyWaterPercentage, proteinPercentage: $proteinPercentage, mineralPercentage: $mineralPercentage, bmi: $bmi, notes: $notes, isFromInBodyScan: $isFromInBodyScan, inBodyImagePath: $inBodyImagePath, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BodyCompositionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.measurementDate, measurementDate) ||
                other.measurementDate == measurementDate) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.bodyFatPercentage, bodyFatPercentage) ||
                other.bodyFatPercentage == bodyFatPercentage) &&
            (identical(other.muscleMass, muscleMass) ||
                other.muscleMass == muscleMass) &&
            (identical(other.visceralFatLevel, visceralFatLevel) ||
                other.visceralFatLevel == visceralFatLevel) &&
            (identical(other.bmr, bmr) || other.bmr == bmr) &&
            (identical(other.bodyWaterPercentage, bodyWaterPercentage) ||
                other.bodyWaterPercentage == bodyWaterPercentage) &&
            (identical(other.proteinPercentage, proteinPercentage) ||
                other.proteinPercentage == proteinPercentage) &&
            (identical(other.mineralPercentage, mineralPercentage) ||
                other.mineralPercentage == mineralPercentage) &&
            (identical(other.bmi, bmi) || other.bmi == bmi) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.isFromInBodyScan, isFromInBodyScan) ||
                other.isFromInBodyScan == isFromInBodyScan) &&
            (identical(other.inBodyImagePath, inBodyImagePath) ||
                other.inBodyImagePath == inBodyImagePath) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      measurementDate,
      weight,
      height,
      bodyFatPercentage,
      muscleMass,
      visceralFatLevel,
      bmr,
      bodyWaterPercentage,
      proteinPercentage,
      mineralPercentage,
      bmi,
      notes,
      isFromInBodyScan,
      inBodyImagePath,
      createdAt);

  /// Create a copy of BodyComposition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BodyCompositionImplCopyWith<_$BodyCompositionImpl> get copyWith =>
      __$$BodyCompositionImplCopyWithImpl<_$BodyCompositionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BodyCompositionImplToJson(
      this,
    );
  }
}

abstract class _BodyComposition implements BodyComposition {
  const factory _BodyComposition(
      {required final String id,
      required final DateTime measurementDate,
      required final double weight,
      required final double height,
      required final double bodyFatPercentage,
      required final double muscleMass,
      required final double visceralFatLevel,
      required final double bmr,
      required final double bodyWaterPercentage,
      required final double proteinPercentage,
      required final double mineralPercentage,
      required final double bmi,
      final String? notes,
      final bool isFromInBodyScan,
      final String? inBodyImagePath,
      final DateTime? createdAt}) = _$BodyCompositionImpl;

  factory _BodyComposition.fromJson(Map<String, dynamic> json) =
      _$BodyCompositionImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get measurementDate;
  @override
  double get weight; // kg
  @override
  double get height; // cm
  @override
  double get bodyFatPercentage; // %
  @override
  double get muscleMass; // kg
  @override
  double get visceralFatLevel; // level
  @override
  double get bmr; // kcal (기초대사율)
  @override
  double get bodyWaterPercentage; // %
  @override
  double get proteinPercentage; // %
  @override
  double get mineralPercentage; // %
  @override
  double get bmi;
  @override
  String? get notes;
  @override
  bool get isFromInBodyScan;
  @override
  String? get inBodyImagePath;
  @override
  DateTime? get createdAt;

  /// Create a copy of BodyComposition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BodyCompositionImplCopyWith<_$BodyCompositionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BodyCompositionStats _$BodyCompositionStatsFromJson(Map<String, dynamic> json) {
  return _BodyCompositionStats.fromJson(json);
}

/// @nodoc
mixin _$BodyCompositionStats {
  List<BodyComposition> get measurements => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  double get averageWeight => throw _privateConstructorUsedError;
  double get averageBodyFat => throw _privateConstructorUsedError;
  double get averageMuscleMass => throw _privateConstructorUsedError;
  double get weightChange => throw _privateConstructorUsedError;
  double get bodyFatChange => throw _privateConstructorUsedError;
  double get muscleMassChange => throw _privateConstructorUsedError;
  BodyComposition? get latestMeasurement => throw _privateConstructorUsedError;
  BodyComposition? get firstMeasurement => throw _privateConstructorUsedError;

  /// Serializes this BodyCompositionStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BodyCompositionStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BodyCompositionStatsCopyWith<BodyCompositionStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BodyCompositionStatsCopyWith<$Res> {
  factory $BodyCompositionStatsCopyWith(BodyCompositionStats value,
          $Res Function(BodyCompositionStats) then) =
      _$BodyCompositionStatsCopyWithImpl<$Res, BodyCompositionStats>;
  @useResult
  $Res call(
      {List<BodyComposition> measurements,
      DateTime startDate,
      DateTime endDate,
      double averageWeight,
      double averageBodyFat,
      double averageMuscleMass,
      double weightChange,
      double bodyFatChange,
      double muscleMassChange,
      BodyComposition? latestMeasurement,
      BodyComposition? firstMeasurement});

  $BodyCompositionCopyWith<$Res>? get latestMeasurement;
  $BodyCompositionCopyWith<$Res>? get firstMeasurement;
}

/// @nodoc
class _$BodyCompositionStatsCopyWithImpl<$Res,
        $Val extends BodyCompositionStats>
    implements $BodyCompositionStatsCopyWith<$Res> {
  _$BodyCompositionStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BodyCompositionStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? measurements = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? averageWeight = null,
    Object? averageBodyFat = null,
    Object? averageMuscleMass = null,
    Object? weightChange = null,
    Object? bodyFatChange = null,
    Object? muscleMassChange = null,
    Object? latestMeasurement = freezed,
    Object? firstMeasurement = freezed,
  }) {
    return _then(_value.copyWith(
      measurements: null == measurements
          ? _value.measurements
          : measurements // ignore: cast_nullable_to_non_nullable
              as List<BodyComposition>,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      averageWeight: null == averageWeight
          ? _value.averageWeight
          : averageWeight // ignore: cast_nullable_to_non_nullable
              as double,
      averageBodyFat: null == averageBodyFat
          ? _value.averageBodyFat
          : averageBodyFat // ignore: cast_nullable_to_non_nullable
              as double,
      averageMuscleMass: null == averageMuscleMass
          ? _value.averageMuscleMass
          : averageMuscleMass // ignore: cast_nullable_to_non_nullable
              as double,
      weightChange: null == weightChange
          ? _value.weightChange
          : weightChange // ignore: cast_nullable_to_non_nullable
              as double,
      bodyFatChange: null == bodyFatChange
          ? _value.bodyFatChange
          : bodyFatChange // ignore: cast_nullable_to_non_nullable
              as double,
      muscleMassChange: null == muscleMassChange
          ? _value.muscleMassChange
          : muscleMassChange // ignore: cast_nullable_to_non_nullable
              as double,
      latestMeasurement: freezed == latestMeasurement
          ? _value.latestMeasurement
          : latestMeasurement // ignore: cast_nullable_to_non_nullable
              as BodyComposition?,
      firstMeasurement: freezed == firstMeasurement
          ? _value.firstMeasurement
          : firstMeasurement // ignore: cast_nullable_to_non_nullable
              as BodyComposition?,
    ) as $Val);
  }

  /// Create a copy of BodyCompositionStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BodyCompositionCopyWith<$Res>? get latestMeasurement {
    if (_value.latestMeasurement == null) {
      return null;
    }

    return $BodyCompositionCopyWith<$Res>(_value.latestMeasurement!, (value) {
      return _then(_value.copyWith(latestMeasurement: value) as $Val);
    });
  }

  /// Create a copy of BodyCompositionStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BodyCompositionCopyWith<$Res>? get firstMeasurement {
    if (_value.firstMeasurement == null) {
      return null;
    }

    return $BodyCompositionCopyWith<$Res>(_value.firstMeasurement!, (value) {
      return _then(_value.copyWith(firstMeasurement: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BodyCompositionStatsImplCopyWith<$Res>
    implements $BodyCompositionStatsCopyWith<$Res> {
  factory _$$BodyCompositionStatsImplCopyWith(_$BodyCompositionStatsImpl value,
          $Res Function(_$BodyCompositionStatsImpl) then) =
      __$$BodyCompositionStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<BodyComposition> measurements,
      DateTime startDate,
      DateTime endDate,
      double averageWeight,
      double averageBodyFat,
      double averageMuscleMass,
      double weightChange,
      double bodyFatChange,
      double muscleMassChange,
      BodyComposition? latestMeasurement,
      BodyComposition? firstMeasurement});

  @override
  $BodyCompositionCopyWith<$Res>? get latestMeasurement;
  @override
  $BodyCompositionCopyWith<$Res>? get firstMeasurement;
}

/// @nodoc
class __$$BodyCompositionStatsImplCopyWithImpl<$Res>
    extends _$BodyCompositionStatsCopyWithImpl<$Res, _$BodyCompositionStatsImpl>
    implements _$$BodyCompositionStatsImplCopyWith<$Res> {
  __$$BodyCompositionStatsImplCopyWithImpl(_$BodyCompositionStatsImpl _value,
      $Res Function(_$BodyCompositionStatsImpl) _then)
      : super(_value, _then);

  /// Create a copy of BodyCompositionStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? measurements = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? averageWeight = null,
    Object? averageBodyFat = null,
    Object? averageMuscleMass = null,
    Object? weightChange = null,
    Object? bodyFatChange = null,
    Object? muscleMassChange = null,
    Object? latestMeasurement = freezed,
    Object? firstMeasurement = freezed,
  }) {
    return _then(_$BodyCompositionStatsImpl(
      measurements: null == measurements
          ? _value._measurements
          : measurements // ignore: cast_nullable_to_non_nullable
              as List<BodyComposition>,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      averageWeight: null == averageWeight
          ? _value.averageWeight
          : averageWeight // ignore: cast_nullable_to_non_nullable
              as double,
      averageBodyFat: null == averageBodyFat
          ? _value.averageBodyFat
          : averageBodyFat // ignore: cast_nullable_to_non_nullable
              as double,
      averageMuscleMass: null == averageMuscleMass
          ? _value.averageMuscleMass
          : averageMuscleMass // ignore: cast_nullable_to_non_nullable
              as double,
      weightChange: null == weightChange
          ? _value.weightChange
          : weightChange // ignore: cast_nullable_to_non_nullable
              as double,
      bodyFatChange: null == bodyFatChange
          ? _value.bodyFatChange
          : bodyFatChange // ignore: cast_nullable_to_non_nullable
              as double,
      muscleMassChange: null == muscleMassChange
          ? _value.muscleMassChange
          : muscleMassChange // ignore: cast_nullable_to_non_nullable
              as double,
      latestMeasurement: freezed == latestMeasurement
          ? _value.latestMeasurement
          : latestMeasurement // ignore: cast_nullable_to_non_nullable
              as BodyComposition?,
      firstMeasurement: freezed == firstMeasurement
          ? _value.firstMeasurement
          : firstMeasurement // ignore: cast_nullable_to_non_nullable
              as BodyComposition?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BodyCompositionStatsImpl implements _BodyCompositionStats {
  const _$BodyCompositionStatsImpl(
      {required final List<BodyComposition> measurements,
      required this.startDate,
      required this.endDate,
      required this.averageWeight,
      required this.averageBodyFat,
      required this.averageMuscleMass,
      required this.weightChange,
      required this.bodyFatChange,
      required this.muscleMassChange,
      required this.latestMeasurement,
      required this.firstMeasurement})
      : _measurements = measurements;

  factory _$BodyCompositionStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$BodyCompositionStatsImplFromJson(json);

  final List<BodyComposition> _measurements;
  @override
  List<BodyComposition> get measurements {
    if (_measurements is EqualUnmodifiableListView) return _measurements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_measurements);
  }

  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final double averageWeight;
  @override
  final double averageBodyFat;
  @override
  final double averageMuscleMass;
  @override
  final double weightChange;
  @override
  final double bodyFatChange;
  @override
  final double muscleMassChange;
  @override
  final BodyComposition? latestMeasurement;
  @override
  final BodyComposition? firstMeasurement;

  @override
  String toString() {
    return 'BodyCompositionStats(measurements: $measurements, startDate: $startDate, endDate: $endDate, averageWeight: $averageWeight, averageBodyFat: $averageBodyFat, averageMuscleMass: $averageMuscleMass, weightChange: $weightChange, bodyFatChange: $bodyFatChange, muscleMassChange: $muscleMassChange, latestMeasurement: $latestMeasurement, firstMeasurement: $firstMeasurement)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BodyCompositionStatsImpl &&
            const DeepCollectionEquality()
                .equals(other._measurements, _measurements) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.averageWeight, averageWeight) ||
                other.averageWeight == averageWeight) &&
            (identical(other.averageBodyFat, averageBodyFat) ||
                other.averageBodyFat == averageBodyFat) &&
            (identical(other.averageMuscleMass, averageMuscleMass) ||
                other.averageMuscleMass == averageMuscleMass) &&
            (identical(other.weightChange, weightChange) ||
                other.weightChange == weightChange) &&
            (identical(other.bodyFatChange, bodyFatChange) ||
                other.bodyFatChange == bodyFatChange) &&
            (identical(other.muscleMassChange, muscleMassChange) ||
                other.muscleMassChange == muscleMassChange) &&
            (identical(other.latestMeasurement, latestMeasurement) ||
                other.latestMeasurement == latestMeasurement) &&
            (identical(other.firstMeasurement, firstMeasurement) ||
                other.firstMeasurement == firstMeasurement));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_measurements),
      startDate,
      endDate,
      averageWeight,
      averageBodyFat,
      averageMuscleMass,
      weightChange,
      bodyFatChange,
      muscleMassChange,
      latestMeasurement,
      firstMeasurement);

  /// Create a copy of BodyCompositionStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BodyCompositionStatsImplCopyWith<_$BodyCompositionStatsImpl>
      get copyWith =>
          __$$BodyCompositionStatsImplCopyWithImpl<_$BodyCompositionStatsImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BodyCompositionStatsImplToJson(
      this,
    );
  }
}

abstract class _BodyCompositionStats implements BodyCompositionStats {
  const factory _BodyCompositionStats(
          {required final List<BodyComposition> measurements,
          required final DateTime startDate,
          required final DateTime endDate,
          required final double averageWeight,
          required final double averageBodyFat,
          required final double averageMuscleMass,
          required final double weightChange,
          required final double bodyFatChange,
          required final double muscleMassChange,
          required final BodyComposition? latestMeasurement,
          required final BodyComposition? firstMeasurement}) =
      _$BodyCompositionStatsImpl;

  factory _BodyCompositionStats.fromJson(Map<String, dynamic> json) =
      _$BodyCompositionStatsImpl.fromJson;

  @override
  List<BodyComposition> get measurements;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  double get averageWeight;
  @override
  double get averageBodyFat;
  @override
  double get averageMuscleMass;
  @override
  double get weightChange;
  @override
  double get bodyFatChange;
  @override
  double get muscleMassChange;
  @override
  BodyComposition? get latestMeasurement;
  @override
  BodyComposition? get firstMeasurement;

  /// Create a copy of BodyCompositionStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BodyCompositionStatsImplCopyWith<_$BodyCompositionStatsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

BodyMetrics _$BodyMetricsFromJson(Map<String, dynamic> json) {
  return _BodyMetrics.fromJson(json);
}

/// @nodoc
mixin _$BodyMetrics {
  String get id => throw _privateConstructorUsedError;
  DateTime get recordDate => throw _privateConstructorUsedError;
  double get weight => throw _privateConstructorUsedError;
  double get height => throw _privateConstructorUsedError;
  double? get bodyFatPercentage => throw _privateConstructorUsedError;
  double? get muscleMass => throw _privateConstructorUsedError;
  double? get waistSize => throw _privateConstructorUsedError;
  double? get chestSize => throw _privateConstructorUsedError;
  double? get armSize => throw _privateConstructorUsedError;
  double? get thighSize => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this BodyMetrics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BodyMetrics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BodyMetricsCopyWith<BodyMetrics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BodyMetricsCopyWith<$Res> {
  factory $BodyMetricsCopyWith(
          BodyMetrics value, $Res Function(BodyMetrics) then) =
      _$BodyMetricsCopyWithImpl<$Res, BodyMetrics>;
  @useResult
  $Res call(
      {String id,
      DateTime recordDate,
      double weight,
      double height,
      double? bodyFatPercentage,
      double? muscleMass,
      double? waistSize,
      double? chestSize,
      double? armSize,
      double? thighSize,
      String? notes,
      DateTime? createdAt});
}

/// @nodoc
class _$BodyMetricsCopyWithImpl<$Res, $Val extends BodyMetrics>
    implements $BodyMetricsCopyWith<$Res> {
  _$BodyMetricsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BodyMetrics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? recordDate = null,
    Object? weight = null,
    Object? height = null,
    Object? bodyFatPercentage = freezed,
    Object? muscleMass = freezed,
    Object? waistSize = freezed,
    Object? chestSize = freezed,
    Object? armSize = freezed,
    Object? thighSize = freezed,
    Object? notes = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      recordDate: null == recordDate
          ? _value.recordDate
          : recordDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
      bodyFatPercentage: freezed == bodyFatPercentage
          ? _value.bodyFatPercentage
          : bodyFatPercentage // ignore: cast_nullable_to_non_nullable
              as double?,
      muscleMass: freezed == muscleMass
          ? _value.muscleMass
          : muscleMass // ignore: cast_nullable_to_non_nullable
              as double?,
      waistSize: freezed == waistSize
          ? _value.waistSize
          : waistSize // ignore: cast_nullable_to_non_nullable
              as double?,
      chestSize: freezed == chestSize
          ? _value.chestSize
          : chestSize // ignore: cast_nullable_to_non_nullable
              as double?,
      armSize: freezed == armSize
          ? _value.armSize
          : armSize // ignore: cast_nullable_to_non_nullable
              as double?,
      thighSize: freezed == thighSize
          ? _value.thighSize
          : thighSize // ignore: cast_nullable_to_non_nullable
              as double?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BodyMetricsImplCopyWith<$Res>
    implements $BodyMetricsCopyWith<$Res> {
  factory _$$BodyMetricsImplCopyWith(
          _$BodyMetricsImpl value, $Res Function(_$BodyMetricsImpl) then) =
      __$$BodyMetricsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime recordDate,
      double weight,
      double height,
      double? bodyFatPercentage,
      double? muscleMass,
      double? waistSize,
      double? chestSize,
      double? armSize,
      double? thighSize,
      String? notes,
      DateTime? createdAt});
}

/// @nodoc
class __$$BodyMetricsImplCopyWithImpl<$Res>
    extends _$BodyMetricsCopyWithImpl<$Res, _$BodyMetricsImpl>
    implements _$$BodyMetricsImplCopyWith<$Res> {
  __$$BodyMetricsImplCopyWithImpl(
      _$BodyMetricsImpl _value, $Res Function(_$BodyMetricsImpl) _then)
      : super(_value, _then);

  /// Create a copy of BodyMetrics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? recordDate = null,
    Object? weight = null,
    Object? height = null,
    Object? bodyFatPercentage = freezed,
    Object? muscleMass = freezed,
    Object? waistSize = freezed,
    Object? chestSize = freezed,
    Object? armSize = freezed,
    Object? thighSize = freezed,
    Object? notes = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$BodyMetricsImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      recordDate: null == recordDate
          ? _value.recordDate
          : recordDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
      bodyFatPercentage: freezed == bodyFatPercentage
          ? _value.bodyFatPercentage
          : bodyFatPercentage // ignore: cast_nullable_to_non_nullable
              as double?,
      muscleMass: freezed == muscleMass
          ? _value.muscleMass
          : muscleMass // ignore: cast_nullable_to_non_nullable
              as double?,
      waistSize: freezed == waistSize
          ? _value.waistSize
          : waistSize // ignore: cast_nullable_to_non_nullable
              as double?,
      chestSize: freezed == chestSize
          ? _value.chestSize
          : chestSize // ignore: cast_nullable_to_non_nullable
              as double?,
      armSize: freezed == armSize
          ? _value.armSize
          : armSize // ignore: cast_nullable_to_non_nullable
              as double?,
      thighSize: freezed == thighSize
          ? _value.thighSize
          : thighSize // ignore: cast_nullable_to_non_nullable
              as double?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BodyMetricsImpl implements _BodyMetrics {
  const _$BodyMetricsImpl(
      {required this.id,
      required this.recordDate,
      required this.weight,
      required this.height,
      this.bodyFatPercentage,
      this.muscleMass,
      this.waistSize,
      this.chestSize,
      this.armSize,
      this.thighSize,
      this.notes,
      this.createdAt});

  factory _$BodyMetricsImpl.fromJson(Map<String, dynamic> json) =>
      _$$BodyMetricsImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime recordDate;
  @override
  final double weight;
  @override
  final double height;
  @override
  final double? bodyFatPercentage;
  @override
  final double? muscleMass;
  @override
  final double? waistSize;
  @override
  final double? chestSize;
  @override
  final double? armSize;
  @override
  final double? thighSize;
  @override
  final String? notes;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'BodyMetrics(id: $id, recordDate: $recordDate, weight: $weight, height: $height, bodyFatPercentage: $bodyFatPercentage, muscleMass: $muscleMass, waistSize: $waistSize, chestSize: $chestSize, armSize: $armSize, thighSize: $thighSize, notes: $notes, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BodyMetricsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.recordDate, recordDate) ||
                other.recordDate == recordDate) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.bodyFatPercentage, bodyFatPercentage) ||
                other.bodyFatPercentage == bodyFatPercentage) &&
            (identical(other.muscleMass, muscleMass) ||
                other.muscleMass == muscleMass) &&
            (identical(other.waistSize, waistSize) ||
                other.waistSize == waistSize) &&
            (identical(other.chestSize, chestSize) ||
                other.chestSize == chestSize) &&
            (identical(other.armSize, armSize) || other.armSize == armSize) &&
            (identical(other.thighSize, thighSize) ||
                other.thighSize == thighSize) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      recordDate,
      weight,
      height,
      bodyFatPercentage,
      muscleMass,
      waistSize,
      chestSize,
      armSize,
      thighSize,
      notes,
      createdAt);

  /// Create a copy of BodyMetrics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BodyMetricsImplCopyWith<_$BodyMetricsImpl> get copyWith =>
      __$$BodyMetricsImplCopyWithImpl<_$BodyMetricsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BodyMetricsImplToJson(
      this,
    );
  }
}

abstract class _BodyMetrics implements BodyMetrics {
  const factory _BodyMetrics(
      {required final String id,
      required final DateTime recordDate,
      required final double weight,
      required final double height,
      final double? bodyFatPercentage,
      final double? muscleMass,
      final double? waistSize,
      final double? chestSize,
      final double? armSize,
      final double? thighSize,
      final String? notes,
      final DateTime? createdAt}) = _$BodyMetricsImpl;

  factory _BodyMetrics.fromJson(Map<String, dynamic> json) =
      _$BodyMetricsImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get recordDate;
  @override
  double get weight;
  @override
  double get height;
  @override
  double? get bodyFatPercentage;
  @override
  double? get muscleMass;
  @override
  double? get waistSize;
  @override
  double? get chestSize;
  @override
  double? get armSize;
  @override
  double? get thighSize;
  @override
  String? get notes;
  @override
  DateTime? get createdAt;

  /// Create a copy of BodyMetrics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BodyMetricsImplCopyWith<_$BodyMetricsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserBodyProfile _$UserBodyProfileFromJson(Map<String, dynamic> json) {
  return _UserBodyProfile.fromJson(json);
}

/// @nodoc
mixin _$UserBodyProfile {
  String get userId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get age => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError; // 'M' or 'F'
  double get height => throw _privateConstructorUsedError;
  double get currentWeight => throw _privateConstructorUsedError;
  double get targetWeight => throw _privateConstructorUsedError;
  FitnessLevel get fitnessLevel => throw _privateConstructorUsedError;
  String? get medicalConditions => throw _privateConstructorUsedError;
  List<String>? get allergies => throw _privateConstructorUsedError;
  List<String>? get fitnessGoals => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this UserBodyProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserBodyProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserBodyProfileCopyWith<UserBodyProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserBodyProfileCopyWith<$Res> {
  factory $UserBodyProfileCopyWith(
          UserBodyProfile value, $Res Function(UserBodyProfile) then) =
      _$UserBodyProfileCopyWithImpl<$Res, UserBodyProfile>;
  @useResult
  $Res call(
      {String userId,
      String name,
      int age,
      String gender,
      double height,
      double currentWeight,
      double targetWeight,
      FitnessLevel fitnessLevel,
      String? medicalConditions,
      List<String>? allergies,
      List<String>? fitnessGoals,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$UserBodyProfileCopyWithImpl<$Res, $Val extends UserBodyProfile>
    implements $UserBodyProfileCopyWith<$Res> {
  _$UserBodyProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserBodyProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? name = null,
    Object? age = null,
    Object? gender = null,
    Object? height = null,
    Object? currentWeight = null,
    Object? targetWeight = null,
    Object? fitnessLevel = null,
    Object? medicalConditions = freezed,
    Object? allergies = freezed,
    Object? fitnessGoals = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
      currentWeight: null == currentWeight
          ? _value.currentWeight
          : currentWeight // ignore: cast_nullable_to_non_nullable
              as double,
      targetWeight: null == targetWeight
          ? _value.targetWeight
          : targetWeight // ignore: cast_nullable_to_non_nullable
              as double,
      fitnessLevel: null == fitnessLevel
          ? _value.fitnessLevel
          : fitnessLevel // ignore: cast_nullable_to_non_nullable
              as FitnessLevel,
      medicalConditions: freezed == medicalConditions
          ? _value.medicalConditions
          : medicalConditions // ignore: cast_nullable_to_non_nullable
              as String?,
      allergies: freezed == allergies
          ? _value.allergies
          : allergies // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      fitnessGoals: freezed == fitnessGoals
          ? _value.fitnessGoals
          : fitnessGoals // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserBodyProfileImplCopyWith<$Res>
    implements $UserBodyProfileCopyWith<$Res> {
  factory _$$UserBodyProfileImplCopyWith(_$UserBodyProfileImpl value,
          $Res Function(_$UserBodyProfileImpl) then) =
      __$$UserBodyProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      String name,
      int age,
      String gender,
      double height,
      double currentWeight,
      double targetWeight,
      FitnessLevel fitnessLevel,
      String? medicalConditions,
      List<String>? allergies,
      List<String>? fitnessGoals,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$UserBodyProfileImplCopyWithImpl<$Res>
    extends _$UserBodyProfileCopyWithImpl<$Res, _$UserBodyProfileImpl>
    implements _$$UserBodyProfileImplCopyWith<$Res> {
  __$$UserBodyProfileImplCopyWithImpl(
      _$UserBodyProfileImpl _value, $Res Function(_$UserBodyProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserBodyProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? name = null,
    Object? age = null,
    Object? gender = null,
    Object? height = null,
    Object? currentWeight = null,
    Object? targetWeight = null,
    Object? fitnessLevel = null,
    Object? medicalConditions = freezed,
    Object? allergies = freezed,
    Object? fitnessGoals = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$UserBodyProfileImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
      currentWeight: null == currentWeight
          ? _value.currentWeight
          : currentWeight // ignore: cast_nullable_to_non_nullable
              as double,
      targetWeight: null == targetWeight
          ? _value.targetWeight
          : targetWeight // ignore: cast_nullable_to_non_nullable
              as double,
      fitnessLevel: null == fitnessLevel
          ? _value.fitnessLevel
          : fitnessLevel // ignore: cast_nullable_to_non_nullable
              as FitnessLevel,
      medicalConditions: freezed == medicalConditions
          ? _value.medicalConditions
          : medicalConditions // ignore: cast_nullable_to_non_nullable
              as String?,
      allergies: freezed == allergies
          ? _value._allergies
          : allergies // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      fitnessGoals: freezed == fitnessGoals
          ? _value._fitnessGoals
          : fitnessGoals // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserBodyProfileImpl implements _UserBodyProfile {
  const _$UserBodyProfileImpl(
      {required this.userId,
      required this.name,
      required this.age,
      required this.gender,
      required this.height,
      required this.currentWeight,
      required this.targetWeight,
      required this.fitnessLevel,
      this.medicalConditions,
      final List<String>? allergies,
      final List<String>? fitnessGoals,
      this.createdAt,
      this.updatedAt})
      : _allergies = allergies,
        _fitnessGoals = fitnessGoals;

  factory _$UserBodyProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserBodyProfileImplFromJson(json);

  @override
  final String userId;
  @override
  final String name;
  @override
  final int age;
  @override
  final String gender;
// 'M' or 'F'
  @override
  final double height;
  @override
  final double currentWeight;
  @override
  final double targetWeight;
  @override
  final FitnessLevel fitnessLevel;
  @override
  final String? medicalConditions;
  final List<String>? _allergies;
  @override
  List<String>? get allergies {
    final value = _allergies;
    if (value == null) return null;
    if (_allergies is EqualUnmodifiableListView) return _allergies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _fitnessGoals;
  @override
  List<String>? get fitnessGoals {
    final value = _fitnessGoals;
    if (value == null) return null;
    if (_fitnessGoals is EqualUnmodifiableListView) return _fitnessGoals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'UserBodyProfile(userId: $userId, name: $name, age: $age, gender: $gender, height: $height, currentWeight: $currentWeight, targetWeight: $targetWeight, fitnessLevel: $fitnessLevel, medicalConditions: $medicalConditions, allergies: $allergies, fitnessGoals: $fitnessGoals, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserBodyProfileImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.currentWeight, currentWeight) ||
                other.currentWeight == currentWeight) &&
            (identical(other.targetWeight, targetWeight) ||
                other.targetWeight == targetWeight) &&
            (identical(other.fitnessLevel, fitnessLevel) ||
                other.fitnessLevel == fitnessLevel) &&
            (identical(other.medicalConditions, medicalConditions) ||
                other.medicalConditions == medicalConditions) &&
            const DeepCollectionEquality()
                .equals(other._allergies, _allergies) &&
            const DeepCollectionEquality()
                .equals(other._fitnessGoals, _fitnessGoals) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      name,
      age,
      gender,
      height,
      currentWeight,
      targetWeight,
      fitnessLevel,
      medicalConditions,
      const DeepCollectionEquality().hash(_allergies),
      const DeepCollectionEquality().hash(_fitnessGoals),
      createdAt,
      updatedAt);

  /// Create a copy of UserBodyProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserBodyProfileImplCopyWith<_$UserBodyProfileImpl> get copyWith =>
      __$$UserBodyProfileImplCopyWithImpl<_$UserBodyProfileImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserBodyProfileImplToJson(
      this,
    );
  }
}

abstract class _UserBodyProfile implements UserBodyProfile {
  const factory _UserBodyProfile(
      {required final String userId,
      required final String name,
      required final int age,
      required final String gender,
      required final double height,
      required final double currentWeight,
      required final double targetWeight,
      required final FitnessLevel fitnessLevel,
      final String? medicalConditions,
      final List<String>? allergies,
      final List<String>? fitnessGoals,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$UserBodyProfileImpl;

  factory _UserBodyProfile.fromJson(Map<String, dynamic> json) =
      _$UserBodyProfileImpl.fromJson;

  @override
  String get userId;
  @override
  String get name;
  @override
  int get age;
  @override
  String get gender; // 'M' or 'F'
  @override
  double get height;
  @override
  double get currentWeight;
  @override
  double get targetWeight;
  @override
  FitnessLevel get fitnessLevel;
  @override
  String? get medicalConditions;
  @override
  List<String>? get allergies;
  @override
  List<String>? get fitnessGoals;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of UserBodyProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserBodyProfileImplCopyWith<_$UserBodyProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InBodyResult _$InBodyResultFromJson(Map<String, dynamic> json) {
  return _InBodyResult.fromJson(json);
}

/// @nodoc
mixin _$InBodyResult {
  String get id => throw _privateConstructorUsedError;
  DateTime get scanDate => throw _privateConstructorUsedError;
  double get weight => throw _privateConstructorUsedError;
  double get height => throw _privateConstructorUsedError;
  double get bodyFatMass => throw _privateConstructorUsedError; // 체지방량 (kg)
  double get leanBodyMass => throw _privateConstructorUsedError; // 제지방량 (kg)
  double get totalBodyWater => throw _privateConstructorUsedError; // 체수분 (L)
  double get protein => throw _privateConstructorUsedError; // 단백질 (kg)
  double get mineral => throw _privateConstructorUsedError; // 무기질 (kg)
  double get skeletalMuscleMass =>
      throw _privateConstructorUsedError; // 골격근량 (kg)
  double get bodyFatPercentage => throw _privateConstructorUsedError;
  double get pbf => throw _privateConstructorUsedError; // Percent Body Fat
  double get vfl => throw _privateConstructorUsedError; // 내장지방레벨
  double get bmr => throw _privateConstructorUsedError; // 기초대사율
  double get wholeBodyPhaseAngle => throw _privateConstructorUsedError; // 전신위상각
  Map<String, double> get segmentalLeanMass =>
      throw _privateConstructorUsedError; // 부위별 근육량
  Map<String, double> get segmentalFatMass =>
      throw _privateConstructorUsedError; // 부위별 지방량
  String? get imagePath => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this InBodyResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InBodyResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InBodyResultCopyWith<InBodyResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InBodyResultCopyWith<$Res> {
  factory $InBodyResultCopyWith(
          InBodyResult value, $Res Function(InBodyResult) then) =
      _$InBodyResultCopyWithImpl<$Res, InBodyResult>;
  @useResult
  $Res call(
      {String id,
      DateTime scanDate,
      double weight,
      double height,
      double bodyFatMass,
      double leanBodyMass,
      double totalBodyWater,
      double protein,
      double mineral,
      double skeletalMuscleMass,
      double bodyFatPercentage,
      double pbf,
      double vfl,
      double bmr,
      double wholeBodyPhaseAngle,
      Map<String, double> segmentalLeanMass,
      Map<String, double> segmentalFatMass,
      String? imagePath,
      String? notes,
      DateTime? createdAt});
}

/// @nodoc
class _$InBodyResultCopyWithImpl<$Res, $Val extends InBodyResult>
    implements $InBodyResultCopyWith<$Res> {
  _$InBodyResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InBodyResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? scanDate = null,
    Object? weight = null,
    Object? height = null,
    Object? bodyFatMass = null,
    Object? leanBodyMass = null,
    Object? totalBodyWater = null,
    Object? protein = null,
    Object? mineral = null,
    Object? skeletalMuscleMass = null,
    Object? bodyFatPercentage = null,
    Object? pbf = null,
    Object? vfl = null,
    Object? bmr = null,
    Object? wholeBodyPhaseAngle = null,
    Object? segmentalLeanMass = null,
    Object? segmentalFatMass = null,
    Object? imagePath = freezed,
    Object? notes = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      scanDate: null == scanDate
          ? _value.scanDate
          : scanDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
      bodyFatMass: null == bodyFatMass
          ? _value.bodyFatMass
          : bodyFatMass // ignore: cast_nullable_to_non_nullable
              as double,
      leanBodyMass: null == leanBodyMass
          ? _value.leanBodyMass
          : leanBodyMass // ignore: cast_nullable_to_non_nullable
              as double,
      totalBodyWater: null == totalBodyWater
          ? _value.totalBodyWater
          : totalBodyWater // ignore: cast_nullable_to_non_nullable
              as double,
      protein: null == protein
          ? _value.protein
          : protein // ignore: cast_nullable_to_non_nullable
              as double,
      mineral: null == mineral
          ? _value.mineral
          : mineral // ignore: cast_nullable_to_non_nullable
              as double,
      skeletalMuscleMass: null == skeletalMuscleMass
          ? _value.skeletalMuscleMass
          : skeletalMuscleMass // ignore: cast_nullable_to_non_nullable
              as double,
      bodyFatPercentage: null == bodyFatPercentage
          ? _value.bodyFatPercentage
          : bodyFatPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      pbf: null == pbf
          ? _value.pbf
          : pbf // ignore: cast_nullable_to_non_nullable
              as double,
      vfl: null == vfl
          ? _value.vfl
          : vfl // ignore: cast_nullable_to_non_nullable
              as double,
      bmr: null == bmr
          ? _value.bmr
          : bmr // ignore: cast_nullable_to_non_nullable
              as double,
      wholeBodyPhaseAngle: null == wholeBodyPhaseAngle
          ? _value.wholeBodyPhaseAngle
          : wholeBodyPhaseAngle // ignore: cast_nullable_to_non_nullable
              as double,
      segmentalLeanMass: null == segmentalLeanMass
          ? _value.segmentalLeanMass
          : segmentalLeanMass // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      segmentalFatMass: null == segmentalFatMass
          ? _value.segmentalFatMass
          : segmentalFatMass // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      imagePath: freezed == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InBodyResultImplCopyWith<$Res>
    implements $InBodyResultCopyWith<$Res> {
  factory _$$InBodyResultImplCopyWith(
          _$InBodyResultImpl value, $Res Function(_$InBodyResultImpl) then) =
      __$$InBodyResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime scanDate,
      double weight,
      double height,
      double bodyFatMass,
      double leanBodyMass,
      double totalBodyWater,
      double protein,
      double mineral,
      double skeletalMuscleMass,
      double bodyFatPercentage,
      double pbf,
      double vfl,
      double bmr,
      double wholeBodyPhaseAngle,
      Map<String, double> segmentalLeanMass,
      Map<String, double> segmentalFatMass,
      String? imagePath,
      String? notes,
      DateTime? createdAt});
}

/// @nodoc
class __$$InBodyResultImplCopyWithImpl<$Res>
    extends _$InBodyResultCopyWithImpl<$Res, _$InBodyResultImpl>
    implements _$$InBodyResultImplCopyWith<$Res> {
  __$$InBodyResultImplCopyWithImpl(
      _$InBodyResultImpl _value, $Res Function(_$InBodyResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of InBodyResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? scanDate = null,
    Object? weight = null,
    Object? height = null,
    Object? bodyFatMass = null,
    Object? leanBodyMass = null,
    Object? totalBodyWater = null,
    Object? protein = null,
    Object? mineral = null,
    Object? skeletalMuscleMass = null,
    Object? bodyFatPercentage = null,
    Object? pbf = null,
    Object? vfl = null,
    Object? bmr = null,
    Object? wholeBodyPhaseAngle = null,
    Object? segmentalLeanMass = null,
    Object? segmentalFatMass = null,
    Object? imagePath = freezed,
    Object? notes = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$InBodyResultImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      scanDate: null == scanDate
          ? _value.scanDate
          : scanDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
      bodyFatMass: null == bodyFatMass
          ? _value.bodyFatMass
          : bodyFatMass // ignore: cast_nullable_to_non_nullable
              as double,
      leanBodyMass: null == leanBodyMass
          ? _value.leanBodyMass
          : leanBodyMass // ignore: cast_nullable_to_non_nullable
              as double,
      totalBodyWater: null == totalBodyWater
          ? _value.totalBodyWater
          : totalBodyWater // ignore: cast_nullable_to_non_nullable
              as double,
      protein: null == protein
          ? _value.protein
          : protein // ignore: cast_nullable_to_non_nullable
              as double,
      mineral: null == mineral
          ? _value.mineral
          : mineral // ignore: cast_nullable_to_non_nullable
              as double,
      skeletalMuscleMass: null == skeletalMuscleMass
          ? _value.skeletalMuscleMass
          : skeletalMuscleMass // ignore: cast_nullable_to_non_nullable
              as double,
      bodyFatPercentage: null == bodyFatPercentage
          ? _value.bodyFatPercentage
          : bodyFatPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      pbf: null == pbf
          ? _value.pbf
          : pbf // ignore: cast_nullable_to_non_nullable
              as double,
      vfl: null == vfl
          ? _value.vfl
          : vfl // ignore: cast_nullable_to_non_nullable
              as double,
      bmr: null == bmr
          ? _value.bmr
          : bmr // ignore: cast_nullable_to_non_nullable
              as double,
      wholeBodyPhaseAngle: null == wholeBodyPhaseAngle
          ? _value.wholeBodyPhaseAngle
          : wholeBodyPhaseAngle // ignore: cast_nullable_to_non_nullable
              as double,
      segmentalLeanMass: null == segmentalLeanMass
          ? _value._segmentalLeanMass
          : segmentalLeanMass // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      segmentalFatMass: null == segmentalFatMass
          ? _value._segmentalFatMass
          : segmentalFatMass // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      imagePath: freezed == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InBodyResultImpl implements _InBodyResult {
  const _$InBodyResultImpl(
      {required this.id,
      required this.scanDate,
      required this.weight,
      required this.height,
      required this.bodyFatMass,
      required this.leanBodyMass,
      required this.totalBodyWater,
      required this.protein,
      required this.mineral,
      required this.skeletalMuscleMass,
      required this.bodyFatPercentage,
      required this.pbf,
      required this.vfl,
      required this.bmr,
      required this.wholeBodyPhaseAngle,
      required final Map<String, double> segmentalLeanMass,
      required final Map<String, double> segmentalFatMass,
      this.imagePath,
      this.notes,
      this.createdAt})
      : _segmentalLeanMass = segmentalLeanMass,
        _segmentalFatMass = segmentalFatMass;

  factory _$InBodyResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$InBodyResultImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime scanDate;
  @override
  final double weight;
  @override
  final double height;
  @override
  final double bodyFatMass;
// 체지방량 (kg)
  @override
  final double leanBodyMass;
// 제지방량 (kg)
  @override
  final double totalBodyWater;
// 체수분 (L)
  @override
  final double protein;
// 단백질 (kg)
  @override
  final double mineral;
// 무기질 (kg)
  @override
  final double skeletalMuscleMass;
// 골격근량 (kg)
  @override
  final double bodyFatPercentage;
  @override
  final double pbf;
// Percent Body Fat
  @override
  final double vfl;
// 내장지방레벨
  @override
  final double bmr;
// 기초대사율
  @override
  final double wholeBodyPhaseAngle;
// 전신위상각
  final Map<String, double> _segmentalLeanMass;
// 전신위상각
  @override
  Map<String, double> get segmentalLeanMass {
    if (_segmentalLeanMass is EqualUnmodifiableMapView)
      return _segmentalLeanMass;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_segmentalLeanMass);
  }

// 부위별 근육량
  final Map<String, double> _segmentalFatMass;
// 부위별 근육량
  @override
  Map<String, double> get segmentalFatMass {
    if (_segmentalFatMass is EqualUnmodifiableMapView) return _segmentalFatMass;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_segmentalFatMass);
  }

// 부위별 지방량
  @override
  final String? imagePath;
  @override
  final String? notes;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'InBodyResult(id: $id, scanDate: $scanDate, weight: $weight, height: $height, bodyFatMass: $bodyFatMass, leanBodyMass: $leanBodyMass, totalBodyWater: $totalBodyWater, protein: $protein, mineral: $mineral, skeletalMuscleMass: $skeletalMuscleMass, bodyFatPercentage: $bodyFatPercentage, pbf: $pbf, vfl: $vfl, bmr: $bmr, wholeBodyPhaseAngle: $wholeBodyPhaseAngle, segmentalLeanMass: $segmentalLeanMass, segmentalFatMass: $segmentalFatMass, imagePath: $imagePath, notes: $notes, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InBodyResultImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.scanDate, scanDate) ||
                other.scanDate == scanDate) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.bodyFatMass, bodyFatMass) ||
                other.bodyFatMass == bodyFatMass) &&
            (identical(other.leanBodyMass, leanBodyMass) ||
                other.leanBodyMass == leanBodyMass) &&
            (identical(other.totalBodyWater, totalBodyWater) ||
                other.totalBodyWater == totalBodyWater) &&
            (identical(other.protein, protein) || other.protein == protein) &&
            (identical(other.mineral, mineral) || other.mineral == mineral) &&
            (identical(other.skeletalMuscleMass, skeletalMuscleMass) ||
                other.skeletalMuscleMass == skeletalMuscleMass) &&
            (identical(other.bodyFatPercentage, bodyFatPercentage) ||
                other.bodyFatPercentage == bodyFatPercentage) &&
            (identical(other.pbf, pbf) || other.pbf == pbf) &&
            (identical(other.vfl, vfl) || other.vfl == vfl) &&
            (identical(other.bmr, bmr) || other.bmr == bmr) &&
            (identical(other.wholeBodyPhaseAngle, wholeBodyPhaseAngle) ||
                other.wholeBodyPhaseAngle == wholeBodyPhaseAngle) &&
            const DeepCollectionEquality()
                .equals(other._segmentalLeanMass, _segmentalLeanMass) &&
            const DeepCollectionEquality()
                .equals(other._segmentalFatMass, _segmentalFatMass) &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        scanDate,
        weight,
        height,
        bodyFatMass,
        leanBodyMass,
        totalBodyWater,
        protein,
        mineral,
        skeletalMuscleMass,
        bodyFatPercentage,
        pbf,
        vfl,
        bmr,
        wholeBodyPhaseAngle,
        const DeepCollectionEquality().hash(_segmentalLeanMass),
        const DeepCollectionEquality().hash(_segmentalFatMass),
        imagePath,
        notes,
        createdAt
      ]);

  /// Create a copy of InBodyResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InBodyResultImplCopyWith<_$InBodyResultImpl> get copyWith =>
      __$$InBodyResultImplCopyWithImpl<_$InBodyResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InBodyResultImplToJson(
      this,
    );
  }
}

abstract class _InBodyResult implements InBodyResult {
  const factory _InBodyResult(
      {required final String id,
      required final DateTime scanDate,
      required final double weight,
      required final double height,
      required final double bodyFatMass,
      required final double leanBodyMass,
      required final double totalBodyWater,
      required final double protein,
      required final double mineral,
      required final double skeletalMuscleMass,
      required final double bodyFatPercentage,
      required final double pbf,
      required final double vfl,
      required final double bmr,
      required final double wholeBodyPhaseAngle,
      required final Map<String, double> segmentalLeanMass,
      required final Map<String, double> segmentalFatMass,
      final String? imagePath,
      final String? notes,
      final DateTime? createdAt}) = _$InBodyResultImpl;

  factory _InBodyResult.fromJson(Map<String, dynamic> json) =
      _$InBodyResultImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get scanDate;
  @override
  double get weight;
  @override
  double get height;
  @override
  double get bodyFatMass; // 체지방량 (kg)
  @override
  double get leanBodyMass; // 제지방량 (kg)
  @override
  double get totalBodyWater; // 체수분 (L)
  @override
  double get protein; // 단백질 (kg)
  @override
  double get mineral; // 무기질 (kg)
  @override
  double get skeletalMuscleMass; // 골격근량 (kg)
  @override
  double get bodyFatPercentage;
  @override
  double get pbf; // Percent Body Fat
  @override
  double get vfl; // 내장지방레벨
  @override
  double get bmr; // 기초대사율
  @override
  double get wholeBodyPhaseAngle; // 전신위상각
  @override
  Map<String, double> get segmentalLeanMass; // 부위별 근육량
  @override
  Map<String, double> get segmentalFatMass; // 부위별 지방량
  @override
  String? get imagePath;
  @override
  String? get notes;
  @override
  DateTime? get createdAt;

  /// Create a copy of InBodyResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InBodyResultImplCopyWith<_$InBodyResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BodyCompositionReport _$BodyCompositionReportFromJson(
    Map<String, dynamic> json) {
  return _BodyCompositionReport.fromJson(json);
}

/// @nodoc
mixin _$BodyCompositionReport {
  BodyComposition get currentMeasurement => throw _privateConstructorUsedError;
  BodyComposition? get previousMeasurement =>
      throw _privateConstructorUsedError;
  BodyType get bodyType => throw _privateConstructorUsedError;
  double get idealWeight => throw _privateConstructorUsedError;
  double get weightToLose => throw _privateConstructorUsedError;
  double get weightToGain => throw _privateConstructorUsedError;
  List<String> get recommendations => throw _privateConstructorUsedError;
  Map<String, String> get metrics => throw _privateConstructorUsedError;
  DateTime get generatedAt => throw _privateConstructorUsedError;

  /// Serializes this BodyCompositionReport to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BodyCompositionReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BodyCompositionReportCopyWith<BodyCompositionReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BodyCompositionReportCopyWith<$Res> {
  factory $BodyCompositionReportCopyWith(BodyCompositionReport value,
          $Res Function(BodyCompositionReport) then) =
      _$BodyCompositionReportCopyWithImpl<$Res, BodyCompositionReport>;
  @useResult
  $Res call(
      {BodyComposition currentMeasurement,
      BodyComposition? previousMeasurement,
      BodyType bodyType,
      double idealWeight,
      double weightToLose,
      double weightToGain,
      List<String> recommendations,
      Map<String, String> metrics,
      DateTime generatedAt});

  $BodyCompositionCopyWith<$Res> get currentMeasurement;
  $BodyCompositionCopyWith<$Res>? get previousMeasurement;
}

/// @nodoc
class _$BodyCompositionReportCopyWithImpl<$Res,
        $Val extends BodyCompositionReport>
    implements $BodyCompositionReportCopyWith<$Res> {
  _$BodyCompositionReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BodyCompositionReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentMeasurement = null,
    Object? previousMeasurement = freezed,
    Object? bodyType = null,
    Object? idealWeight = null,
    Object? weightToLose = null,
    Object? weightToGain = null,
    Object? recommendations = null,
    Object? metrics = null,
    Object? generatedAt = null,
  }) {
    return _then(_value.copyWith(
      currentMeasurement: null == currentMeasurement
          ? _value.currentMeasurement
          : currentMeasurement // ignore: cast_nullable_to_non_nullable
              as BodyComposition,
      previousMeasurement: freezed == previousMeasurement
          ? _value.previousMeasurement
          : previousMeasurement // ignore: cast_nullable_to_non_nullable
              as BodyComposition?,
      bodyType: null == bodyType
          ? _value.bodyType
          : bodyType // ignore: cast_nullable_to_non_nullable
              as BodyType,
      idealWeight: null == idealWeight
          ? _value.idealWeight
          : idealWeight // ignore: cast_nullable_to_non_nullable
              as double,
      weightToLose: null == weightToLose
          ? _value.weightToLose
          : weightToLose // ignore: cast_nullable_to_non_nullable
              as double,
      weightToGain: null == weightToGain
          ? _value.weightToGain
          : weightToGain // ignore: cast_nullable_to_non_nullable
              as double,
      recommendations: null == recommendations
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      metrics: null == metrics
          ? _value.metrics
          : metrics // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  /// Create a copy of BodyCompositionReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BodyCompositionCopyWith<$Res> get currentMeasurement {
    return $BodyCompositionCopyWith<$Res>(_value.currentMeasurement, (value) {
      return _then(_value.copyWith(currentMeasurement: value) as $Val);
    });
  }

  /// Create a copy of BodyCompositionReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BodyCompositionCopyWith<$Res>? get previousMeasurement {
    if (_value.previousMeasurement == null) {
      return null;
    }

    return $BodyCompositionCopyWith<$Res>(_value.previousMeasurement!, (value) {
      return _then(_value.copyWith(previousMeasurement: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BodyCompositionReportImplCopyWith<$Res>
    implements $BodyCompositionReportCopyWith<$Res> {
  factory _$$BodyCompositionReportImplCopyWith(
          _$BodyCompositionReportImpl value,
          $Res Function(_$BodyCompositionReportImpl) then) =
      __$$BodyCompositionReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {BodyComposition currentMeasurement,
      BodyComposition? previousMeasurement,
      BodyType bodyType,
      double idealWeight,
      double weightToLose,
      double weightToGain,
      List<String> recommendations,
      Map<String, String> metrics,
      DateTime generatedAt});

  @override
  $BodyCompositionCopyWith<$Res> get currentMeasurement;
  @override
  $BodyCompositionCopyWith<$Res>? get previousMeasurement;
}

/// @nodoc
class __$$BodyCompositionReportImplCopyWithImpl<$Res>
    extends _$BodyCompositionReportCopyWithImpl<$Res,
        _$BodyCompositionReportImpl>
    implements _$$BodyCompositionReportImplCopyWith<$Res> {
  __$$BodyCompositionReportImplCopyWithImpl(_$BodyCompositionReportImpl _value,
      $Res Function(_$BodyCompositionReportImpl) _then)
      : super(_value, _then);

  /// Create a copy of BodyCompositionReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentMeasurement = null,
    Object? previousMeasurement = freezed,
    Object? bodyType = null,
    Object? idealWeight = null,
    Object? weightToLose = null,
    Object? weightToGain = null,
    Object? recommendations = null,
    Object? metrics = null,
    Object? generatedAt = null,
  }) {
    return _then(_$BodyCompositionReportImpl(
      currentMeasurement: null == currentMeasurement
          ? _value.currentMeasurement
          : currentMeasurement // ignore: cast_nullable_to_non_nullable
              as BodyComposition,
      previousMeasurement: freezed == previousMeasurement
          ? _value.previousMeasurement
          : previousMeasurement // ignore: cast_nullable_to_non_nullable
              as BodyComposition?,
      bodyType: null == bodyType
          ? _value.bodyType
          : bodyType // ignore: cast_nullable_to_non_nullable
              as BodyType,
      idealWeight: null == idealWeight
          ? _value.idealWeight
          : idealWeight // ignore: cast_nullable_to_non_nullable
              as double,
      weightToLose: null == weightToLose
          ? _value.weightToLose
          : weightToLose // ignore: cast_nullable_to_non_nullable
              as double,
      weightToGain: null == weightToGain
          ? _value.weightToGain
          : weightToGain // ignore: cast_nullable_to_non_nullable
              as double,
      recommendations: null == recommendations
          ? _value._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      metrics: null == metrics
          ? _value._metrics
          : metrics // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BodyCompositionReportImpl implements _BodyCompositionReport {
  const _$BodyCompositionReportImpl(
      {required this.currentMeasurement,
      this.previousMeasurement,
      required this.bodyType,
      required this.idealWeight,
      required this.weightToLose,
      required this.weightToGain,
      required final List<String> recommendations,
      required final Map<String, String> metrics,
      required this.generatedAt})
      : _recommendations = recommendations,
        _metrics = metrics;

  factory _$BodyCompositionReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$BodyCompositionReportImplFromJson(json);

  @override
  final BodyComposition currentMeasurement;
  @override
  final BodyComposition? previousMeasurement;
  @override
  final BodyType bodyType;
  @override
  final double idealWeight;
  @override
  final double weightToLose;
  @override
  final double weightToGain;
  final List<String> _recommendations;
  @override
  List<String> get recommendations {
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendations);
  }

  final Map<String, String> _metrics;
  @override
  Map<String, String> get metrics {
    if (_metrics is EqualUnmodifiableMapView) return _metrics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metrics);
  }

  @override
  final DateTime generatedAt;

  @override
  String toString() {
    return 'BodyCompositionReport(currentMeasurement: $currentMeasurement, previousMeasurement: $previousMeasurement, bodyType: $bodyType, idealWeight: $idealWeight, weightToLose: $weightToLose, weightToGain: $weightToGain, recommendations: $recommendations, metrics: $metrics, generatedAt: $generatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BodyCompositionReportImpl &&
            (identical(other.currentMeasurement, currentMeasurement) ||
                other.currentMeasurement == currentMeasurement) &&
            (identical(other.previousMeasurement, previousMeasurement) ||
                other.previousMeasurement == previousMeasurement) &&
            (identical(other.bodyType, bodyType) ||
                other.bodyType == bodyType) &&
            (identical(other.idealWeight, idealWeight) ||
                other.idealWeight == idealWeight) &&
            (identical(other.weightToLose, weightToLose) ||
                other.weightToLose == weightToLose) &&
            (identical(other.weightToGain, weightToGain) ||
                other.weightToGain == weightToGain) &&
            const DeepCollectionEquality()
                .equals(other._recommendations, _recommendations) &&
            const DeepCollectionEquality().equals(other._metrics, _metrics) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentMeasurement,
      previousMeasurement,
      bodyType,
      idealWeight,
      weightToLose,
      weightToGain,
      const DeepCollectionEquality().hash(_recommendations),
      const DeepCollectionEquality().hash(_metrics),
      generatedAt);

  /// Create a copy of BodyCompositionReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BodyCompositionReportImplCopyWith<_$BodyCompositionReportImpl>
      get copyWith => __$$BodyCompositionReportImplCopyWithImpl<
          _$BodyCompositionReportImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BodyCompositionReportImplToJson(
      this,
    );
  }
}

abstract class _BodyCompositionReport implements BodyCompositionReport {
  const factory _BodyCompositionReport(
      {required final BodyComposition currentMeasurement,
      final BodyComposition? previousMeasurement,
      required final BodyType bodyType,
      required final double idealWeight,
      required final double weightToLose,
      required final double weightToGain,
      required final List<String> recommendations,
      required final Map<String, String> metrics,
      required final DateTime generatedAt}) = _$BodyCompositionReportImpl;

  factory _BodyCompositionReport.fromJson(Map<String, dynamic> json) =
      _$BodyCompositionReportImpl.fromJson;

  @override
  BodyComposition get currentMeasurement;
  @override
  BodyComposition? get previousMeasurement;
  @override
  BodyType get bodyType;
  @override
  double get idealWeight;
  @override
  double get weightToLose;
  @override
  double get weightToGain;
  @override
  List<String> get recommendations;
  @override
  Map<String, String> get metrics;
  @override
  DateTime get generatedAt;

  /// Create a copy of BodyCompositionReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BodyCompositionReportImplCopyWith<_$BodyCompositionReportImpl>
      get copyWith => throw _privateConstructorUsedError;
}
