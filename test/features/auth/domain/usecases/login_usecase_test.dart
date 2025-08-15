import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:okumanya/core/error/failures.dart';
import 'package:okumanya/features/auth/domain/entities/login_entity.dart';
import 'package:okumanya/features/auth/data/models/user_model.dart';
import 'package:okumanya/features/auth/domain/repositories/auth_repository.dart';
import 'package:okumanya/features/auth/domain/usecases/login_usecase.dart';

import 'login_usecase_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late LoginUseCase useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = LoginUseCase(mockAuthRepository);
  });

  group('LoginUseCase', () {
    const tEmail = 'test@example.com';
    const tPassword = 'password123';
    const tParams = LoginParams(email: tEmail, password: tPassword);

    final tUserModel = UserModel(
      id: 1,
      name: 'John Doe',
      email: tEmail,
      userLevel: 1,
      userRole: 'student',
      createdAt: '2023-01-15T00:00:00.000Z',
      updatedAt: '2023-01-15T00:00:00.000Z',
    );

    final tLoginEntity = LoginEntity(
      token: 'test_token_123',
      isTeacher: false,
      user: tUserModel,
    );

    test('should return LoginEntity when repository call is successful',
        () async {
      // arrange
      when(mockAuthRepository.login(tEmail, tPassword))
          .thenAnswer((_) async => Right(tLoginEntity));

      // act
      final result = await useCase(tParams);

      // assert
      expect(result, Right(tLoginEntity));
      verify(mockAuthRepository.login(tEmail, tPassword));
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should return NetworkFailure when there is no internet connection',
        () async {
      // arrange
      when(mockAuthRepository.login(tEmail, tPassword)).thenAnswer(
          (_) async => Left(NetworkFailure(message: 'No internet connection')));

      // act
      final result = await useCase(tParams);

      // assert
      expect(result, Left(NetworkFailure(message: 'No internet connection')));
      verify(mockAuthRepository.login(tEmail, tPassword));
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should return AuthFailure when credentials are invalid', () async {
      // arrange
      when(mockAuthRepository.login(tEmail, tPassword)).thenAnswer(
          (_) async => Left(AuthFailure(message: 'Invalid credentials')));

      // act
      final result = await useCase(tParams);

      // assert
      expect(result, Left(AuthFailure(message: 'Invalid credentials')));
      verify(mockAuthRepository.login(tEmail, tPassword));
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should return ServerFailure when server returns error', () async {
      // arrange
      when(mockAuthRepository.login(tEmail, tPassword)).thenAnswer((_) async =>
          Left(ServerFailure(message: 'Server error', statusCode: 500)));

      // act
      final result = await useCase(tParams);

      // assert
      expect(result,
          Left(ServerFailure(message: 'Server error', statusCode: 500)));
      verify(mockAuthRepository.login(tEmail, tPassword));
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should return ValidationFailure when email format is invalid',
        () async {
      // arrange
      const invalidParams =
          LoginParams(email: 'invalid-email', password: tPassword);
      when(mockAuthRepository.login('invalid-email', tPassword)).thenAnswer(
          (_) async =>
              Left(ValidationFailure(message: 'Invalid email format')));

      // act
      final result = await useCase(invalidParams);

      // assert
      expect(result, Left(ValidationFailure(message: 'Invalid email format')));
      verify(mockAuthRepository.login('invalid-email', tPassword));
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should return ValidationFailure when password is too short',
        () async {
      // arrange
      const shortPasswordParams = LoginParams(email: tEmail, password: '123');
      when(mockAuthRepository.login(tEmail, '123')).thenAnswer(
          (_) async => Left(ValidationFailure(message: 'Password too short')));

      // act
      final result = await useCase(shortPasswordParams);

      // assert
      expect(result, Left(ValidationFailure(message: 'Password too short')));
      verify(mockAuthRepository.login(tEmail, '123'));
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should return NotFoundFailure when user does not exist', () async {
      // arrange
      when(mockAuthRepository.login(tEmail, tPassword)).thenAnswer(
          (_) async => Left(NotFoundFailure(message: 'User not found')));

      // act
      final result = await useCase(tParams);

      // assert
      expect(result, Left(NotFoundFailure(message: 'User not found')));
      verify(mockAuthRepository.login(tEmail, tPassword));
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should handle successful login with teacher role', () async {
      // arrange
      final tTeacherUserModel = UserModel(
        id: 2,
        name: 'Jane Teacher',
        email: 'teacher@example.com',
        userLevel: 3,
        userRole: 'teacher',
        createdAt: '2023-01-10T00:00:00.000Z',
        updatedAt: '2023-01-15T00:00:00.000Z',
      );

      final tTeacherLoginEntity = LoginEntity(
        token: 'teacher_token_456',
        isTeacher: true,
        user: tTeacherUserModel,
      );

      const tTeacherParams = LoginParams(
        email: 'teacher@example.com',
        password: 'teacherpass123',
      );

      when(mockAuthRepository.login('teacher@example.com', 'teacherpass123'))
          .thenAnswer((_) async => Right(tTeacherLoginEntity));

      // act
      final result = await useCase(tTeacherParams);

      // assert
      expect(result, Right(tTeacherLoginEntity));
      expect(result.fold((l) => null, (r) => r.isTeacher), true);
      expect(result.fold((l) => null, (r) => r.user.userRole), 'teacher');
      verify(mockAuthRepository.login('teacher@example.com', 'teacherpass123'));
      verifyNoMoreInteractions(mockAuthRepository);
    });

    group('LoginParams', () {
      test('should create LoginParams with correct values', () {
        // act
        const params = LoginParams(email: tEmail, password: tPassword);

        // assert
        expect(params.email, tEmail);
        expect(params.password, tPassword);
      });

      test('should support equality comparison', () {
        // arrange
        const params1 = LoginParams(email: tEmail, password: tPassword);
        const params2 = LoginParams(email: tEmail, password: tPassword);
        const params3 =
            LoginParams(email: 'different@email.com', password: tPassword);

        // assert
        expect(params1, equals(params2));
        expect(params1, isNot(equals(params3)));
      });

      test('should have proper string representation', () {
        // arrange
        const params = LoginParams(email: tEmail, password: tPassword);

        // act
        final stringRep = params.toString();

        // assert
        expect(stringRep, contains('LoginParams'));
        expect(stringRep, contains(tEmail));
        // Password should not be exposed in toString for security
        expect(stringRep, isNot(contains(tPassword)));
      });

      test('should handle empty email and password', () {
        // act
        const params = LoginParams(email: '', password: '');

        // assert
        expect(params.email, '');
        expect(params.password, '');
      });

      test('should handle special characters in email and password', () {
        // arrange
        const specialEmail = 'test+special@example-domain.co.uk';
        const specialPassword = 'P@ssw0rd!#\$%^&*()_+{}[]|\\:";\'<>?,./`~';

        // act
        const params =
            LoginParams(email: specialEmail, password: specialPassword);

        // assert
        expect(params.email, specialEmail);
        expect(params.password, specialPassword);
      });
    });

    group('Edge Cases', () {
      test('should handle very long email addresses', () async {
        // arrange
        const longEmail =
            'very.long.email.address.that.might.cause.issues@very.long.domain.name.example.com';
        const longEmailParams =
            LoginParams(email: longEmail, password: tPassword);

        when(mockAuthRepository.login(longEmail, tPassword))
            .thenAnswer((_) async => Right(LoginEntity(
                  token: tLoginEntity.token,
                  isTeacher: tLoginEntity.isTeacher,
                  user: UserModel(
                    id: tUserModel.id,
                    name: tUserModel.name,
                    email: longEmail,
                    userLevel: tUserModel.userLevel,
                    userRole: tUserModel.userRole,
                    createdAt: tUserModel.createdAt,
                    updatedAt: tUserModel.updatedAt,
                  ),
                )));

        // act
        final result = await useCase(longEmailParams);

        // assert
        expect(result.isRight(), true);
        expect(result.fold((l) => null, (r) => r.user.email), longEmail);
        verify(mockAuthRepository.login(longEmail, tPassword));
      });

      test('should handle very long passwords', () async {
        // arrange
        final longPassword =
            'VeryLongPasswordThatExceedsNormalExpectations' * 10;
        final longPasswordParams =
            LoginParams(email: tEmail, password: longPassword);

        when(mockAuthRepository.login(tEmail, longPassword))
            .thenAnswer((_) async => Right(tLoginEntity));

        // act
        final result = await useCase(longPasswordParams);

        // assert
        expect(result.isRight(), true);
        verify(mockAuthRepository.login(tEmail, longPassword));
      });

      test('should handle unicode characters in credentials', () async {
        // arrange
        const unicodeEmail = 'tëst@éxämplé.com';
        const unicodePassword = 'pässwörd123ñ';
        const unicodeParams =
            LoginParams(email: unicodeEmail, password: unicodePassword);

        when(mockAuthRepository.login(unicodeEmail, unicodePassword))
            .thenAnswer((_) async => Right(LoginEntity(
                  token: tLoginEntity.token,
                  isTeacher: tLoginEntity.isTeacher,
                  user: UserModel(
                    id: tUserModel.id,
                    name: tUserModel.name,
                    email: unicodeEmail,
                    userLevel: tUserModel.userLevel,
                    userRole: tUserModel.userRole,
                    createdAt: tUserModel.createdAt,
                    updatedAt: tUserModel.updatedAt,
                  ),
                )));

        // act
        final result = await useCase(unicodeParams);

        // assert
        expect(result.isRight(), true);
        verify(mockAuthRepository.login(unicodeEmail, unicodePassword));
      });

      test('should handle null-like string values', () async {
        // arrange
        const nullLikeParams =
            LoginParams(email: 'null', password: 'undefined');

        when(mockAuthRepository.login('null', 'undefined')).thenAnswer(
            (_) async => Left(AuthFailure(message: 'Invalid credentials')));

        // act
        final result = await useCase(nullLikeParams);

        // assert
        expect(result.isLeft(), true);
        verify(mockAuthRepository.login('null', 'undefined'));
      });
    });

    group('Performance Tests', () {
      test('should complete login request within reasonable time', () async {
        // arrange
        when(mockAuthRepository.login(tEmail, tPassword)).thenAnswer((_) async {
          // Simulate network delay
          await Future.delayed(const Duration(milliseconds: 100));
          return Right(tLoginEntity);
        });

        // act
        final stopwatch = Stopwatch()..start();
        final result = await useCase(tParams);
        stopwatch.stop();

        // assert
        expect(result.isRight(), true);
        expect(stopwatch.elapsedMilliseconds,
            lessThan(1000)); // Should complete within 1 second
        verify(mockAuthRepository.login(tEmail, tPassword));
      });

      test('should handle timeout scenarios gracefully', () async {
        // arrange
        when(mockAuthRepository.login(tEmail, tPassword)).thenAnswer(
            (_) async => Left(NetworkFailure(message: 'Request timeout')));

        // act
        final result = await useCase(tParams);

        // assert
        expect(result, Left(NetworkFailure(message: 'Request timeout')));
        verify(mockAuthRepository.login(tEmail, tPassword));
      });
    });

    group('Multiple Calls', () {
      test('should handle multiple concurrent login attempts', () async {
        // arrange
        when(mockAuthRepository.login(tEmail, tPassword))
            .thenAnswer((_) async => Right(tLoginEntity));

        // act
        final futures = List.generate(5, (_) => useCase(tParams));
        final results = await Future.wait(futures);

        // assert
        for (final result in results) {
          expect(result, Right(tLoginEntity));
        }
        verify(mockAuthRepository.login(tEmail, tPassword)).called(5);
      });

      test('should handle mixed success and failure scenarios', () async {
        // arrange
        when(mockAuthRepository.login(tEmail, tPassword))
            .thenAnswer((_) async => Right(tLoginEntity));
        when(mockAuthRepository.login('invalid@email.com', tPassword))
            .thenAnswer(
                (_) async => Left(AuthFailure(message: 'Invalid credentials')));

        // act
        final validResult = await useCase(tParams);
        const invalidParams =
            LoginParams(email: 'invalid@email.com', password: tPassword);
        final invalidResult = await useCase(invalidParams);

        // assert
        expect(validResult, Right(tLoginEntity));
        expect(
            invalidResult, Left(AuthFailure(message: 'Invalid credentials')));
        verify(mockAuthRepository.login(tEmail, tPassword));
        verify(mockAuthRepository.login('invalid@email.com', tPassword));
      });
    });

    group('Error Message Validation', () {
      test('should preserve exact error messages from failures', () async {
        // arrange
        const customErrorMessage = 'Custom authentication error message';
        when(mockAuthRepository.login(tEmail, tPassword)).thenAnswer(
            (_) async => Left(AuthFailure(message: customErrorMessage)));

        // act
        final result = await useCase(tParams);

        // assert
        expect(result.isLeft(), true);
        expect(
          result.fold((failure) => failure.message, (_) => ''),
          customErrorMessage,
        );
        verify(mockAuthRepository.login(tEmail, tPassword));
      });

      test('should handle different failure types correctly', () async {
        // arrange & act & assert
        final failures = [
          NetworkFailure(message: 'Network error'),
          ServerFailure(message: 'Server error', statusCode: 500),
          AuthFailure(message: 'Auth error'),
          ValidationFailure(message: 'Validation error'),
          NotFoundFailure(message: 'Not found error'),
          UnexpectedFailure(message: 'Unexpected error'),
        ];

        for (final failure in failures) {
          when(mockAuthRepository.login(tEmail, tPassword))
              .thenAnswer((_) async => Left(failure));

          final result = await useCase(tParams);

          expect(result, Left(failure));
          expect(result.fold((f) => f.runtimeType, (_) => null),
              failure.runtimeType);
        }

        verify(mockAuthRepository.login(tEmail, tPassword))
            .called(failures.length);
      });
    });
  });
}
