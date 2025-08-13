import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../../data/models/profile_model.dart';
import '../../../../data/models/user_model.dart';
import '../../../../domain/repository/auth_repository.dart';
import '../../../../shared/hive/hive_constants.dart';
import '../../../../shared/config/app_config.dart';
import '../../../../shared/storage/secure_storage_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;

  LoginBloc(this._authRepository) : super(LoginState()) {
    on<Login>(_login);
    on<ObscureText>(_obscure);
  }

  _login(Login event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.loading));
    final response = await _authRepository.login(
      '${event.user}@${AppConfig.emailDomain}',
      event.pass,
      event.pushToken,
      ''
    );

    await response.fold(
      (l) async {
        if (!emit.isDone) {
          emit(state.copyWith(
            status: LoginStatus.error,
            errorMessage: l.message ?? 'Giriş işlemi başarısız',
          ));
        }
      },
      (r) async {
        // Save user data to Hive
        Hive.box(HiveBoxConstants.user).put('user', r);
        
        // Save token and user ID to secure storage
        if (r.token != null && r.token!.isNotEmpty) {
          await SecureStorageService.saveAuthToken(r.token!);
        }
        
        if (r.id != null && r.id!.isNotEmpty) {
          await SecureStorageService.saveUserId(r.id!);
        }
        
        if (!emit.isDone) {
          emit(state.copyWith(
            userModel: r,
            status: LoginStatus.success,
          ));
        }

        // final responseProfile = await authRepository.getProfile();
        // await responseProfile.fold(
        //   (l2) async {
        //     if (!emit.isDone) {
        //       emit(state.copyWith(
        //         status: LoginStatus.error,
        //         errorMessage: l2.message,
        //       ));
        //     }
        //   },
        //   (r2) async {
        //     if (!emit.isDone) {
        //       Hive.box(HiveBoxConstants.profile).put('profile', r2);
        //       emit(state.copyWith(
        //         profileModel: r2,
        //         status: LoginStatus.success,
        //       ));
        //     }
        //   },
        // );
      },
    );
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