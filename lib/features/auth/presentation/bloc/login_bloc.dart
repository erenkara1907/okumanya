import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/login_usecase.dart';
import '../../domain/entities/login_entity.dart';
import '../../../../core/auth/auth_service.dart';

part 'login_event.dart';
part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;
  final AuthService _authService;

  LoginBloc(this._loginUseCase, this._authService) : super(LoginState()) {
    on<Login>(_login);
    on<ObscureText>(_obscure);
  }

  _login(Login event, Emitter<LoginState> emit) async {
    print('🔄 LoginBloc: Starting login process for ${event.email}');
    log('🔄 LoginBloc: Starting login process for ${event.email}',
        name: 'LoginBloc');
    emit(state.copyWith(status: LoginStatus.loading));

    try {
      print('📡 LoginBloc: Calling login use case');
      log('📡 LoginBloc: Calling login use case', name: 'LoginBloc');
      final response = await _loginUseCase(LoginParams(
        email: event.email,
        password: event.password,
      ));

      print('🔍 LoginBloc: Processing response');
      log('🔍 LoginBloc: Processing response', name: 'LoginBloc');

      await response.fold(
        (failure) async {
          print('❌ LoginBloc: Login failed with failure: ${failure.message}');
          log('❌ LoginBloc: Login failed with failure: ${failure.message}',
              name: 'LoginBloc');
          if (!emit.isDone) {
            emit(state.copyWith(
              status: LoginStatus.error,
              errorMessage: failure.message,
            ));
          }
        },
        (loginEntity) async {
          print(
              '✅ LoginBloc: Login successful for user ${loginEntity.user.name}');
          log('✅ LoginBloc: Login successful for user ${loginEntity.user.name}',
              name: 'LoginBloc');

          try {
            // Save login data using AuthService
            print('💾 LoginBloc: Saving login data to secure storage');
            log('💾 LoginBloc: Saving login data to secure storage',
                name: 'LoginBloc');
            await _authService.saveLoginData(
              token: loginEntity.token,
              userId: loginEntity.user.id.toString(),
              isTeacher: loginEntity.isTeacher,
            );

            print(
                '🔄 LoginBloc: About to emit success status. emit.isDone: ${emit.isDone}');
            log('🔄 LoginBloc: About to emit success status. emit.isDone: ${emit.isDone}',
                name: 'LoginBloc');

            if (!emit.isDone) {
              emit(state.copyWith(
                loginEntity: loginEntity,
                status: LoginStatus.success,
              ));

              print('✅ LoginBloc: Success status emitted successfully');
              log('✅ LoginBloc: Success status emitted successfully',
                  name: 'LoginBloc');
            } else {
              print('⚠️ LoginBloc: Cannot emit success, handler completed');
              log('⚠️ LoginBloc: Cannot emit success, handler completed',
                  name: 'LoginBloc');
            }
          } catch (storageError) {
            print('❌ LoginBloc: Failed to save login data: $storageError');
            log('❌ LoginBloc: Failed to save login data: $storageError',
                name: 'LoginBloc');
            if (!emit.isDone) {
              emit(state.copyWith(
                status: LoginStatus.error,
                errorMessage: 'Oturum verileri kaydedilemedi: $storageError',
              ));
            }
          }
        },
      );
    } catch (e) {
      log('❌ LoginBloc: Unexpected error during login: $e', name: 'LoginBloc');
      if (!emit.isDone) {
        emit(state.copyWith(
          status: LoginStatus.error,
          errorMessage: 'Beklenmeyen hata: $e',
        ));
      }
    }
  }

  _obscure(ObscureText event, Emitter<LoginState> emit) async {
    bool obs = !state.obscure;
    emit(
      state.copyWith(
        obscure: obs,
      ),
    );
  }
}
