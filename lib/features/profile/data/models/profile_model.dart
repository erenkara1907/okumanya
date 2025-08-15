import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
class ProfileModel with _$ProfileModel {
  const factory ProfileModel({
    required String id,
    required String name,
    required String email,
    String? avatarUrl,
    required DateTime joinDate,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
}

@freezed
class ProfileStatistics with _$ProfileStatistics {
  const factory ProfileStatistics({
    required Duration totalReadingTime,
    required int booksRead,
    required int booksListened,
    required int averageReadingSpeed,
    required int ranking,
    required int totalUsers,
    required int points,
  }) = _ProfileStatistics;

  factory ProfileStatistics.fromJson(Map<String, dynamic> json) =>
      _$ProfileStatisticsFromJson(json);
}
