// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sleep_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SleepSession _$SleepSessionFromJson(Map<String, dynamic> json) {
  return _SleepSession.fromJson(json);
}

/// @nodoc
mixin _$SleepSession {
  String get id => throw _privateConstructorUsedError;
  DateTime get bedTime => throw _privateConstructorUsedError;
  DateTime get wakeTime => throw _privateConstructorUsedError;
  Duration get sleepDuration => throw _privateConstructorUsedError;
  SleepQuality get quality => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  bool get isManualEntry => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this SleepSession to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SleepSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SleepSessionCopyWith<SleepSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SleepSessionCopyWith<$Res> {
  factory $SleepSessionCopyWith(
          SleepSession value, $Res Function(SleepSession) then) =
      _$SleepSessionCopyWithImpl<$Res, SleepSession>;
  @useResult
  $Res call(
      {String id,
      DateTime bedTime,
      DateTime wakeTime,
      Duration sleepDuration,
      SleepQuality quality,
      String? notes,
      bool isManualEntry,
      DateTime? createdAt});
}

/// @nodoc
class _$SleepSessionCopyWithImpl<$Res, $Val extends SleepSession>
    implements $SleepSessionCopyWith<$Res> {
  _$SleepSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SleepSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bedTime = null,
    Object? wakeTime = null,
    Object? sleepDuration = null,
    Object? quality = null,
    Object? notes = freezed,
    Object? isManualEntry = null,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      bedTime: null == bedTime
          ? _value.bedTime
          : bedTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      wakeTime: null == wakeTime
          ? _value.wakeTime
          : wakeTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sleepDuration: null == sleepDuration
          ? _value.sleepDuration
          : sleepDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      quality: null == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as SleepQuality,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      isManualEntry: null == isManualEntry
          ? _value.isManualEntry
          : isManualEntry // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SleepSessionImplCopyWith<$Res>
    implements $SleepSessionCopyWith<$Res> {
  factory _$$SleepSessionImplCopyWith(
          _$SleepSessionImpl value, $Res Function(_$SleepSessionImpl) then) =
      __$$SleepSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime bedTime,
      DateTime wakeTime,
      Duration sleepDuration,
      SleepQuality quality,
      String? notes,
      bool isManualEntry,
      DateTime? createdAt});
}

/// @nodoc
class __$$SleepSessionImplCopyWithImpl<$Res>
    extends _$SleepSessionCopyWithImpl<$Res, _$SleepSessionImpl>
    implements _$$SleepSessionImplCopyWith<$Res> {
  __$$SleepSessionImplCopyWithImpl(
      _$SleepSessionImpl _value, $Res Function(_$SleepSessionImpl) _then)
      : super(_value, _then);

  /// Create a copy of SleepSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bedTime = null,
    Object? wakeTime = null,
    Object? sleepDuration = null,
    Object? quality = null,
    Object? notes = freezed,
    Object? isManualEntry = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$SleepSessionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      bedTime: null == bedTime
          ? _value.bedTime
          : bedTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      wakeTime: null == wakeTime
          ? _value.wakeTime
          : wakeTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sleepDuration: null == sleepDuration
          ? _value.sleepDuration
          : sleepDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      quality: null == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as SleepQuality,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      isManualEntry: null == isManualEntry
          ? _value.isManualEntry
          : isManualEntry // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SleepSessionImpl implements _SleepSession {
  const _$SleepSessionImpl(
      {required this.id,
      required this.bedTime,
      required this.wakeTime,
      required this.sleepDuration,
      required this.quality,
      this.notes,
      this.isManualEntry = false,
      this.createdAt});

  factory _$SleepSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SleepSessionImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime bedTime;
  @override
  final DateTime wakeTime;
  @override
  final Duration sleepDuration;
  @override
  final SleepQuality quality;
  @override
  final String? notes;
  @override
  @JsonKey()
  final bool isManualEntry;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'SleepSession(id: $id, bedTime: $bedTime, wakeTime: $wakeTime, sleepDuration: $sleepDuration, quality: $quality, notes: $notes, isManualEntry: $isManualEntry, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SleepSessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.bedTime, bedTime) || other.bedTime == bedTime) &&
            (identical(other.wakeTime, wakeTime) ||
                other.wakeTime == wakeTime) &&
            (identical(other.sleepDuration, sleepDuration) ||
                other.sleepDuration == sleepDuration) &&
            (identical(other.quality, quality) || other.quality == quality) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.isManualEntry, isManualEntry) ||
                other.isManualEntry == isManualEntry) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, bedTime, wakeTime,
      sleepDuration, quality, notes, isManualEntry, createdAt);

  /// Create a copy of SleepSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SleepSessionImplCopyWith<_$SleepSessionImpl> get copyWith =>
      __$$SleepSessionImplCopyWithImpl<_$SleepSessionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SleepSessionImplToJson(
      this,
    );
  }
}

