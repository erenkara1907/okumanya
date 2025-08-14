import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:okumanya/core/network/network_info.dart';
import 'package:okumanya/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:okumanya/features/auth/data/models/login_response_model.dart';
import 'package:okumanya/features/auth/data/models/user_model.dart';
import 'package:okumanya/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:okumanya/features/auth/domain/entities/login_entity.dart';

import 'auth_repository_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSource, NetworkInfo])
void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = AuthRepositoryImpl(mockRemoteDataSource, mockNetworkInfo);
  });

  group('login', () {
    const tEmail = 'test@example.com';
    const tPassword = 'password123';
    const tLoginResponse = LoginResponseModel(
      token: 'test_token',
      isTeacher: false,
      user: UserModel(
        id: 1,
        name: 'Test User',
        email: tEmail,
        userLevel: 1,
        userRole: 'student',
        createdAt: '2023-01-01',
        updatedAt: '2023-01-01',
      ),
    );

    test('should return LoginEntity when login is successful', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.login(any)).thenAnswer((_) async => tLoginResponse);

      // act
      final result = await repository.login(tEmail, tPassword);

      // assert
      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Expected success but got failure'),
        (loginEntity) {
          expect(loginEntity, isA<LoginEntity>());
          expect(loginEntity.token, equals('test_token'));
          expect(loginEntity.user.email, equals(tEmail));
        },
      );
    });
  });
}