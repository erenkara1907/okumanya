import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:okumanya/core/auth/auth_service.dart';
import 'package:okumanya/core/error/failures.dart';
import 'package:okumanya/features/auth/domain/entities/login_entity.dart';
import 'package:okumanya/features/auth/data/models/user_model.dart';
import 'package:okumanya/features/auth/domain/usecases/login_usecase.dart';
import 'package:okumanya/features/auth/presentation/bloc/login_bloc.dart';

import 'login_bloc_test.mocks.dart';

@GenerateMocks([LoginUseCase, AuthService])
void main() {
  late LoginBloc loginBloc;
  late MockLoginUseCase mockLoginUseCase;
  late MockAuthService mockAuthService;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockAuthService = MockAuthService();
    loginBloc = LoginBloc(mockLoginUseCase, mockAuthService);
  });

  tearDown(() {
    loginBloc.close();
  });

  group('LoginBloc', () {
    const tEmail = 'test@example.com';
    const tPassword = 'password123';

    final tUserModel = UserModel(
      id: 1,
      name: 'Test User',
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

    test('initial state is LoginState with initial status', () {
      expect(loginBloc.state, equals(LoginState()));
    });

    group('Login Event', () {
      blocTest<LoginBloc, LoginState>(
        'emits [loading, success] when login is successful',
        build: () {
          when(mockLoginUseCase(any))
              .thenAnswer((_) async => Right(tLoginEntity));
          when(mockAuthService.saveLoginData(
            token: anyNamed('token'),
            userId: anyNamed('userId'),
            isTeacher: anyNamed('isTeacher'),
          )).thenAnswer((_) async => {});

          return loginBloc;
        },
        act: (bloc) => bloc.add(Login(email: tEmail, password: tPassword)),
        expect: () => [
          LoginState().copyWith(status: LoginStatus.loading),
          LoginState().copyWith(
            status: LoginStatus.success,
            loginEntity: tLoginEntity,
          ),
        ],
      );

      blocTest<LoginBloc, LoginState>(
        'emits [loading, error] when login fails with network error',
        build: () {
          when(mockLoginUseCase(any)).thenAnswer((_) async =>
              Left(NetworkFailure(message: 'No internet connection')));

          return loginBloc;
        },
        act: (bloc) => bloc.add(Login(email: tEmail, password: tPassword)),
        expect: () => [
          LoginState().copyWith(status: LoginStatus.loading),
          LoginState().copyWith(
            status: LoginStatus.error,
            errorMessage: 'No internet connection',
          ),
        ],
      );

      blocTest<LoginBloc, LoginState>(
        'emits [loading, error] when login fails with auth error',
        build: () {
          when(mockLoginUseCase(any)).thenAnswer(
              (_) async => Left(AuthFailure(message: 'Invalid credentials')));

          return loginBloc;
        },
        act: (bloc) => bloc.add(Login(email: tEmail, password: tPassword)),
        expect: () => [
          LoginState().copyWith(status: LoginStatus.loading),
          LoginState().copyWith(
            status: LoginStatus.error,
            errorMessage: 'Invalid credentials',
          ),
        ],
      );

      blocTest<LoginBloc, LoginState>(
        'emits [loading, error] when storage fails after successful login',
        build: () {
          when(mockLoginUseCase(any))
              .thenAnswer((_) async => Right(tLoginEntity));
          when(mockAuthService.saveLoginData(
            token: anyNamed('token'),
            userId: anyNamed('userId'),
            isTeacher: anyNamed('isTeacher'),
          )).thenThrow(Exception('Storage error'));

          return loginBloc;
        },
        act: (bloc) => bloc.add(Login(email: tEmail, password: tPassword)),
        expect: () => [
          LoginState().copyWith(status: LoginStatus.loading),
          LoginState().copyWith(
            status: LoginStatus.error,
            errorMessage:
                'Oturum verileri kaydedilemedi: Exception: Storage error',
          ),
        ],
      );

      blocTest<LoginBloc, LoginState>(
        'calls AuthService.saveLoginData with correct parameters',
        build: () {
          when(mockLoginUseCase(any))
              .thenAnswer((_) async => Right(tLoginEntity));
          when(mockAuthService.saveLoginData(
            token: anyNamed('token'),
            userId: anyNamed('userId'),
            isTeacher: anyNamed('isTeacher'),
          )).thenAnswer((_) async => {});

          return loginBloc;
        },
        act: (bloc) => bloc.add(Login(email: tEmail, password: tPassword)),
        verify: (_) {
          verify(mockAuthService.saveLoginData(
            token: 'test_token_123',
            userId: '1',
            isTeacher: false,
          )).called(1);
        },
      );

      blocTest<LoginBloc, LoginState>(
        'calls LoginUseCase with correct parameters',
        build: () {
          when(mockLoginUseCase(any))
              .thenAnswer((_) async => Right(tLoginEntity));
          when(mockAuthService.saveLoginData(
            token: anyNamed('token'),
            userId: anyNamed('userId'),
            isTeacher: anyNamed('isTeacher'),
          )).thenAnswer((_) async => {});

          return loginBloc;
        },
        act: (bloc) => bloc.add(Login(email: tEmail, password: tPassword)),
        verify: (_) {
          verify(mockLoginUseCase(LoginParams(
            email: tEmail,
            password: tPassword,
          ))).called(1);
        },
      );
    });

    group('ObscureText Event', () {
      blocTest<LoginBloc, LoginState>(
        'toggles obscure text from true to false',
        build: () => loginBloc,
        seed: () => LoginState().copyWith(obscure: true),
        act: (bloc) => bloc.add(ObscureText()),
        expect: () => [
          LoginState().copyWith(obscure: false),
        ],
      );

      blocTest<LoginBloc, LoginState>(
        'toggles obscure text from false to true',
        build: () => loginBloc,
        seed: () => LoginState().copyWith(obscure: false),
        act: (bloc) => bloc.add(ObscureText()),
        expect: () => [
          LoginState().copyWith(obscure: true),
        ],
      );
    });

    group('Error Handling', () {
      blocTest<LoginBloc, LoginState>(
        'handles unexpected errors gracefully',
        build: () {
          when(mockLoginUseCase(any)).thenThrow(Exception('Unexpected error'));

          return loginBloc;
        },
        act: (bloc) => bloc.add(Login(email: tEmail, password: tPassword)),
        expect: () => [
          LoginState().copyWith(status: LoginStatus.loading),
          LoginState().copyWith(
            status: LoginStatus.error,
            errorMessage: 'Beklenmeyen hata: Exception: Unexpected error',
          ),
        ],
      );

      blocTest<LoginBloc, LoginState>(
        'handles server errors appropriately',
        build: () {
          when(mockLoginUseCase(any)).thenAnswer((_) async =>
              Left(ServerFailure(message: 'Server error', statusCode: 500)));

          return loginBloc;
        },
        act: (bloc) => bloc.add(Login(email: tEmail, password: tPassword)),
        expect: () => [
          LoginState().copyWith(status: LoginStatus.loading),
          LoginState().copyWith(
            status: LoginStatus.error,
            errorMessage: 'Server error',
          ),
        ],
      );

      blocTest<LoginBloc, LoginState>(
        'handles validation errors appropriately',
        build: () {
          when(mockLoginUseCase(any)).thenAnswer((_) async =>
              Left(ValidationFailure(message: 'Invalid email format')));

          return loginBloc;
        },
        act: (bloc) =>
            bloc.add(Login(email: 'invalid-email', password: tPassword)),
        expect: () => [
          LoginState().copyWith(status: LoginStatus.loading),
          LoginState().copyWith(
            status: LoginStatus.error,
            errorMessage: 'Invalid email format',
          ),
        ],
      );
    });

    group('State Management', () {
      test('state copyWith works correctly', () {
        final initialState = LoginState();
        final newState = initialState.copyWith(
          status: LoginStatus.loading,
          errorMessage: 'Test error',
        );

        expect(newState.status, LoginStatus.loading);
        expect(newState.errorMessage, 'Test error');
        expect(newState.obscure, initialState.obscure);
      });

      test('LoginState equality works correctly', () {
        final state1 = LoginState();
        final state2 = LoginState();
        final state3 = LoginState().copyWith(status: LoginStatus.loading);

        expect(state1, equals(state2));
        expect(state1, isNot(equals(state3)));
      });
    });

    group('Multiple Login Attempts', () {
      blocTest<LoginBloc, LoginState>(
        'handles multiple rapid login attempts correctly',
        build: () {
          when(mockLoginUseCase(any))
              .thenAnswer((_) async => Right(tLoginEntity));
          when(mockAuthService.saveLoginData(
            token: anyNamed('token'),
            userId: anyNamed('userId'),
            isTeacher: anyNamed('isTeacher'),
          )).thenAnswer((_) async => {});

          return loginBloc;
        },
        act: (bloc) {
          bloc.add(Login(email: tEmail, password: tPassword));
          bloc.add(Login(email: tEmail, password: tPassword));
          bloc.add(Login(email: tEmail, password: tPassword));
        },
        expect: () => [
          LoginState().copyWith(status: LoginStatus.loading),
          LoginState().copyWith(
            status: LoginStatus.success,
            loginEntity: tLoginEntity,
          ),
          LoginState().copyWith(status: LoginStatus.loading),
          LoginState().copyWith(
            status: LoginStatus.success,
            loginEntity: tLoginEntity,
          ),
          LoginState().copyWith(status: LoginStatus.loading),
          LoginState().copyWith(
            status: LoginStatus.success,
            loginEntity: tLoginEntity,
          ),
        ],
      );
    });

    group('Edge Cases', () {
      blocTest<LoginBloc, LoginState>(
        'handles empty email and password',
        build: () {
          when(mockLoginUseCase(any)).thenAnswer((_) async => Left(
              ValidationFailure(
                  message: 'Email and password cannot be empty')));

          return loginBloc;
        },
        act: (bloc) => bloc.add(Login(email: '', password: '')),
        expect: () => [
          LoginState().copyWith(status: LoginStatus.loading),
          LoginState().copyWith(
            status: LoginStatus.error,
            errorMessage: 'Email and password cannot be empty',
          ),
        ],
      );

      blocTest<LoginBloc, LoginState>(
        'handles special characters in credentials',
        build: () {
          when(mockLoginUseCase(any))
              .thenAnswer((_) async => Right(tLoginEntity));
          when(mockAuthService.saveLoginData(
            token: anyNamed('token'),
            userId: anyNamed('userId'),
            isTeacher: anyNamed('isTeacher'),
          )).thenAnswer((_) async => {});

          return loginBloc;
        },
        act: (bloc) => bloc.add(Login(
          email: 'test+special@example.com',
          password: 'P@ssw0rd!123#',
        )),
        expect: () => [
          LoginState().copyWith(status: LoginStatus.loading),
          LoginState().copyWith(
            status: LoginStatus.success,
            loginEntity: tLoginEntity,
          ),
        ],
      );
    });
  });
}