abstract class _SleepSession implements SleepSession {
  const factory _SleepSession(
      {required final String id,
      required final DateTime bedTime,
      required final DateTime wakeTime,
      required final Duration sleepDuration,
      required final SleepQuality quality,
      final String? notes,
      final bool isManualEntry,
      final DateTime? createdAt}) = _$SleepSessionImpl;

  factory _SleepSession.fromJson(Map<String, dynamic> json) =
      _$SleepSessionImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get bedTime;
  @override
  DateTime get wakeTime;
  @override
  Duration get sleepDuration;
  @override
  SleepQuality get quality;
  @override
  String? get notes;
  @override
  bool get isManualEntry;
  @override
  DateTime? get createdAt;

  /// Create a copy of SleepSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SleepSessionImplCopyWith<_$SleepSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SleepStats _$SleepStatsFromJson(Map<String, dynamic> json) {
  return _SleepStats.fromJson(json);
}

/// @nodoc
mixin _$SleepStats {
  Duration get averageSleepDuration => throw _privateConstructorUsedError;
  Duration get totalSleepTime => throw _privateConstructorUsedError;
  int get totalSessions => throw _privateConstructorUsedError;
  double get averageQualityScore => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  List<SleepSession> get sessions => throw _privateConstructorUsedError;

  /// Serializes this SleepStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SleepStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SleepStatsCopyWith<SleepStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SleepStatsCopyWith<$Res> {
  factory $SleepStatsCopyWith(
          SleepStats value, $Res Function(SleepStats) then) =
      _$SleepStatsCopyWithImpl<$Res, SleepStats>;
  @useResult
  $Res call(
      {Duration averageSleepDuration,
      Duration totalSleepTime,
      int totalSessions,
      double averageQualityScore,
      DateTime startDate,
      DateTime endDate,
      List<SleepSession> sessions});
}

