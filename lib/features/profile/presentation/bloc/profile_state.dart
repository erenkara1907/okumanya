part of 'profile_bloc.dart';

enum ProfileStatus { initial, loading, success, error, notfound }

extension ProfileStatusX on ProfileStatus {
  bool get isInitial => this == ProfileStatus.initial;
  bool get isLoading => this == ProfileStatus.loading;
  bool get isSuccess => this == ProfileStatus.success;
  bool get isError => this == ProfileStatus.error;
  bool get isNotFound => this == ProfileStatus.notfound;
}

class ProfileState extends Equatable {
  const ProfileState({
    this.status = ProfileStatus.initial,
    this.profile,
    this.statistics,
    this.errorMessage = '',
  });

  final ProfileStatus status;
  final ProfileModel? profile;
  final ProfileStatistics? statistics;
  final String errorMessage;

  @override
  List<Object?> get props => [
        status,
        profile,
        statistics,
        errorMessage,
      ];

  ProfileState copyWith({
    ProfileStatus? status,
    ProfileModel? profile,
    ProfileStatistics? statistics,
    String? errorMessage,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      statistics: statistics ?? this.statistics,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class ProfileModel extends Equatable {
  const ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.joinDate,
  });

  final String id;
  final String name;
  final String email;
  final String avatarUrl;
  final DateTime joinDate;

  @override
  List<Object?> get props => [id, name, email, avatarUrl, joinDate];
}

class ProfileStatistics extends Equatable {
  const ProfileStatistics({
    required this.totalReadingTime,
    required this.booksRead,
    required this.booksListened,
    required this.averageReadingSpeed,
    required this.ranking,
    required this.totalUsers,
    required this.points,
  });

  final Duration totalReadingTime;
  final int booksRead;
  final int booksListened;
  final int averageReadingSpeed; // words per minute
  final int ranking;
  final int totalUsers;
  final int points;

  @override
  List<Object?> get props => [
        totalReadingTime,
        booksRead,
        booksListened,
        averageReadingSpeed,
        ranking,
        totalUsers,
        points,
      ];
}
