import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/auth_user.dart';
import '../repositories/i_auth_repository.dart';

/// Use case for user login following Single Responsibility Principle
/// Handles only the login logic and business rules
class LoginUser implements UseCase<AuthUser, LoginUserParams> {
  final IAuthRepository repository;

  LoginUser(this.repository);

  @override
  Future<Either<Failure, AuthUser>> call(LoginUserParams params) async {
    // Business logic: Validate input parameters
    if (params.username.isEmpty) {
      return const Left(ValidationFailure(message: 'Username cannot be empty'));
    }
    
    if (params.password.isEmpty) {
      return const Left(ValidationFailure(message: 'Password cannot be empty'));
    }
    
    if (params.password.length < 6) {
      return const Left(ValidationFailure(message: 'Password must be at least 6 characters'));
    }

    // Delegate to repository
    return await repository.login(
      username: params.username,
      password: params.password,
      pushToken: params.pushToken,
      language: params.language,
    );
  }
}

/// Parameters for login use case following Single Responsibility
class LoginUserParams extends Equatable {
  final String username;
  final String password;
  final String pushToken;
  final String language;

  const LoginUserParams({
    required this.username,
    required this.password,
    required this.pushToken,
    required this.language,
  });

  @override
  List<Object> get props => [username, password, pushToken, language];
}