/// @nodoc
class _$SleepStatsCopyWithImpl<$Res, $Val extends SleepStats>
    implements $SleepStatsCopyWith<$Res> {
  _$SleepStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SleepStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? averageSleepDuration = null,
    Object? totalSleepTime = null,
    Object? totalSessions = null,
    Object? averageQualityScore = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? sessions = null,
  }) {
    return _then(_value.copyWith(
      averageSleepDuration: null == averageSleepDuration
          ? _value.averageSleepDuration
          : averageSleepDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      totalSleepTime: null == totalSleepTime
          ? _value.totalSleepTime
          : totalSleepTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      totalSessions: null == totalSessions
          ? _value.totalSessions
          : totalSessions // ignore: cast_nullable_to_non_nullable
              as int,
      averageQualityScore: null == averageQualityScore
          ? _value.averageQualityScore
          : averageQualityScore // ignore: cast_nullable_to_non_nullable
              as double,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sessions: null == sessions
          ? _value.sessions
          : sessions // ignore: cast_nullable_to_non_nullable
              as List<SleepSession>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SleepStatsImplCopyWith<$Res>
    implements $SleepStatsCopyWith<$Res> {
  factory _$$SleepStatsImplCopyWith(
          _$SleepStatsImpl value, $Res Function(_$SleepStatsImpl) then) =
      __$$SleepStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Duration averageSleepDuration,
      Duration totalSleepTime,
      int totalSessions,
      double averageQualityScore,
      DateTime startDate,
      DateTime endDate,
      List<SleepSession> sessions});
}

/// @nodoc
class __$$SleepStatsImplCopyWithImpl<$Res>
    extends _$SleepStatsCopyWithImpl<$Res, _$SleepStatsImpl>
    implements _$$SleepStatsImplCopyWith<$Res> {
  __$$SleepStatsImplCopyWithImpl(
      _$SleepStatsImpl _value, $Res Function(_$SleepStatsImpl) _then)
      : super(_value, _then);

  /// Create a copy of SleepStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? averageSleepDuration = null,
    Object? totalSleepTime = null,
    Object? totalSessions = null,
    Object? averageQualityScore = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? sessions = null,
  }) {
    return _then(_$SleepStatsImpl(
      averageSleepDuration: null == averageSleepDuration
          ? _value.averageSleepDuration
          : averageSleepDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      totalSleepTime: null == totalSleepTime
          ? _value.totalSleepTime
          : totalSleepTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      totalSessions: null == totalSessions
          ? _value.totalSessions
          : totalSessions // ignore: cast_nullable_to_non_nullable
              as int,
      averageQualityScore: null == averageQualityScore
          ? _value.averageQualityScore
          : averageQualityScore // ignore: cast_nullable_to_non_nullable
              as double,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sessions: null == sessions
          ? _value._sessions
          : sessions // ignore: cast_nullable_to_non_nullable
              as List<SleepSession>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SleepStatsImpl implements _SleepStats {
  const _$SleepStatsImpl(
      {required this.averageSleepDuration,
      required this.totalSleepTime,
      required this.totalSessions,
      required this.averageQualityScore,
      required this.startDate,
      required this.endDate,
      required final List<SleepSession> sessions})
      : _sessions = sessions;

  factory _$SleepStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SleepStatsImplFromJson(json);

  @override
  final Duration averageSleepDuration;
  @override
  final Duration totalSleepTime;
  @override
  final int totalSessions;
  @override
  final double averageQualityScore;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  final List<SleepSession> _sessions;
  @override
  List<SleepSession> get sessions {
    if (_sessions is EqualUnmodifiableListView) return _sessions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sessions);
  }

  @override
  String toString() {
    return 'SleepStats(averageSleepDuration: $averageSleepDuration, totalSleepTime: $totalSleepTime, totalSessions: $totalSessions, averageQualityScore: $averageQualityScore, startDate: $startDate, endDate: $endDate, sessions: $sessions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SleepStatsImpl &&
            (identical(other.averageSleepDuration, averageSleepDuration) ||
                other.averageSleepDuration == averageSleepDuration) &&
            (identical(other.totalSleepTime, totalSleepTime) ||
                other.totalSleepTime == totalSleepTime) &&
            (identical(other.totalSessions, totalSessions) ||
                other.totalSessions == totalSessions) &&
            (identical(other.averageQualityScore, averageQualityScore) ||
                other.averageQualityScore == averageQualityScore) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            const DeepCollectionEquality().equals(other._sessions, _sessions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      averageSleepDuration,
      totalSleepTime,
      totalSessions,
      averageQualityScore,
      startDate,
      endDate,
      const DeepCollectionEquality().hash(_sessions));

  /// Create a copy of SleepStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SleepStatsImplCopyWith<_$SleepStatsImpl> get copyWith =>
      __$$SleepStatsImplCopyWithImpl<_$SleepStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SleepStatsImplToJson(
      this,
    );
  }
}

abstract class _SleepStats implements SleepStats {
  const factory _SleepStats(
      {required final Duration averageSleepDuration,
      required final Duration totalSleepTime,
      required final int totalSessions,
      required final double averageQualityScore,
      required final DateTime startDate,
      required final DateTime endDate,
      required final List<SleepSession> sessions}) = _$SleepStatsImpl;

  factory _SleepStats.fromJson(Map<String, dynamic> json) =
      _$SleepStatsImpl.fromJson;

  @override
  Duration get averageSleepDuration;
  @override
  Duration get totalSleepTime;
  @override
  int get totalSessions;
  @override
  double get averageQualityScore;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  List<SleepSession> get sessions;

  /// Create a copy of SleepStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SleepStatsImplCopyWith<_$SleepStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SleepGoal _$SleepGoalFromJson(Map<String, dynamic> json) {
  return _SleepGoal.fromJson(json);
}

/// @nodoc
mixin _$SleepGoal {
  Duration get targetSleepDuration => throw _privateConstructorUsedError;
  Duration get targetBedTime => throw _privateConstructorUsedError;
  Duration get targetWakeTime => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this SleepGoal to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SleepGoal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SleepGoalCopyWith<SleepGoal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SleepGoalCopyWith<$Res> {
  factory $SleepGoalCopyWith(SleepGoal value, $Res Function(SleepGoal) then) =
      _$SleepGoalCopyWithImpl<$Res, SleepGoal>;
  @useResult
  $Res call(
      {Duration targetSleepDuration,
      Duration targetBedTime,
      Duration targetWakeTime,
      bool isActive,
      DateTime? createdAt});
}

/// @nodoc
class _$SleepGoalCopyWithImpl<$Res, $Val extends SleepGoal>
    implements $SleepGoalCopyWith<$Res> {
  _$SleepGoalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SleepGoal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? targetSleepDuration = null,
    Object? targetBedTime = null,
    Object? targetWakeTime = null,
    Object? isActive = null,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      targetSleepDuration: null == targetSleepDuration
          ? _value.targetSleepDuration
          : targetSleepDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      targetBedTime: null == targetBedTime
          ? _value.targetBedTime
          : targetBedTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      targetWakeTime: null == targetWakeTime
          ? _value.targetWakeTime
          : targetWakeTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SleepGoalImplCopyWith<$Res>
    implements $SleepGoalCopyWith<$Res> {
  factory _$$SleepGoalImplCopyWith(
          _$SleepGoalImpl value, $Res Function(_$SleepGoalImpl) then) =
      __$$SleepGoalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Duration targetSleepDuration,
      Duration targetBedTime,
      Duration targetWakeTime,
      bool isActive,
      DateTime? createdAt});
}

/// @nodoc
class __$$SleepGoalImplCopyWithImpl<$Res>
    extends _$SleepGoalCopyWithImpl<$Res, _$SleepGoalImpl>
    implements _$$SleepGoalImplCopyWith<$Res> {
  __$$SleepGoalImplCopyWithImpl(
      _$SleepGoalImpl _value, $Res Function(_$SleepGoalImpl) _then)
      : super(_value, _then);

  /// Create a copy of SleepGoal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? targetSleepDuration = null,
    Object? targetBedTime = null,
    Object? targetWakeTime = null,
    Object? isActive = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$SleepGoalImpl(
      targetSleepDuration: null == targetSleepDuration
          ? _value.targetSleepDuration
          : targetSleepDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      targetBedTime: null == targetBedTime
          ? _value.targetBedTime
          : targetBedTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      targetWakeTime: null == targetWakeTime
          ? _value.targetWakeTime
          : targetWakeTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SleepGoalImpl implements _SleepGoal {
  const _$SleepGoalImpl(
      {required this.targetSleepDuration,
      required this.targetBedTime,
      required this.targetWakeTime,
      this.isActive = true,
      this.createdAt});

  factory _$SleepGoalImpl.fromJson(Map<String, dynamic> json) =>
      _$$SleepGoalImplFromJson(json);

  @override
  final Duration targetSleepDuration;
  @override
  final Duration targetBedTime;
  @override
  final Duration targetWakeTime;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'SleepGoal(targetSleepDuration: $targetSleepDuration, targetBedTime: $targetBedTime, targetWakeTime: $targetWakeTime, isActive: $isActive, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SleepGoalImpl &&
            (identical(other.targetSleepDuration, targetSleepDuration) ||
                other.targetSleepDuration == targetSleepDuration) &&
            (identical(other.targetBedTime, targetBedTime) ||
                other.targetBedTime == targetBedTime) &&
            (identical(other.targetWakeTime, targetWakeTime) ||
                other.targetWakeTime == targetWakeTime) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, targetSleepDuration,
      targetBedTime, targetWakeTime, isActive, createdAt);

  /// Create a copy of SleepGoal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SleepGoalImplCopyWith<_$SleepGoalImpl> get copyWith =>
      __$$SleepGoalImplCopyWithImpl<_$SleepGoalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SleepGoalImplToJson(
      this,
    );
  }
}

abstract class _SleepGoal implements SleepGoal {
  const factory _SleepGoal(
      {required final Duration targetSleepDuration,
      required final Duration targetBedTime,
      required final Duration targetWakeTime,
      final bool isActive,
      final DateTime? createdAt}) = _$SleepGoalImpl;

  factory _SleepGoal.fromJson(Map<String, dynamic> json) =
      _$SleepGoalImpl.fromJson;

  @override
  Duration get targetSleepDuration;
  @override
  Duration get targetBedTime;
  @override
  Duration get targetWakeTime;
  @override
  bool get isActive;
  @override
  DateTime? get createdAt;

  /// Create a copy of SleepGoal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SleepGoalImplCopyWith<_$SleepGoalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
