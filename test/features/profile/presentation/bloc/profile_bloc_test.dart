import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:okumanya/features/profile/presentation/bloc/profile_bloc.dart';

@GenerateMocks([])
void main() {
  late ProfileBloc profileBloc;

  setUp(() {
    profileBloc = ProfileBloc();
  });

  tearDown(() {
    profileBloc.close();
  });

  group('ProfileBloc', () {
    test('initial state is ProfileState with default values', () {
      expect(profileBloc.state, equals(const ProfileState()));
      expect(profileBloc.state.status, ProfileStatus.initial);
      expect(profileBloc.state.profile, isNull);
      expect(profileBloc.state.statistics, isNull);
      expect(profileBloc.state.errorMessage, equals(''));
    });

    group('LoadProfile Event', () {
      blocTest<ProfileBloc, ProfileState>(
        'emits [loading, success] when profile loads successfully',
        build: () => profileBloc,
        act: (bloc) => bloc.add(LoadProfile()),
        wait: const Duration(milliseconds: 1200), // Wait for both profile and stats
        expect: () => [
          const ProfileState().copyWith(status: ProfileStatus.loading),
          ProfileState().copyWith(
            status: ProfileStatus.success,
            profile: ProfileModel(
              id: '1',
              name: 'John Doe',
              email: 'john.doe@example.com',
              avatarUrl: 'https://example.com/avatar.jpg',
              joinDate: DateTime(2023, 1, 15),
            ),
          ),
          ProfileState().copyWith(
            status: ProfileStatus.success,
            profile: ProfileModel(
              id: '1',
              name: 'John Doe',
              email: 'john.doe@example.com',
              avatarUrl: 'https://example.com/avatar.jpg',
              joinDate: DateTime(2023, 1, 15),
            ),
            statistics: const ProfileStatistics(
              totalReadingTime: Duration(hours: 325, minutes: 21, seconds: 15),
              booksRead: 20,
              booksListened: 15,
              averageReadingSpeed: 80,
              ranking: 13,
              totalUsers: 98,
              points: 2500,
            ),
          ),
        ],
      );

      blocTest<ProfileBloc, ProfileState>(
        'handles multiple LoadProfile events gracefully',
        build: () => profileBloc,
        act: (bloc) {
          bloc.add(LoadProfile());
          bloc.add(LoadProfile());
          bloc.add(LoadProfile());
        },
        wait: const Duration(milliseconds: 1200),
        verify: (bloc) {
          expect(bloc.state.status, ProfileStatus.success);
          expect(bloc.state.profile, isNotNull);
          expect(bloc.state.statistics, isNotNull);
        },
      );

      blocTest<ProfileBloc, ProfileState>(
        'loads profile when already in success state',
        build: () => profileBloc,
        seed: () => ProfileState().copyWith(
          status: ProfileStatus.success,
          profile: ProfileModel(
            id: '2',
            name: 'Old User',
            email: 'old@example.com',
            avatarUrl: 'https://example.com/avatar.jpg',
            joinDate: DateTime(2022, 1, 1),
          ),
        ),
        act: (bloc) => bloc.add(LoadProfile()),
        wait: const Duration(milliseconds: 1200),
        expect: () => [
          const ProfileState().copyWith(status: ProfileStatus.loading),
          ProfileState().copyWith(
            status: ProfileStatus.success,
            profile: ProfileModel(
              id: '1',
              name: 'John Doe',
              email: 'john.doe@example.com',
              avatarUrl: 'https://example.com/avatar.jpg',
              joinDate: DateTime(2023, 1, 15),
            ),
          ),
          ProfileState().copyWith(
            status: ProfileStatus.success,
            profile: ProfileModel(
              id: '1',
              name: 'John Doe',
              email: 'john.doe@example.com',
              avatarUrl: 'https://example.com/avatar.jpg',
              joinDate: DateTime(2023, 1, 15),
            ),
            statistics: const ProfileStatistics(
              totalReadingTime: Duration(hours: 325, minutes: 21, seconds: 15),
              booksRead: 20,
              booksListened: 15,
              averageReadingSpeed: 80,
              ranking: 13,
              totalUsers: 98,
              points: 2500,
            ),
          ),
        ],
      );
    });

    group('UpdateProfile Event', () {
      final initialProfile = ProfileModel(
        id: '1',
        name: 'John Doe',
        email: 'john.doe@example.com',
        avatarUrl: 'https://example.com/avatar.jpg',
        joinDate: DateTime(2023, 1, 15),
      );

      blocTest<ProfileBloc, ProfileState>(
        'updates profile successfully when profile exists',
        build: () => profileBloc,
        seed: () => ProfileState().copyWith(
          status: ProfileStatus.success,
          profile: initialProfile,
        ),
        act: (bloc) => bloc.add(UpdateProfile(
          name: 'Jane Smith',
          email: 'jane.smith@example.com',
        )),
        wait: const Duration(milliseconds: 600),
        expect: () => [
          ProfileState().copyWith(
            status: ProfileStatus.loading,
            profile: initialProfile,
          ),
          ProfileState().copyWith(
            status: ProfileStatus.success,
            profile: ProfileModel(
              id: '1',
              name: 'Jane Smith',
              email: 'jane.smith@example.com',
              avatarUrl: 'https://example.com/avatar.jpg',
              joinDate: DateTime(2023, 1, 15),
            ),
          ),
        ],
      );

      blocTest<ProfileBloc, ProfileState>(
        'does not update profile when profile is null',
        build: () => profileBloc,
        act: (bloc) => bloc.add(UpdateProfile(
          name: 'Jane Smith',
          email: 'jane.smith@example.com',
        )),
        expect: () => [],
      );

      blocTest<ProfileBloc, ProfileState>(
        'updates only name when email is same',
        build: () => profileBloc,
        seed: () => ProfileState().copyWith(
          status: ProfileStatus.success,
          profile: initialProfile,
        ),
        act: (bloc) => bloc.add(UpdateProfile(
          name: 'John Smith',
          email: 'john.doe@example.com', // Same email
        )),
        wait: const Duration(milliseconds: 600),
        expect: () => [
          ProfileState().copyWith(
            status: ProfileStatus.loading,
            profile: initialProfile,
          ),
          ProfileState().copyWith(
            status: ProfileStatus.success,
            profile: ProfileModel(
              id: '1',
              name: 'John Smith',
              email: 'john.doe@example.com',
              avatarUrl: 'https://example.com/avatar.jpg',
              joinDate: DateTime(2023, 1, 15),
            ),
          ),
        ],
      );

      blocTest<ProfileBloc, ProfileState>(
        'handles empty name gracefully',
        build: () => profileBloc,
        seed: () => ProfileState().copyWith(
          status: ProfileStatus.success,
          profile: initialProfile,
        ),
        act: (bloc) => bloc.add(UpdateProfile(
          name: '',
          email: 'new@example.com',
        )),
        wait: const Duration(milliseconds: 600),
        expect: () => [
          ProfileState().copyWith(
            status: ProfileStatus.loading,
            profile: initialProfile,
          ),
          ProfileState().copyWith(
            status: ProfileStatus.success,
            profile: ProfileModel(
              id: '1',
              name: '',
              email: 'new@example.com',
              avatarUrl: 'https://example.com/avatar.jpg',
              joinDate: DateTime(2023, 1, 15),
            ),
          ),
        ],
      );
    });

    group('LoadStatistics Event', () {
      blocTest<ProfileBloc, ProfileState>(
        'loads statistics successfully',
        build: () => profileBloc,
        act: (bloc) => bloc.add(LoadStatistics()),
        wait: const Duration(milliseconds: 400),
        expect: () => [
          const ProfileState().copyWith(
            statistics: ProfileStatistics(
              totalReadingTime: Duration(hours: 325, minutes: 21, seconds: 15),
              booksRead: 20,
              booksListened: 15,
              averageReadingSpeed: 80,
              ranking: 13,
              totalUsers: 98,
              points: 2500,
            ),
          ),
        ],
      );

      blocTest<ProfileBloc, ProfileState>(
        'loads statistics with existing profile',
        build: () => profileBloc,
        seed: () => ProfileState().copyWith(
          status: ProfileStatus.success,
          profile: ProfileModel(
            id: '1',
            name: 'John Doe',
            email: 'john.doe@example.com',
            avatarUrl: 'https://example.com/avatar.jpg',
            joinDate: DateTime(2023, 1, 15),
          ),
        ),
        act: (bloc) => bloc.add(LoadStatistics()),
        wait: const Duration(milliseconds: 400),
        expect: () => [
          ProfileState().copyWith(
            status: ProfileStatus.success,
            profile: ProfileModel(
              id: '1',
              name: 'John Doe',
              email: 'john.doe@example.com',
              avatarUrl: 'https://example.com/avatar.jpg',
              joinDate: DateTime(2023, 1, 15),
            ),
            statistics: const ProfileStatistics(
              totalReadingTime: Duration(hours: 325, minutes: 21, seconds: 15),
              booksRead: 20,
              booksListened: 15,
              averageReadingSpeed: 80,
              ranking: 13,
              totalUsers: 98,
              points: 2500,
            ),
          ),
        ],
      );

      blocTest<ProfileBloc, ProfileState>(
        'handles multiple LoadStatistics events',
        build: () => profileBloc,
        act: (bloc) {
          bloc.add(LoadStatistics());
          bloc.add(LoadStatistics());
          bloc.add(LoadStatistics());
        },
        wait: const Duration(milliseconds: 500),
        verify: (bloc) {
          expect(bloc.state.statistics, isNotNull);
          expect(bloc.state.statistics!.booksRead, 20);
          expect(bloc.state.statistics!.totalUsers, 98);
        },
      );
    });

    group('Combined Operations', () {
      blocTest<ProfileBloc, ProfileState>(
        'handles load profile followed by update profile',
        build: () => profileBloc,
        act: (bloc) async {
          bloc.add(LoadProfile());
          // Wait for profile to load before updating
          await Future.delayed(const Duration(milliseconds: 900));
          bloc.add(UpdateProfile(
            name: 'Updated Name',
            email: 'updated@example.com',
          ));
        },
        wait: const Duration(milliseconds: 1800),
        verify: (bloc) {
          expect(bloc.state.status, ProfileStatus.success);
          expect(bloc.state.profile?.name, 'Updated Name');
          expect(bloc.state.profile?.email, 'updated@example.com');
          expect(bloc.state.statistics, isNotNull);
        },
      );

      blocTest<ProfileBloc, ProfileState>(
        'handles statistics load with profile operations',
        build: () => profileBloc,
        act: (bloc) {
          bloc.add(LoadProfile());
          bloc.add(LoadStatistics());
        },
        wait: const Duration(milliseconds: 1200),
        verify: (bloc) {
          expect(bloc.state.profile, isNotNull);
          expect(bloc.state.statistics, isNotNull);
          expect(bloc.state.status, ProfileStatus.success);
        },
      );
    });

    group('State Management', () {
      test('ProfileState copyWith works correctly', () {
        const initialState = ProfileState();
        final profile = ProfileModel(
          id: '1',
          name: 'Test',
          email: 'test@example.com',
          avatarUrl: 'https://example.com/avatar.jpg',
          joinDate: DateTime(2023, 1, 1),
        );

        final newState = initialState.copyWith(
          status: ProfileStatus.success,
          profile: profile,
          errorMessage: 'Test error',
        );

        expect(newState.status, ProfileStatus.success);
        expect(newState.profile, equals(profile));
        expect(newState.errorMessage, 'Test error');
        expect(newState.statistics, initialState.statistics);
      });

      test('ProfileState equality works correctly', () {
        const state1 = ProfileState();
        const state2 = ProfileState();
        final state3 = const ProfileState().copyWith(status: ProfileStatus.loading);

        expect(state1, equals(state2));
        expect(state1, isNot(equals(state3)));
      });

      test('ProfileModel equality works correctly', () {
        final profile1 = ProfileModel(
          id: '1',
          name: 'John',
          email: 'john@example.com',
          avatarUrl: 'https://example.com/avatar.jpg',
          joinDate: DateTime(2023, 1, 1),
        );
        final profile2 = ProfileModel(
          id: '1',
          name: 'John',
          email: 'john@example.com',
          avatarUrl: 'https://example.com/avatar.jpg',
          joinDate: DateTime(2023, 1, 1),
        );
        final profile3 = ProfileModel(
          id: '2',
          name: 'Jane',
          email: 'jane@example.com',
          avatarUrl: 'https://example.com/avatar.jpg',
          joinDate: DateTime(2023, 1, 1),
        );

        expect(profile1, equals(profile2));
        expect(profile1, isNot(equals(profile3)));
      });

      test('ProfileStatistics equality works correctly', () {
        const stats1 = ProfileStatistics(
          totalReadingTime: Duration(hours: 10),
          booksRead: 5,
          booksListened: 3,
          averageReadingSpeed: 75,
          ranking: 10,
          totalUsers: 100,
          points: 1000,
        );
        const stats2 = ProfileStatistics(
          totalReadingTime: Duration(hours: 10),
          booksRead: 5,
          booksListened: 3,
          averageReadingSpeed: 75,
          ranking: 10,
          totalUsers: 100,
          points: 1000,
        );
        const stats3 = ProfileStatistics(
          totalReadingTime: Duration(hours: 20),
          booksRead: 10,
          booksListened: 8,
          averageReadingSpeed: 85,
          ranking: 5,
          totalUsers: 100,
          points: 2000,
        );

        expect(stats1, equals(stats2));
        expect(stats1, isNot(equals(stats3)));
      });
    });

    group('Edge Cases', () {
      blocTest<ProfileBloc, ProfileState>(
        'handles profile with null avatar URL',
        build: () => profileBloc,
        act: (bloc) => bloc.add(LoadProfile()),
        wait: const Duration(milliseconds: 900),
        verify: (bloc) {
          expect(bloc.state.profile?.avatarUrl, isNotNull);
        },
      );

      blocTest<ProfileBloc, ProfileState>(
        'handles very long profile names and emails',
        build: () => profileBloc,
        seed: () => ProfileState().copyWith(
          status: ProfileStatus.success,
          profile: ProfileModel(
            id: '1',
            name: 'Short Name',
            email: 'short@example.com',
            avatarUrl: 'https://example.com/avatar.jpg',
            joinDate: DateTime(2023, 1, 15),
          ),
        ),
        act: (bloc) => bloc.add(UpdateProfile(
          name: 'Very Long Name That Exceeds Normal Length Expectations' * 3,
          email: 'very.long.email.address.that.might.cause.issues@very.long.domain.name.example.com',
        )),
        wait: const Duration(milliseconds: 600),
        verify: (bloc) {
          expect(bloc.state.status, ProfileStatus.success);
          expect(bloc.state.profile?.name, isNotNull);
          expect(bloc.state.profile?.email, isNotNull);
        },
      );

      blocTest<ProfileBloc, ProfileState>(
        'handles zero statistics gracefully',
        build: () => profileBloc,
        act: (bloc) => bloc.add(LoadStatistics()),
        wait: const Duration(milliseconds: 400),
        verify: (bloc) {
          expect(bloc.state.statistics?.booksRead, greaterThan(0));
          expect(bloc.state.statistics?.ranking, greaterThan(0));
        },
      );
    });

    group('Performance Tests', () {
      blocTest<ProfileBloc, ProfileState>(
        'completes profile loading within reasonable time',
        build: () => profileBloc,
        act: (bloc) => bloc.add(LoadProfile()),
        wait: const Duration(milliseconds: 1500),
        verify: (bloc) {
          expect(bloc.state.status, ProfileStatus.success);
          expect(bloc.state.profile, isNotNull);
          expect(bloc.state.statistics, isNotNull);
        },
      );

      blocTest<ProfileBloc, ProfileState>(
        'handles rapid consecutive profile updates',
        build: () => profileBloc,
        seed: () => ProfileState().copyWith(
          status: ProfileStatus.success,
          profile: ProfileModel(
            id: '1',
            name: 'Initial Name',
            email: 'initial@example.com',
            avatarUrl: 'https://example.com/avatar.jpg',
            joinDate: DateTime(2023, 1, 15),
          ),
        ),
        act: (bloc) {
          for (int i = 0; i < 5; i++) {
            bloc.add(UpdateProfile(
              name: 'Name $i',
              email: 'email$i@example.com',
            ));
          }
        },
        wait: const Duration(milliseconds: 3000),
        verify: (bloc) {
          expect(bloc.state.status, ProfileStatus.success);
          expect(bloc.state.profile?.name, contains('Name'));
          expect(bloc.state.profile?.email, contains('email'));
        },
      );
    });
  });
}