// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'step_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StepData _$StepDataFromJson(Map<String, dynamic> json) {
  return _StepData.fromJson(json);
}

/// @nodoc
mixin _$StepData {
  DateTime get date => throw _privateConstructorUsedError;
  int get steps => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;
  int get dailyGoal => throw _privateConstructorUsedError;

  /// Serializes this StepData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StepData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StepDataCopyWith<StepData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StepDataCopyWith<$Res> {
  factory $StepDataCopyWith(StepData value, $Res Function(StepData) then) =
      _$StepDataCopyWithImpl<$Res, StepData>;
  @useResult
  $Res call({DateTime date, int steps, int points, int dailyGoal});
}

/// @nodoc
class _$StepDataCopyWithImpl<$Res, $Val extends StepData>
    implements $StepDataCopyWith<$Res> {
  _$StepDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StepData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? steps = null,
    Object? points = null,
    Object? dailyGoal = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as int,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      dailyGoal: null == dailyGoal
          ? _value.dailyGoal
          : dailyGoal // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StepDataImplCopyWith<$Res>
    implements $StepDataCopyWith<$Res> {
  factory _$$StepDataImplCopyWith(
          _$StepDataImpl value, $Res Function(_$StepDataImpl) then) =
      __$$StepDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime date, int steps, int points, int dailyGoal});
}

/// @nodoc
class __$$StepDataImplCopyWithImpl<$Res>
    extends _$StepDataCopyWithImpl<$Res, _$StepDataImpl>
    implements _$$StepDataImplCopyWith<$Res> {
  __$$StepDataImplCopyWithImpl(
      _$StepDataImpl _value, $Res Function(_$StepDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of StepData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? steps = null,
    Object? points = null,
    Object? dailyGoal = null,
  }) {
    return _then(_$StepDataImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as int,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      dailyGoal: null == dailyGoal
          ? _value.dailyGoal
          : dailyGoal // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StepDataImpl implements _StepData {
  const _$StepDataImpl(
      {required this.date,
      required this.steps,
      required this.points,
      this.dailyGoal = 10000});

  factory _$StepDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$StepDataImplFromJson(json);

  @override
  final DateTime date;
  @override
  final int steps;
  @override
  final int points;
  @override
  @JsonKey()
  final int dailyGoal;

  @override
  String toString() {
    return 'StepData(date: $date, steps: $steps, points: $points, dailyGoal: $dailyGoal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StepDataImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.steps, steps) || other.steps == steps) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.dailyGoal, dailyGoal) ||
                other.dailyGoal == dailyGoal));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, date, steps, points, dailyGoal);

  /// Create a copy of StepData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StepDataImplCopyWith<_$StepDataImpl> get copyWith =>
      __$$StepDataImplCopyWithImpl<_$StepDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StepDataImplToJson(
      this,
    );
  }
}

abstract class _StepData implements StepData {
  const factory _StepData(
      {required final DateTime date,
      required final int steps,
      required final int points,
      final int dailyGoal}) = _$StepDataImpl;

  factory _StepData.fromJson(Map<String, dynamic> json) =
      _$StepDataImpl.fromJson;

  @override
  DateTime get date;
  @override
  int get steps;
  @override
  int get points;
  @override
  int get dailyGoal;

  /// Create a copy of StepData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StepDataImplCopyWith<_$StepDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WeeklyStepSummary _$WeeklyStepSummaryFromJson(Map<String, dynamic> json) {
  return _WeeklyStepSummary.fromJson(json);
}

/// @nodoc
mixin _$WeeklyStepSummary {
  DateTime get weekStart => throw _privateConstructorUsedError;
  int get totalSteps => throw _privateConstructorUsedError;
  int get totalPoints => throw _privateConstructorUsedError;
  List<StepData> get dailySteps => throw _privateConstructorUsedError;
  double get averageSteps => throw _privateConstructorUsedError;
  int get goalAchievedDays => throw _privateConstructorUsedError;

  /// Serializes this WeeklyStepSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WeeklyStepSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WeeklyStepSummaryCopyWith<WeeklyStepSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeeklyStepSummaryCopyWith<$Res> {
  factory $WeeklyStepSummaryCopyWith(
          WeeklyStepSummary value, $Res Function(WeeklyStepSummary) then) =
      _$WeeklyStepSummaryCopyWithImpl<$Res, WeeklyStepSummary>;
  @useResult
  $Res call(
      {DateTime weekStart,
      int totalSteps,
      int totalPoints,
      List<StepData> dailySteps,
      double averageSteps,
      int goalAchievedDays});
}

