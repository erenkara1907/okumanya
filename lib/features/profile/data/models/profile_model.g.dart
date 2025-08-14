// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileModelImpl _$$ProfileModelImplFromJson(Map<String, dynamic> json) =>
    _$ProfileModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      joinDate: DateTime.parse(json['joinDate'] as String),
    );

Map<String, dynamic> _$$ProfileModelImplToJson(_$ProfileModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'avatarUrl': instance.avatarUrl,
      'joinDate': instance.joinDate.toIso8601String(),
    };

_$ProfileStatisticsImpl _$$ProfileStatisticsImplFromJson(
        Map<String, dynamic> json) =>
    _$ProfileStatisticsImpl(
      totalReadingTime:
          Duration(microseconds: (json['totalReadingTime'] as num).toInt()),
      booksRead: (json['booksRead'] as num).toInt(),
      booksListened: (json['booksListened'] as num).toInt(),
      averageReadingSpeed: (json['averageReadingSpeed'] as num).toInt(),
      ranking: (json['ranking'] as num).toInt(),
      totalUsers: (json['totalUsers'] as num).toInt(),
      points: (json['points'] as num).toInt(),
    );

Map<String, dynamic> _$$ProfileStatisticsImplToJson(
        _$ProfileStatisticsImpl instance) =>
    <String, dynamic>{
      'totalReadingTime': instance.totalReadingTime.inMicroseconds,
      'booksRead': instance.booksRead,
      'booksListened': instance.booksListened,
      'averageReadingSpeed': instance.averageReadingSpeed,
      'ranking': instance.ranking,
      'totalUsers': instance.totalUsers,
      'points': instance.points,
    };
