import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/login_entity.dart';
import '../repositories/auth_repository.dart';

class LoginParams {
  final String email;
  final String password;

  const LoginParams({
    required this.email,
    required this.password,
  });
}

@injectable
class LoginUseCase implements UseCase<LoginEntity, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, LoginEntity>> call(LoginParams params) {
    log('🎯 LoginUseCase: Executing login for ${params.email}',
        name: 'LoginUseCase');
    return repository.login(params.email, params.password);
  }
}
