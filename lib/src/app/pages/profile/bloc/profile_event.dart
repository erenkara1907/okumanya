part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadProfile extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final String name;
  final String email;

  UpdateProfile({
    required this.name,
    required this.email,
  });

  @override
  List<Object?> get props => [name, email];
}

class LoadStatistics extends ProfileEvent {}
