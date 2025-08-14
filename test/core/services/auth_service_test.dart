import 'package:flutter_test/flutter_test.dart';
import 'package:okumanya/core/auth/auth_service.dart';

void main() {
  late AuthService authService;

  setUp(() {
    authService = AuthService();
  });

  group('AuthService', () {
    test('should create AuthService instance successfully', () {
      // arrange & act
      final service = AuthService();

      // assert
      expect(service, isNotNull);
      expect(service, isA<AuthService>());
    });

    test('should have required methods available', () {
      // arrange
      final service = AuthService();

      // assert
      expect(service.saveLoginData, isA<Function>());
      expect(service.isLoggedIn, isA<Function>());
      expect(service.clearLoginData, isA<Function>());
      expect(service.getCurrentToken, isA<Function>());
      expect(service.getCurrentUserId, isA<Function>());
      expect(service.isTeacher, isA<Function>());
    });

    test('should be instantiable and expose proper API', () {
      // This test ensures the AuthService class is properly structured
      expect(authService, isA<AuthService>());
      
      // Test that methods exist (without calling them)
      expect(authService.toString(), contains('AuthService'));
    });
  });
}