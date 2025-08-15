import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/i_auth_repository.dart';

/// Use case for user logout following Single Responsibility Principle
/// Handles only the logout logic and cleanup
class LogoutUser implements UseCase<void, NoParams> {
  final IAuthRepository repository;

  LogoutUser(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.logout();
  }
}
