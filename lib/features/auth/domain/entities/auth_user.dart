import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user.freezed.dart';

/// Domain entity for authenticated user following Single Responsibility Principle
/// Represents only the authentication-related user data
@freezed
class AuthUser with _$AuthUser {
  const factory AuthUser({
    required String id,
    required String username,
    required String email,
    required String token,
    required String refreshToken,
    required DateTime loginTime,
    required bool isEmailVerified,
    @Default(false) bool rememberMe,
  }) = _AuthUser;
  
  const AuthUser._();
  
  /// Business logic method - checks if token is expired
  bool get isTokenExpired {
    final now = DateTime.now();
    final tokenAge = now.difference(loginTime);
    return tokenAge.inHours > 24; // Token expires after 24 hours
  }
  
  /// Business logic method - checks if user needs refresh
  bool get needsRefresh {
    final now = DateTime.now();
    final tokenAge = now.difference(loginTime);
    return tokenAge.inHours > 12; // Refresh after 12 hours
  }
}