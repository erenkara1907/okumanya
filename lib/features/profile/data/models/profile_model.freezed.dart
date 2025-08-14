// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) {
  return _ProfileModel.fromJson(json);
}

/// @nodoc
mixin _$ProfileModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  DateTime get joinDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProfileModelCopyWith<ProfileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileModelCopyWith<$Res> {
  factory $ProfileModelCopyWith(
          ProfileModel value, $Res Function(ProfileModel) then) =
      _$ProfileModelCopyWithImpl<$Res, ProfileModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String email,
      String? avatarUrl,
      DateTime joinDate});
}

/// @nodoc
class _$ProfileModelCopyWithImpl<$Res, $Val extends ProfileModel>
    implements $ProfileModelCopyWith<$Res> {
  _$ProfileModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? avatarUrl = freezed,
    Object? joinDate = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      joinDate: null == joinDate
          ? _value.joinDate
          : joinDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileModelImplCopyWith<$Res>
    implements $ProfileModelCopyWith<$Res> {
  factory _$$ProfileModelImplCopyWith(
          _$ProfileModelImpl value, $Res Function(_$ProfileModelImpl) then) =
      __$$ProfileModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String email,
      String? avatarUrl,
      DateTime joinDate});
}

/// @nodoc
class __$$ProfileModelImplCopyWithImpl<$Res>
    extends _$ProfileModelCopyWithImpl<$Res, _$ProfileModelImpl>
    implements _$$ProfileModelImplCopyWith<$Res> {
  __$$ProfileModelImplCopyWithImpl(
      _$ProfileModelImpl _value, $Res Function(_$ProfileModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? avatarUrl = freezed,
    Object? joinDate = null,
  }) {
    return _then(_$ProfileModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      joinDate: null == joinDate
          ? _value.joinDate
          : joinDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileModelImpl implements _ProfileModel {
  const _$ProfileModelImpl(
      {required this.id,
      required this.name,
      required this.email,
      this.avatarUrl,
      required this.joinDate});

  factory _$ProfileModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String email;
  @override
  final String? avatarUrl;
  @override
  final DateTime joinDate;

  @override
  String toString() {
    return 'ProfileModel(id: $id, name: $name, email: $email, avatarUrl: $avatarUrl, joinDate: $joinDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.joinDate, joinDate) ||
                other.joinDate == joinDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, email, avatarUrl, joinDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileModelImplCopyWith<_$ProfileModelImpl> get copyWith =>
      __$$ProfileModelImplCopyWithImpl<_$ProfileModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileModelImplToJson(
      this,
    );
  }
}

abstract class _ProfileModel implements ProfileModel {
  const factory _ProfileModel(
      {required final String id,
      required final String name,
      required final String email,
      final String? avatarUrl,
      required final DateTime joinDate}) = _$ProfileModelImpl;

  factory _ProfileModel.fromJson(Map<String, dynamic> json) =
      _$ProfileModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get email;
  @override
  String? get avatarUrl;
  @override
  DateTime get joinDate;
  @override
  @JsonKey(ignore: true)
  _$$ProfileModelImplCopyWith<_$ProfileModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProfileStatistics _$ProfileStatisticsFromJson(Map<String, dynamic> json) {
  return _ProfileStatistics.fromJson(json);
}

/// @nodoc
mixin _$ProfileStatistics {
  Duration get totalReadingTime => throw _privateConstructorUsedError;
  int get booksRead => throw _privateConstructorUsedError;
  int get booksListened => throw _privateConstructorUsedError;
  int get averageReadingSpeed => throw _privateConstructorUsedError;
  int get ranking => throw _privateConstructorUsedError;
  int get totalUsers => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProfileStatisticsCopyWith<ProfileStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileStatisticsCopyWith<$Res> {
  factory $ProfileStatisticsCopyWith(
          ProfileStatistics value, $Res Function(ProfileStatistics) then) =
      _$ProfileStatisticsCopyWithImpl<$Res, ProfileStatistics>;
  @useResult
  $Res call(
      {Duration totalReadingTime,
      int booksRead,
      int booksListened,
      int averageReadingSpeed,
      int ranking,
      int totalUsers,
      int points});
}

/// @nodoc
class _$ProfileStatisticsCopyWithImpl<$Res, $Val extends ProfileStatistics>
    implements $ProfileStatisticsCopyWith<$Res> {
  _$ProfileStatisticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalReadingTime = null,
    Object? booksRead = null,
    Object? booksListened = null,
    Object? averageReadingSpeed = null,
    Object? ranking = null,
    Object? totalUsers = null,
    Object? points = null,
  }) {
    return _then(_value.copyWith(
      totalReadingTime: null == totalReadingTime
          ? _value.totalReadingTime
          : totalReadingTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      booksRead: null == booksRead
          ? _value.booksRead
          : booksRead // ignore: cast_nullable_to_non_nullable
              as int,
      booksListened: null == booksListened
          ? _value.booksListened
          : booksListened // ignore: cast_nullable_to_non_nullable
              as int,
      averageReadingSpeed: null == averageReadingSpeed
          ? _value.averageReadingSpeed
          : averageReadingSpeed // ignore: cast_nullable_to_non_nullable
              as int,
      ranking: null == ranking
          ? _value.ranking
          : ranking // ignore: cast_nullable_to_non_nullable
              as int,
      totalUsers: null == totalUsers
          ? _value.totalUsers
          : totalUsers // ignore: cast_nullable_to_non_nullable
              as int,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileStatisticsImplCopyWith<$Res>
    implements $ProfileStatisticsCopyWith<$Res> {
  factory _$$ProfileStatisticsImplCopyWith(_$ProfileStatisticsImpl value,
          $Res Function(_$ProfileStatisticsImpl) then) =
      __$$ProfileStatisticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Duration totalReadingTime,
      int booksRead,
      int booksListened,
      int averageReadingSpeed,
      int ranking,
      int totalUsers,
      int points});
}

/// @nodoc
class __$$ProfileStatisticsImplCopyWithImpl<$Res>
    extends _$ProfileStatisticsCopyWithImpl<$Res, _$ProfileStatisticsImpl>
    implements _$$ProfileStatisticsImplCopyWith<$Res> {
  __$$ProfileStatisticsImplCopyWithImpl(_$ProfileStatisticsImpl _value,
      $Res Function(_$ProfileStatisticsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalReadingTime = null,
    Object? booksRead = null,
    Object? booksListened = null,
    Object? averageReadingSpeed = null,
    Object? ranking = null,
    Object? totalUsers = null,
    Object? points = null,
  }) {
    return _then(_$ProfileStatisticsImpl(
      totalReadingTime: null == totalReadingTime
          ? _value.totalReadingTime
          : totalReadingTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      booksRead: null == booksRead
          ? _value.booksRead
          : booksRead // ignore: cast_nullable_to_non_nullable
              as int,
      booksListened: null == booksListened
          ? _value.booksListened
          : booksListened // ignore: cast_nullable_to_non_nullable
              as int,
      averageReadingSpeed: null == averageReadingSpeed
          ? _value.averageReadingSpeed
          : averageReadingSpeed // ignore: cast_nullable_to_non_nullable
              as int,
      ranking: null == ranking
          ? _value.ranking
          : ranking // ignore: cast_nullable_to_non_nullable
              as int,
      totalUsers: null == totalUsers
          ? _value.totalUsers
          : totalUsers // ignore: cast_nullable_to_non_nullable
              as int,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileStatisticsImpl implements _ProfileStatistics {
  const _$ProfileStatisticsImpl(
      {required this.totalReadingTime,
      required this.booksRead,
      required this.booksListened,
      required this.averageReadingSpeed,
      required this.ranking,
      required this.totalUsers,
      required this.points});

  factory _$ProfileStatisticsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileStatisticsImplFromJson(json);

  @override
  final Duration totalReadingTime;
  @override
  final int booksRead;
  @override
  final int booksListened;
  @override
  final int averageReadingSpeed;
  @override
  final int ranking;
  @override
  final int totalUsers;
  @override
  final int points;

  @override
  String toString() {
    return 'ProfileStatistics(totalReadingTime: $totalReadingTime, booksRead: $booksRead, booksListened: $booksListened, averageReadingSpeed: $averageReadingSpeed, ranking: $ranking, totalUsers: $totalUsers, points: $points)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileStatisticsImpl &&
            (identical(other.totalReadingTime, totalReadingTime) ||
                other.totalReadingTime == totalReadingTime) &&
            (identical(other.booksRead, booksRead) ||
                other.booksRead == booksRead) &&
            (identical(other.booksListened, booksListened) ||
                other.booksListened == booksListened) &&
            (identical(other.averageReadingSpeed, averageReadingSpeed) ||
                other.averageReadingSpeed == averageReadingSpeed) &&
            (identical(other.ranking, ranking) || other.ranking == ranking) &&
            (identical(other.totalUsers, totalUsers) ||
                other.totalUsers == totalUsers) &&
            (identical(other.points, points) || other.points == points));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, totalReadingTime, booksRead,
      booksListened, averageReadingSpeed, ranking, totalUsers, points);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileStatisticsImplCopyWith<_$ProfileStatisticsImpl> get copyWith =>
      __$$ProfileStatisticsImplCopyWithImpl<_$ProfileStatisticsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileStatisticsImplToJson(
      this,
    );
  }
}

abstract class _ProfileStatistics implements ProfileStatistics {
  const factory _ProfileStatistics(
      {required final Duration totalReadingTime,
      required final int booksRead,
      required final int booksListened,
      required final int averageReadingSpeed,
      required final int ranking,
      required final int totalUsers,
      required final int points}) = _$ProfileStatisticsImpl;

  factory _ProfileStatistics.fromJson(Map<String, dynamic> json) =
      _$ProfileStatisticsImpl.fromJson;

  @override
  Duration get totalReadingTime;
  @override
  int get booksRead;
  @override
  int get booksListened;
  @override
  int get averageReadingSpeed;
  @override
  int get ranking;
  @override
  int get totalUsers;
  @override
  int get points;
  @override
  @JsonKey(ignore: true)
  _$$ProfileStatisticsImplCopyWith<_$ProfileStatisticsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