/// @nodoc
class _$WeeklyStepSummaryCopyWithImpl<$Res, $Val extends WeeklyStepSummary>
    implements $WeeklyStepSummaryCopyWith<$Res> {
  _$WeeklyStepSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WeeklyStepSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weekStart = null,
    Object? totalSteps = null,
    Object? totalPoints = null,
    Object? dailySteps = null,
    Object? averageSteps = null,
    Object? goalAchievedDays = null,
  }) {
    return _then(_value.copyWith(
      weekStart: null == weekStart
          ? _value.weekStart
          : weekStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalSteps: null == totalSteps
          ? _value.totalSteps
          : totalSteps // ignore: cast_nullable_to_non_nullable
              as int,
      totalPoints: null == totalPoints
          ? _value.totalPoints
          : totalPoints // ignore: cast_nullable_to_non_nullable
              as int,
      dailySteps: null == dailySteps
          ? _value.dailySteps
          : dailySteps // ignore: cast_nullable_to_non_nullable
              as List<StepData>,
      averageSteps: null == averageSteps
          ? _value.averageSteps
          : averageSteps // ignore: cast_nullable_to_non_nullable
              as double,
      goalAchievedDays: null == goalAchievedDays
          ? _value.goalAchievedDays
          : goalAchievedDays // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WeeklyStepSummaryImplCopyWith<$Res>
    implements $WeeklyStepSummaryCopyWith<$Res> {
  factory _$$WeeklyStepSummaryImplCopyWith(_$WeeklyStepSummaryImpl value,
          $Res Function(_$WeeklyStepSummaryImpl) then) =
      __$$WeeklyStepSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime weekStart,
      int totalSteps,
      int totalPoints,
      List<StepData> dailySteps,
      double averageSteps,
      int goalAchievedDays});
}

/// @nodoc
class __$$WeeklyStepSummaryImplCopyWithImpl<$Res>
    extends _$WeeklyStepSummaryCopyWithImpl<$Res, _$WeeklyStepSummaryImpl>
    implements _$$WeeklyStepSummaryImplCopyWith<$Res> {
  __$$WeeklyStepSummaryImplCopyWithImpl(_$WeeklyStepSummaryImpl _value,
      $Res Function(_$WeeklyStepSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of WeeklyStepSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weekStart = null,
    Object? totalSteps = null,
    Object? totalPoints = null,
    Object? dailySteps = null,
    Object? averageSteps = null,
    Object? goalAchievedDays = null,
  }) {
    return _then(_$WeeklyStepSummaryImpl(
      weekStart: null == weekStart
          ? _value.weekStart
          : weekStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalSteps: null == totalSteps
          ? _value.totalSteps
          : totalSteps // ignore: cast_nullable_to_non_nullable
              as int,
      totalPoints: null == totalPoints
          ? _value.totalPoints
          : totalPoints // ignore: cast_nullable_to_non_nullable
              as int,
      dailySteps: null == dailySteps
          ? _value._dailySteps
          : dailySteps // ignore: cast_nullable_to_non_nullable
              as List<StepData>,
      averageSteps: null == averageSteps
          ? _value.averageSteps
          : averageSteps // ignore: cast_nullable_to_non_nullable
              as double,
      goalAchievedDays: null == goalAchievedDays
          ? _value.goalAchievedDays
          : goalAchievedDays // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WeeklyStepSummaryImpl implements _WeeklyStepSummary {
  const _$WeeklyStepSummaryImpl(
      {required this.weekStart,
      required this.totalSteps,
      required this.totalPoints,
      required final List<StepData> dailySteps,
      required this.averageSteps,
      required this.goalAchievedDays})
      : _dailySteps = dailySteps;

  factory _$WeeklyStepSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeeklyStepSummaryImplFromJson(json);

  @override
  final DateTime weekStart;
  @override
  final int totalSteps;
  @override
  final int totalPoints;
  final List<StepData> _dailySteps;
  @override
  List<StepData> get dailySteps {
    if (_dailySteps is EqualUnmodifiableListView) return _dailySteps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dailySteps);
  }

  @override
  final double averageSteps;
  @override
  final int goalAchievedDays;

  @override
  String toString() {
    return 'WeeklyStepSummary(weekStart: $weekStart, totalSteps: $totalSteps, totalPoints: $totalPoints, dailySteps: $dailySteps, averageSteps: $averageSteps, goalAchievedDays: $goalAchievedDays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeeklyStepSummaryImpl &&
            (identical(other.weekStart, weekStart) ||
                other.weekStart == weekStart) &&
            (identical(other.totalSteps, totalSteps) ||
                other.totalSteps == totalSteps) &&
            (identical(other.totalPoints, totalPoints) ||
                other.totalPoints == totalPoints) &&
            const DeepCollectionEquality()
                .equals(other._dailySteps, _dailySteps) &&
            (identical(other.averageSteps, averageSteps) ||
                other.averageSteps == averageSteps) &&
            (identical(other.goalAchievedDays, goalAchievedDays) ||
                other.goalAchievedDays == goalAchievedDays));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      weekStart,
      totalSteps,
      totalPoints,
      const DeepCollectionEquality().hash(_dailySteps),
      averageSteps,
      goalAchievedDays);

  /// Create a copy of WeeklyStepSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WeeklyStepSummaryImplCopyWith<_$WeeklyStepSummaryImpl> get copyWith =>
      __$$WeeklyStepSummaryImplCopyWithImpl<_$WeeklyStepSummaryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeeklyStepSummaryImplToJson(
      this,
    );
  }
}

abstract class _WeeklyStepSummary implements WeeklyStepSummary {
  const factory _WeeklyStepSummary(
      {required final DateTime weekStart,
      required final int totalSteps,
      required final int totalPoints,
      required final List<StepData> dailySteps,
      required final double averageSteps,
      required final int goalAchievedDays}) = _$WeeklyStepSummaryImpl;

  factory _WeeklyStepSummary.fromJson(Map<String, dynamic> json) =
      _$WeeklyStepSummaryImpl.fromJson;

  @override
  DateTime get weekStart;
  @override
  int get totalSteps;
  @override
  int get totalPoints;
  @override
  List<StepData> get dailySteps;
  @override
  double get averageSteps;
  @override
  int get goalAchievedDays;

  /// Create a copy of WeeklyStepSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeeklyStepSummaryImplCopyWith<_$WeeklyStepSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
