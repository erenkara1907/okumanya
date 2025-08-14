import '../models/auth_user_model.dart';
import '../models/login_request_model.dart';

/// Interface for auth remote data source following Interface Segregation Principle
/// Defines only the network-related auth operations
abstract class IAuthRemoteDataSource {
  /// Authenticates user with server
  Future<AuthUserModel> login(LoginRequestModel request);
  
  /// Logs out user from server
  Future<void> logout(String token);
  
  /// Refreshes user token
  Future<AuthUserModel> refreshToken(String refreshToken);
  
  /// Validates token with server
  Future<bool> validateToken(String token);
}

/// Interface for auth local data source following Interface Segregation Principle  
/// Defines only the local storage-related auth operations
abstract class IAuthLocalDataSource {
  /// Saves user data locally
  Future<void> saveAuthUser(AuthUserModel user);
  
  /// Gets saved user data
  Future<AuthUserModel?> getAuthUser();
  
  /// Clears saved user data
  Future<void> clearAuthUser();
  
  /// Checks if user is logged in locally
  Future<bool> isUserLoggedIn();
}