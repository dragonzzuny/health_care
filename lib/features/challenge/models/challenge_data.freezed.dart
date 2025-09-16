// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'challenge_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Challenge _$ChallengeFromJson(Map<String, dynamic> json) {
  return _Challenge.fromJson(json);
}

/// @nodoc
mixin _$Challenge {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  ChallengeType get type => throw _privateConstructorUsedError;
  ChallengeCategory get category => throw _privateConstructorUsedError;
  int get targetValue => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  ChallengeStatus get status => throw _privateConstructorUsedError;
  int get currentProgress => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;
  bool get isCustom => throw _privateConstructorUsedError;
  String? get createdBy => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// Serializes this Challenge to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Challenge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChallengeCopyWith<Challenge> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChallengeCopyWith<$Res> {
  factory $ChallengeCopyWith(Challenge value, $Res Function(Challenge) then) =
      _$ChallengeCopyWithImpl<$Res, Challenge>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      ChallengeType type,
      ChallengeCategory category,
      int targetValue,
      String unit,
      DateTime startDate,
      DateTime endDate,
      ChallengeStatus status,
      int currentProgress,
      int points,
      bool isCustom,
      String? createdBy,
      DateTime? createdAt,
      DateTime? completedAt});
}

/// @nodoc
class _$ChallengeCopyWithImpl<$Res, $Val extends Challenge>
    implements $ChallengeCopyWith<$Res> {
  _$ChallengeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Challenge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? category = null,
    Object? targetValue = null,
    Object? unit = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? status = null,
    Object? currentProgress = null,
    Object? points = null,
    Object? isCustom = null,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ChallengeType,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as ChallengeCategory,
      targetValue: null == targetValue
          ? _value.targetValue
          : targetValue // ignore: cast_nullable_to_non_nullable
              as int,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ChallengeStatus,
      currentProgress: null == currentProgress
          ? _value.currentProgress
          : currentProgress // ignore: cast_nullable_to_non_nullable
              as int,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      isCustom: null == isCustom
          ? _value.isCustom
          : isCustom // ignore: cast_nullable_to_non_nullable
              as bool,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChallengeImplCopyWith<$Res>
    implements $ChallengeCopyWith<$Res> {
  factory _$$ChallengeImplCopyWith(
          _$ChallengeImpl value, $Res Function(_$ChallengeImpl) then) =
      __$$ChallengeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      ChallengeType type,
      ChallengeCategory category,
      int targetValue,
      String unit,
      DateTime startDate,
      DateTime endDate,
      ChallengeStatus status,
      int currentProgress,
      int points,
      bool isCustom,
      String? createdBy,
      DateTime? createdAt,
      DateTime? completedAt});
}

/// @nodoc
class __$$ChallengeImplCopyWithImpl<$Res>
    extends _$ChallengeCopyWithImpl<$Res, _$ChallengeImpl>
    implements _$$ChallengeImplCopyWith<$Res> {
  __$$ChallengeImplCopyWithImpl(
      _$ChallengeImpl _value, $Res Function(_$ChallengeImpl) _then)
      : super(_value, _then);

  /// Create a copy of Challenge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? category = null,
    Object? targetValue = null,
    Object? unit = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? status = null,
    Object? currentProgress = null,
    Object? points = null,
    Object? isCustom = null,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(_$ChallengeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ChallengeType,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as ChallengeCategory,
      targetValue: null == targetValue
          ? _value.targetValue
          : targetValue // ignore: cast_nullable_to_non_nullable
              as int,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ChallengeStatus,
      currentProgress: null == currentProgress
          ? _value.currentProgress
          : currentProgress // ignore: cast_nullable_to_non_nullable
              as int,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      isCustom: null == isCustom
          ? _value.isCustom
          : isCustom // ignore: cast_nullable_to_non_nullable
              as bool,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChallengeImpl implements _Challenge {
  const _$ChallengeImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.type,
      required this.category,
      required this.targetValue,
      required this.unit,
      required this.startDate,
      required this.endDate,
      required this.status,
      this.currentProgress = 0,
      this.points = 0,
      this.isCustom = false,
      this.createdBy,
      this.createdAt,
      this.completedAt});

  factory _$ChallengeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChallengeImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final ChallengeType type;
  @override
  final ChallengeCategory category;
  @override
  final int targetValue;
  @override
  final String unit;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final ChallengeStatus status;
  @override
  @JsonKey()
  final int currentProgress;
  @override
  @JsonKey()
  final int points;
  @override
  @JsonKey()
  final bool isCustom;
  @override
  final String? createdBy;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? completedAt;

  @override
  String toString() {
    return 'Challenge(id: $id, title: $title, description: $description, type: $type, category: $category, targetValue: $targetValue, unit: $unit, startDate: $startDate, endDate: $endDate, status: $status, currentProgress: $currentProgress, points: $points, isCustom: $isCustom, createdBy: $createdBy, createdAt: $createdAt, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChallengeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.targetValue, targetValue) ||
                other.targetValue == targetValue) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.currentProgress, currentProgress) ||
                other.currentProgress == currentProgress) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.isCustom, isCustom) ||
                other.isCustom == isCustom) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      type,
      category,
      targetValue,
      unit,
      startDate,
      endDate,
      status,
      currentProgress,
      points,
      isCustom,
      createdBy,
      createdAt,
      completedAt);

  /// Create a copy of Challenge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChallengeImplCopyWith<_$ChallengeImpl> get copyWith =>
      __$$ChallengeImplCopyWithImpl<_$ChallengeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChallengeImplToJson(
      this,
    );
  }
}

