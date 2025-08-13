import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfile>(_onUpdateProfile);
    on<LoadStatistics>(_onLoadStatistics);
  }

  Future<void> _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: ProfileStatus.loading));

    try {
      // Mock data for now - replace with actual API call
      await Future.delayed(const Duration(milliseconds: 800));
      
      final mockProfile = ProfileModel(
        id: '1',
        name: 'John Doe',
        email: 'john.doe@example.com',
        avatarUrl: 'https://example.com/avatar.jpg',
        joinDate: DateTime(2023, 1, 15),
      );

      emit(state.copyWith(
        status: ProfileStatus.success,
        profile: mockProfile,
      ));

      // Load statistics after profile loads
      add(LoadStatistics());
    } catch (e) {
      emit(state.copyWith(
        status: ProfileStatus.error,
        errorMessage: 'Profil yüklenirken hata oluştu: ${e.toString()}',
      ));
    }
  }

  Future<void> _onUpdateProfile(UpdateProfile event, Emitter<ProfileState> emit) async {
    if (state.profile == null) return;

    emit(state.copyWith(status: ProfileStatus.loading));

    try {
      // Mock API call
      await Future.delayed(const Duration(milliseconds: 500));

      final updatedProfile = ProfileModel(
        id: state.profile!.id,
        name: event.name,
        email: event.email,
        avatarUrl: state.profile!.avatarUrl,
        joinDate: state.profile!.joinDate,
      );

      emit(state.copyWith(
        status: ProfileStatus.success,
        profile: updatedProfile,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProfileStatus.error,
        errorMessage: 'Profil güncellenirken hata oluştu: ${e.toString()}',
      ));
    }
  }

  Future<void> _onLoadStatistics(LoadStatistics event, Emitter<ProfileState> emit) async {
    try {
      // Mock statistics data
      await Future.delayed(const Duration(milliseconds: 300));
      
      const mockStatistics = ProfileStatistics(
        totalReadingTime: Duration(hours: 325, minutes: 21, seconds: 15),
        booksRead: 20,
        booksListened: 15,
        averageReadingSpeed: 80,
        ranking: 13,
        totalUsers: 98,
        points: 2500,
      );

      emit(state.copyWith(
        statistics: mockStatistics,
      ));
    } catch (e) {
      // Don't emit error for statistics loading failure
      // as it's not critical
    }
  }
}
