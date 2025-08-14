import 'package:injectable/injectable.dart';
import '../../shared/storage/secure_storage_service.dart';

@lazySingleton
class AuthService {
  
  /// Check if user is logged in (has valid token)
  Future<bool> isLoggedIn() async {
    return await SecureStorageService.hasAuthToken();
  }

  /// Get current auth token
  Future<String?> getAuthToken() async {
    return await SecureStorageService.getAuthToken();
  }

  /// Save login data after successful login
  Future<void> saveLoginData({
    required String token,
    required String userId,
    bool isTeacher = false,
  }) async {
    await SecureStorageService.saveAuthToken(token);
    await SecureStorageService.saveUserId(userId);
    await SecureStorageService.saveIsTeacher(isTeacher);
    
    // Save additional user info if needed
    // You can extend this to save more user data
  }

  /// Clear all login data
  Future<void> clearLoginData() async {
    await SecureStorageService.clearAuthData();
  }

  /// Get current token
  Future<String?> getCurrentToken() async {
    return await SecureStorageService.getAuthToken();
  }

  /// Get current user ID
  Future<String?> getCurrentUserId() async {
    return await SecureStorageService.getUserId();
  }

  /// Check if user is teacher
  Future<bool> isTeacher() async {
    return await SecureStorageService.getIsTeacher();
  }

  /// Logout user by clearing all auth data
  Future<void> logout() async {
    await SecureStorageService.clearAuthData();
  }

  /// Validate token (you can extend this with actual API validation)
  Future<bool> validateToken() async {
    final token = await getAuthToken();
    if (token == null || token.isEmpty) {
      return false;
    }

    // Here you can add actual token validation logic
    // For now, we assume if token exists, it's valid
    // In a real app, you'd make an API call to validate
    
    try {
      // You can decode JWT token and check expiry
      // Or make a simple API call to validate token
      return true;
    } catch (e) {
      // If token is invalid, clear it
      await logout();
      return false;
    }
  }
}