abstract class _Challenge implements Challenge {
  const factory _Challenge(
      {required final String id,
      required final String title,
      required final String description,
      required final ChallengeType type,
      required final ChallengeCategory category,
      required final int targetValue,
      required final String unit,
      required final DateTime startDate,
      required final DateTime endDate,
      required final ChallengeStatus status,
      final int currentProgress,
      final int points,
      final bool isCustom,
      final String? createdBy,
      final DateTime? createdAt,
      final DateTime? completedAt}) = _$ChallengeImpl;

  factory _Challenge.fromJson(Map<String, dynamic> json) =
      _$ChallengeImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  ChallengeType get type;
  @override
  ChallengeCategory get category;
  @override
  int get targetValue;
  @override
  String get unit;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  ChallengeStatus get status;
  @override
  int get currentProgress;
  @override
  int get points;
  @override
  bool get isCustom;
  @override
  String? get createdBy;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get completedAt;

  /// Create a copy of Challenge
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChallengeImplCopyWith<_$ChallengeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChallengeProgress _$ChallengeProgressFromJson(Map<String, dynamic> json) {
  return _ChallengeProgress.fromJson(json);
}

/// @nodoc
mixin _$ChallengeProgress {
  String get challengeId => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  int get progressValue => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime? get recordedAt => throw _privateConstructorUsedError;

  /// Serializes this ChallengeProgress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChallengeProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChallengeProgressCopyWith<ChallengeProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChallengeProgressCopyWith<$Res> {
  factory $ChallengeProgressCopyWith(
          ChallengeProgress value, $Res Function(ChallengeProgress) then) =
      _$ChallengeProgressCopyWithImpl<$Res, ChallengeProgress>;
  @useResult
  $Res call(
      {String challengeId,
      DateTime date,
      int progressValue,
      bool isCompleted,
      String? notes,
      DateTime? recordedAt});
}

/// @nodoc
class _$ChallengeProgressCopyWithImpl<$Res, $Val extends ChallengeProgress>
    implements $ChallengeProgressCopyWith<$Res> {
  _$ChallengeProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChallengeProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? challengeId = null,
    Object? date = null,
    Object? progressValue = null,
    Object? isCompleted = null,
    Object? notes = freezed,
    Object? recordedAt = freezed,
  }) {
    return _then(_value.copyWith(
      challengeId: null == challengeId
          ? _value.challengeId
          : challengeId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      progressValue: null == progressValue
          ? _value.progressValue
          : progressValue // ignore: cast_nullable_to_non_nullable
              as int,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      recordedAt: freezed == recordedAt
          ? _value.recordedAt
          : recordedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChallengeProgressImplCopyWith<$Res>
    implements $ChallengeProgressCopyWith<$Res> {
  factory _$$ChallengeProgressImplCopyWith(_$ChallengeProgressImpl value,
          $Res Function(_$ChallengeProgressImpl) then) =
      __$$ChallengeProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String challengeId,
      DateTime date,
      int progressValue,
      bool isCompleted,
      String? notes,
      DateTime? recordedAt});
}

/// @nodoc
class __$$ChallengeProgressImplCopyWithImpl<$Res>
    extends _$ChallengeProgressCopyWithImpl<$Res, _$ChallengeProgressImpl>
    implements _$$ChallengeProgressImplCopyWith<$Res> {
  __$$ChallengeProgressImplCopyWithImpl(_$ChallengeProgressImpl _value,
      $Res Function(_$ChallengeProgressImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChallengeProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? challengeId = null,
    Object? date = null,
    Object? progressValue = null,
    Object? isCompleted = null,
    Object? notes = freezed,
    Object? recordedAt = freezed,
  }) {
    return _then(_$ChallengeProgressImpl(
      challengeId: null == challengeId
          ? _value.challengeId
          : challengeId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      progressValue: null == progressValue
          ? _value.progressValue
          : progressValue // ignore: cast_nullable_to_non_nullable
              as int,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      recordedAt: freezed == recordedAt
          ? _value.recordedAt
          : recordedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChallengeProgressImpl implements _ChallengeProgress {
  const _$ChallengeProgressImpl(
      {required this.challengeId,
      required this.date,
      required this.progressValue,
      required this.isCompleted,
      this.notes,
      this.recordedAt});

  factory _$ChallengeProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChallengeProgressImplFromJson(json);

  @override
  final String challengeId;
  @override
  final DateTime date;
  @override
  final int progressValue;
  @override
  final bool isCompleted;
  @override
  final String? notes;
  @override
  final DateTime? recordedAt;

  @override
  String toString() {
    return 'ChallengeProgress(challengeId: $challengeId, date: $date, progressValue: $progressValue, isCompleted: $isCompleted, notes: $notes, recordedAt: $recordedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChallengeProgressImpl &&
            (identical(other.challengeId, challengeId) ||
                other.challengeId == challengeId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.progressValue, progressValue) ||
                other.progressValue == progressValue) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.recordedAt, recordedAt) ||
                other.recordedAt == recordedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, challengeId, date, progressValue,
      isCompleted, notes, recordedAt);

  /// Create a copy of ChallengeProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChallengeProgressImplCopyWith<_$ChallengeProgressImpl> get copyWith =>
      __$$ChallengeProgressImplCopyWithImpl<_$ChallengeProgressImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChallengeProgressImplToJson(
      this,
    );
  }
}

abstract class _ChallengeProgress implements ChallengeProgress {
  const factory _ChallengeProgress(
      {required final String challengeId,
      required final DateTime date,
      required final int progressValue,
      required final bool isCompleted,
      final String? notes,
      final DateTime? recordedAt}) = _$ChallengeProgressImpl;

  factory _ChallengeProgress.fromJson(Map<String, dynamic> json) =
      _$ChallengeProgressImpl.fromJson;

  @override
  String get challengeId;
  @override
  DateTime get date;
  @override
  int get progressValue;
  @override
  bool get isCompleted;
  @override
  String? get notes;
  @override
  DateTime? get recordedAt;

  /// Create a copy of ChallengeProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChallengeProgressImplCopyWith<_$ChallengeProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserChallengeStats _$UserChallengeStatsFromJson(Map<String, dynamic> json) {
  return _UserChallengeStats.fromJson(json);
}

/// @nodoc
mixin _$UserChallengeStats {
  int get totalChallenges => throw _privateConstructorUsedError;
  int get completedChallenges => throw _privateConstructorUsedError;
  int get activeChallenges => throw _privateConstructorUsedError;
  int get totalPoints => throw _privateConstructorUsedError;
  double get completionRate => throw _privateConstructorUsedError;
  List<Challenge> get recentCompleted => throw _privateConstructorUsedError;
  List<Challenge> get currentActive => throw _privateConstructorUsedError;
  DateTime? get lastUpdated => throw _privateConstructorUsedError;

  /// Serializes this UserChallengeStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserChallengeStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserChallengeStatsCopyWith<UserChallengeStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserChallengeStatsCopyWith<$Res> {
  factory $UserChallengeStatsCopyWith(
          UserChallengeStats value, $Res Function(UserChallengeStats) then) =
      _$UserChallengeStatsCopyWithImpl<$Res, UserChallengeStats>;
  @useResult
  $Res call(
      {int totalChallenges,
      int completedChallenges,
      int activeChallenges,
      int totalPoints,
      double completionRate,
      List<Challenge> recentCompleted,
      List<Challenge> currentActive,
      DateTime? lastUpdated});
}

/// @nodoc
class _$UserChallengeStatsCopyWithImpl<$Res, $Val extends UserChallengeStats>
    implements $UserChallengeStatsCopyWith<$Res> {
  _$UserChallengeStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserChallengeStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalChallenges = null,
    Object? completedChallenges = null,
    Object? activeChallenges = null,
    Object? totalPoints = null,
    Object? completionRate = null,
    Object? recentCompleted = null,
    Object? currentActive = null,
    Object? lastUpdated = freezed,
  }) {
    return _then(_value.copyWith(
      totalChallenges: null == totalChallenges
          ? _value.totalChallenges
          : totalChallenges // ignore: cast_nullable_to_non_nullable
              as int,
      completedChallenges: null == completedChallenges
          ? _value.completedChallenges
          : completedChallenges // ignore: cast_nullable_to_non_nullable
              as int,
      activeChallenges: null == activeChallenges
          ? _value.activeChallenges
          : activeChallenges // ignore: cast_nullable_to_non_nullable
              as int,
      totalPoints: null == totalPoints
          ? _value.totalPoints
          : totalPoints // ignore: cast_nullable_to_non_nullable
              as int,
      completionRate: null == completionRate
          ? _value.completionRate
          : completionRate // ignore: cast_nullable_to_non_nullable
              as double,
      recentCompleted: null == recentCompleted
          ? _value.recentCompleted
          : recentCompleted // ignore: cast_nullable_to_non_nullable
              as List<Challenge>,
      currentActive: null == currentActive
          ? _value.currentActive
          : currentActive // ignore: cast_nullable_to_non_nullable
              as List<Challenge>,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserChallengeStatsImplCopyWith<$Res>
    implements $UserChallengeStatsCopyWith<$Res> {
  factory _$$UserChallengeStatsImplCopyWith(_$UserChallengeStatsImpl value,
          $Res Function(_$UserChallengeStatsImpl) then) =
      __$$UserChallengeStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalChallenges,
      int completedChallenges,
      int activeChallenges,
      int totalPoints,
      double completionRate,
      List<Challenge> recentCompleted,
      List<Challenge> currentActive,
      DateTime? lastUpdated});
}

/// @nodoc
class __$$UserChallengeStatsImplCopyWithImpl<$Res>
    extends _$UserChallengeStatsCopyWithImpl<$Res, _$UserChallengeStatsImpl>
    implements _$$UserChallengeStatsImplCopyWith<$Res> {
  __$$UserChallengeStatsImplCopyWithImpl(_$UserChallengeStatsImpl _value,
      $Res Function(_$UserChallengeStatsImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserChallengeStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalChallenges = null,
    Object? completedChallenges = null,
    Object? activeChallenges = null,
    Object? totalPoints = null,
    Object? completionRate = null,
    Object? recentCompleted = null,
    Object? currentActive = null,
    Object? lastUpdated = freezed,
  }) {
    return _then(_$UserChallengeStatsImpl(
      totalChallenges: null == totalChallenges
          ? _value.totalChallenges
          : totalChallenges // ignore: cast_nullable_to_non_nullable
              as int,
      completedChallenges: null == completedChallenges
          ? _value.completedChallenges
          : completedChallenges // ignore: cast_nullable_to_non_nullable
              as int,
      activeChallenges: null == activeChallenges
          ? _value.activeChallenges
          : activeChallenges // ignore: cast_nullable_to_non_nullable
              as int,
      totalPoints: null == totalPoints
          ? _value.totalPoints
          : totalPoints // ignore: cast_nullable_to_non_nullable
              as int,
      completionRate: null == completionRate
          ? _value.completionRate
          : completionRate // ignore: cast_nullable_to_non_nullable
              as double,
      recentCompleted: null == recentCompleted
          ? _value._recentCompleted
          : recentCompleted // ignore: cast_nullable_to_non_nullable
              as List<Challenge>,
      currentActive: null == currentActive
          ? _value._currentActive
          : currentActive // ignore: cast_nullable_to_non_nullable
              as List<Challenge>,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserChallengeStatsImpl implements _UserChallengeStats {
  const _$UserChallengeStatsImpl(
      {required this.totalChallenges,
      required this.completedChallenges,
      required this.activeChallenges,
      required this.totalPoints,
      required this.completionRate,
      required final List<Challenge> recentCompleted,
      required final List<Challenge> currentActive,
      this.lastUpdated})
      : _recentCompleted = recentCompleted,
        _currentActive = currentActive;

  factory _$UserChallengeStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserChallengeStatsImplFromJson(json);

  @override
  final int totalChallenges;
  @override
  final int completedChallenges;
  @override
  final int activeChallenges;
  @override
  final int totalPoints;
  @override
  final double completionRate;
  final List<Challenge> _recentCompleted;
  @override
  List<Challenge> get recentCompleted {
    if (_recentCompleted is EqualUnmodifiableListView) return _recentCompleted;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentCompleted);
  }

  final List<Challenge> _currentActive;
  @override
  List<Challenge> get currentActive {
    if (_currentActive is EqualUnmodifiableListView) return _currentActive;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_currentActive);
  }

  @override
  final DateTime? lastUpdated;

  @override
  String toString() {
    return 'UserChallengeStats(totalChallenges: $totalChallenges, completedChallenges: $completedChallenges, activeChallenges: $activeChallenges, totalPoints: $totalPoints, completionRate: $completionRate, recentCompleted: $recentCompleted, currentActive: $currentActive, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserChallengeStatsImpl &&
            (identical(other.totalChallenges, totalChallenges) ||
                other.totalChallenges == totalChallenges) &&
            (identical(other.completedChallenges, completedChallenges) ||
                other.completedChallenges == completedChallenges) &&
            (identical(other.activeChallenges, activeChallenges) ||
                other.activeChallenges == activeChallenges) &&
            (identical(other.totalPoints, totalPoints) ||
                other.totalPoints == totalPoints) &&
            (identical(other.completionRate, completionRate) ||
                other.completionRate == completionRate) &&
            const DeepCollectionEquality()
                .equals(other._recentCompleted, _recentCompleted) &&
            const DeepCollectionEquality()
                .equals(other._currentActive, _currentActive) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalChallenges,
      completedChallenges,
      activeChallenges,
      totalPoints,
      completionRate,
      const DeepCollectionEquality().hash(_recentCompleted),
      const DeepCollectionEquality().hash(_currentActive),
      lastUpdated);

  /// Create a copy of UserChallengeStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserChallengeStatsImplCopyWith<_$UserChallengeStatsImpl> get copyWith =>
      __$$UserChallengeStatsImplCopyWithImpl<_$UserChallengeStatsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserChallengeStatsImplToJson(
      this,
    );
  }
}

abstract class _UserChallengeStats implements UserChallengeStats {
  const factory _UserChallengeStats(
      {required final int totalChallenges,
      required final int completedChallenges,
      required final int activeChallenges,
      required final int totalPoints,
      required final double completionRate,
      required final List<Challenge> recentCompleted,
      required final List<Challenge> currentActive,
      final DateTime? lastUpdated}) = _$UserChallengeStatsImpl;

  factory _UserChallengeStats.fromJson(Map<String, dynamic> json) =
      _$UserChallengeStatsImpl.fromJson;

  @override
  int get totalChallenges;
  @override
  int get completedChallenges;
  @override
  int get activeChallenges;
  @override
  int get totalPoints;
  @override
  double get completionRate;
  @override
  List<Challenge> get recentCompleted;
  @override
  List<Challenge> get currentActive;
  @override
  DateTime? get lastUpdated;

  /// Create a copy of UserChallengeStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserChallengeStatsImplCopyWith<_$UserChallengeStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
