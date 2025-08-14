import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/auth_user.dart';
import '../repositories/i_auth_repository.dart';

/// Use case for getting current authenticated user
/// Following Single Responsibility Principle - only handles current user retrieval
class GetCurrentUser implements UseCase<AuthUser?, NoParams> {
  final IAuthRepository repository;

  GetCurrentUser(this.repository);

  @override
  Future<Either<Failure, AuthUser?>> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}