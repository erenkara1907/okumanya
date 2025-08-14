import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/auth_user.dart';
import '../entities/user_profile.dart';

/// Interface for authentication repository following Interface Segregation Principle
/// Separates authentication from profile management concerns
abstract class IAuthRepository {
  Future<Either<Failure, AuthUser>> login({
    required String username,
    required String password,
    required String pushToken,
    required String language,
  });
  
  Future<Either<Failure, void>> logout();
  
  Future<Either<Failure, bool>> isUserLoggedIn();
  
  Future<Either<Failure, AuthUser?>> getCurrentUser();
}

/// Separate interface for profile operations to follow Interface Segregation
abstract class IProfileRepository {
  Future<Either<Failure, UserProfile>> getProfile();
  
  Future<Either<Failure, UserProfile>> updateProfile(UserProfile profile);
  
  Future<Either<Failure, void>> deleteProfile();
}