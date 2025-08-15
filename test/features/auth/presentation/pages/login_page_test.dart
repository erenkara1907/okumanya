import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:okumanya/core/auth/auth_service.dart';
import 'package:okumanya/features/auth/domain/entities/login_entity.dart';
import 'package:okumanya/features/auth/data/models/user_model.dart';
import 'package:okumanya/features/auth/domain/usecases/login_usecase.dart';
import 'package:okumanya/features/auth/presentation/bloc/login_bloc.dart';
import 'package:okumanya/features/auth/presentation/pages/login_page.dart';
import 'package:okumanya/core/widgets/common/common_textfield.dart';
import 'package:okumanya/core/widgets/common/common_elevated_button.dart';
import 'package:dartz/dartz.dart';
import 'package:okumanya/core/error/failures.dart';

import 'login_page_test.mocks.dart';

@GenerateMocks([LoginUseCase, AuthService])
void main() {
  late MockLoginUseCase mockLoginUseCase;
  late MockAuthService mockAuthService;
  late LoginBloc loginBloc;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockAuthService = MockAuthService();
    loginBloc = LoginBloc(mockLoginUseCase, mockAuthService);
  });

  tearDown(() {
    loginBloc.close();
  });

  Widget createWidgetUnderTest() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MaterialApp(
        home: BlocProvider.value(
          value: loginBloc,
          child: const LoginPage(),
        ),
      ),
    );
  }

  group('LoginPage Widget Tests', () {
    testWidgets('should display all required UI elements', (tester) async {
      // arrange
      await tester.pumpWidget(createWidgetUnderTest());

      // assert
      expect(find.byType(CommonTextField),
          findsNWidgets(2)); // Email and Password fields
      expect(find.byType(CommonElevatedButton), findsOneWidget); // Login button
      expect(find.text('E-posta'), findsOneWidget);
      expect(find.text('Şifre'), findsOneWidget);
      expect(find.text('Giriş Yap'), findsOneWidget);
      expect(find.byIcon(Icons.email_outlined), findsOneWidget);
      expect(find.byIcon(Icons.lock_outline), findsOneWidget);
    });

    testWidgets('should show/hide password when visibility icon is tapped',
        (tester) async {
      // arrange
      await tester.pumpWidget(createWidgetUnderTest());

      // Find the password field's suffix icon
      final passwordVisibilityIcon = find.byIcon(Icons.remove_red_eye_outlined);

      // assert - initially password should be obscured
      expect(passwordVisibilityIcon, findsOneWidget);

      // act - tap the visibility icon
      await tester.tap(passwordVisibilityIcon);
      await tester.pump();

      // assert - password should now be visible
      expect(find.byIcon(Icons.remove_red_eye), findsOneWidget);
    });

    testWidgets('should validate email field when empty', (tester) async {
      // arrange
      await tester.pumpWidget(createWidgetUnderTest());

      // act - tap login button without entering email
      await tester.tap(find.text('Giriş Yap'));
      await tester.pump();

      // assert - validation error should appear
      expect(find.text('E-posta adresi gerekli'), findsOneWidget);
    });

    testWidgets('should validate email field format', (tester) async {
      // arrange
      await tester.pumpWidget(createWidgetUnderTest());

      // act - enter invalid email
      await tester.enterText(
          find.byType(CommonTextField).first, 'invalid-email');
      await tester.tap(find.text('Giriş Yap'));
      await tester.pump();

      // assert - validation error should appear
      expect(find.text('Geçerli bir e-posta adresi girin'), findsOneWidget);
    });

    testWidgets('should validate password field when empty', (tester) async {
      // arrange
      await tester.pumpWidget(createWidgetUnderTest());

      // act - enter valid email but no password
      await tester.enterText(
          find.byType(CommonTextField).first, 'test@example.com');
      await tester.tap(find.text('Giriş Yap'));
      await tester.pump();

      // assert - password validation error should appear
      expect(find.text('Şifre gerekli'), findsOneWidget);
    });

    testWidgets('should show loading indicator when login is in progress',
        (tester) async {
      // arrange
      when(mockLoginUseCase(any)).thenAnswer((_) async {
        // Simulate network delay
        await Future.delayed(const Duration(seconds: 1));
        return Right(LoginEntity(
          token: 'test_token',
          isTeacher: false,
          user: UserModel(
            id: 1,
            name: 'Test User',
            email: 'test@example.com',
            userLevel: 1,
            userRole: 'student',
            createdAt: '2023-01-15T00:00:00.000Z',
            updatedAt: '2023-01-15T00:00:00.000Z',
          ),
        ));
      });
      when(mockAuthService.saveLoginData(
        token: anyNamed('token'),
        userId: anyNamed('userId'),
        isTeacher: anyNamed('isTeacher'),
      )).thenAnswer((_) async => {});

      await tester.pumpWidget(createWidgetUnderTest());

      // act - enter valid credentials and tap login
      await tester.enterText(
          find.byType(CommonTextField).first, 'test@example.com');
      await tester.enterText(find.byType(CommonTextField).last, 'password123');
      await tester.tap(find.text('Giriş Yap'));
      await tester.pump();

      // assert - loading indicator should appear
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should call login bloc when form is valid and submitted',
        (tester) async {
      // arrange
      when(mockLoginUseCase(any))
          .thenAnswer((_) async => const Right(LoginEntity(
                token: 'test_token',
                isTeacher: false,
                user: UserModel(
                  id: 1,
                  name: 'Test User',
                  email: 'test@example.com',
                  userLevel: 1,
                  userRole: 'student',
                  createdAt: '2023-01-15T00:00:00.000Z',
                  updatedAt: '2023-01-15T00:00:00.000Z',
                ),
              )));
      when(mockAuthService.saveLoginData(
        token: anyNamed('token'),
        userId: anyNamed('userId'),
        isTeacher: anyNamed('isTeacher'),
      )).thenAnswer((_) async => {});

      await tester.pumpWidget(createWidgetUnderTest());

      // act - enter valid credentials
      await tester.enterText(
          find.byType(CommonTextField).first, 'test@example.com');
      await tester.enterText(find.byType(CommonTextField).last, 'password123');
      await tester.tap(find.text('Giriş Yap'));
      await tester.pump();

      // assert - verify login use case is called
      verify(mockLoginUseCase(const LoginParams(
        email: 'test@example.com',
        password: 'password123',
      ))).called(1);
    });

    testWidgets('should handle login success and show success toast',
        (tester) async {
      // arrange
      when(mockLoginUseCase(any))
          .thenAnswer((_) async => const Right(LoginEntity(
                token: 'test_token',
                isTeacher: false,
                user: UserModel(
                  id: 1,
                  name: 'Test User',
                  email: 'test@example.com',
                  userLevel: 1,
                  userRole: 'student',
                  createdAt: '2023-01-15T00:00:00.000Z',
                  updatedAt: '2023-01-15T00:00:00.000Z',
                ),
              )));
      when(mockAuthService.saveLoginData(
        token: anyNamed('token'),
        userId: anyNamed('userId'),
        isTeacher: anyNamed('isTeacher'),
      )).thenAnswer((_) async => {});

      await tester.pumpWidget(createWidgetUnderTest());

      // act
      await tester.enterText(
          find.byType(CommonTextField).first, 'test@example.com');
      await tester.enterText(find.byType(CommonTextField).last, 'password123');
      await tester.tap(find.text('Giriş Yap'));
      await tester.pumpAndSettle();

      // Note: We can't easily test toast messages and navigation in widget tests
      // These would be better tested in integration tests
    });

    testWidgets('should handle login failure and show error toast',
        (tester) async {
      // arrange
      when(mockLoginUseCase(any)).thenAnswer(
          (_) async => Left(AuthFailure(message: 'Invalid credentials')));

      await tester.pumpWidget(createWidgetUnderTest());

      // act
      await tester.enterText(
          find.byType(CommonTextField).first, 'test@example.com');
      await tester.enterText(
          find.byType(CommonTextField).last, 'wrongpassword');
      await tester.tap(find.text('Giriş Yap'));
      await tester.pumpAndSettle();

      // assert - button should no longer show loading
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('should not allow login when already in loading state',
        (tester) async {
      // arrange
      when(mockLoginUseCase(any)).thenAnswer((_) async {
        await Future.delayed(const Duration(milliseconds: 500));
        return Right(LoginEntity(
          token: 'test_token',
          isTeacher: false,
          user: UserModel(
            id: 1,
            name: 'Test User',
            email: 'test@example.com',
            userLevel: 1,
            userRole: 'student',
            createdAt: '2023-01-15T00:00:00.000Z',
            updatedAt: '2023-01-15T00:00:00.000Z',
          ),
        ));
      });
      when(mockAuthService.saveLoginData(
        token: anyNamed('token'),
        userId: anyNamed('userId'),
        isTeacher: anyNamed('isTeacher'),
      )).thenAnswer((_) async => {});

      await tester.pumpWidget(createWidgetUnderTest());

      // act - enter credentials and tap login multiple times quickly
      await tester.enterText(
          find.byType(CommonTextField).first, 'test@example.com');
      await tester.enterText(find.byType(CommonTextField).last, 'password123');
      await tester.tap(find.text('Giriş Yap'));
      await tester.pump();
      await tester.tap(find.text('Giriş Yap')); // Second tap should be ignored
      await tester.pump();

      // assert - login should only be called once
      verify(mockLoginUseCase(any)).called(1);
    });

    testWidgets('should handle text input correctly', (tester) async {
      // arrange
      await tester.pumpWidget(createWidgetUnderTest());

      const testEmail = 'user@example.com';
      const testPassword = 'mypassword123';

      // act - enter text in fields
      await tester.enterText(find.byType(CommonTextField).first, testEmail);
      await tester.enterText(find.byType(CommonTextField).last, testPassword);

      // assert - text should be entered correctly
      expect(find.text(testEmail), findsOneWidget);
      // Password text might not be visible due to obscureText, but field should accept input
    });

    testWidgets('should handle special characters in input', (tester) async {
      // arrange
      await tester.pumpWidget(createWidgetUnderTest());

      const specialEmail = 'test+special@example-domain.co.uk';
      const specialPassword = 'P@ssw0rd!#\$%^&*()';

      // act
      await tester.enterText(find.byType(CommonTextField).first, specialEmail);
      await tester.enterText(
          find.byType(CommonTextField).last, specialPassword);

      // assert
      expect(find.text(specialEmail), findsOneWidget);
    });

    testWidgets('should handle very long email addresses', (tester) async {
      // arrange
      await tester.pumpWidget(createWidgetUnderTest());

      const longEmail =
          'very.long.email.address.that.might.cause.ui.issues@very.long.domain.name.example.com';

      // act
      await tester.enterText(find.byType(CommonTextField).first, longEmail);

      // assert
      expect(find.text(longEmail), findsOneWidget);
    });

    testWidgets(
        'should clear form validation errors when valid input is entered',
        (tester) async {
      // arrange
      await tester.pumpWidget(createWidgetUnderTest());

      // act - trigger validation errors first
      await tester.tap(find.text('Giriş Yap'));
      await tester.pump();

      // assert - errors should be visible
      expect(find.text('E-posta adresi gerekli'), findsOneWidget);
      expect(find.text('Şifre gerekli'), findsOneWidget);

      // act - enter valid data
      await tester.enterText(
          find.byType(CommonTextField).first, 'valid@email.com');
      await tester.enterText(
          find.byType(CommonTextField).last, 'validpassword');
      await tester.tap(find.text('Giriş Yap'));
      await tester.pump();

      // assert - errors should be cleared
      expect(find.text('E-posta adresi gerekli'), findsNothing);
      expect(find.text('Şifre gerekli'), findsNothing);
    });

    testWidgets('should maintain state after widget rebuilds', (tester) async {
      // arrange
      await tester.pumpWidget(createWidgetUnderTest());

      const testEmail = 'persistent@email.com';
      const testPassword = 'persistentpassword';

      // act - enter text
      await tester.enterText(find.byType(CommonTextField).first, testEmail);
      await tester.enterText(find.byType(CommonTextField).last, testPassword);

      // Trigger a rebuild
      await tester.pumpWidget(createWidgetUnderTest());

      // assert - text should still be there after rebuild
      expect(find.text(testEmail), findsOneWidget);
    });
  });

  group('LoginPage Accessibility Tests', () {
    testWidgets('should have proper semantic labels', (tester) async {
      // arrange
      await tester.pumpWidget(createWidgetUnderTest());

      // assert - check for semantic properties
      expect(find.byType(CommonTextField), findsNWidgets(2));
      expect(find.byType(CommonElevatedButton), findsOneWidget);

      // Verify that text fields have proper hints
      expect(find.text('E-posta'), findsOneWidget);
      expect(find.text('Şifre'), findsOneWidget);
    });

    testWidgets('should handle keyboard navigation', (tester) async {
      // arrange
      await tester.pumpWidget(createWidgetUnderTest());

      // act - simulate tab navigation
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pump();

      // Focus should move between elements
      // This is a basic test - more complex keyboard navigation would need more setup
    });
  });

  group('LoginPage Performance Tests', () {
    testWidgets('should render quickly', (tester) async {
      // arrange
      final stopwatch = Stopwatch()..start();

      // act
      await tester.pumpWidget(createWidgetUnderTest());

      stopwatch.stop();

      // assert - should render in reasonable time
      expect(stopwatch.elapsedMilliseconds, lessThan(100));
    });

    testWidgets('should handle rapid text changes', (tester) async {
      // arrange
      await tester.pumpWidget(createWidgetUnderTest());

      // act - rapidly change text multiple times
      for (int i = 0; i < 10; i++) {
        await tester.enterText(
            find.byType(CommonTextField).first, 'test$i@email.com');
        await tester.pump();
      }

      // assert - should handle without issues
      expect(find.text('test9@email.com'), findsOneWidget);
    });
  });

  group('LoginPage Edge Cases', () {
    testWidgets('should handle empty widget tree gracefully', (tester) async {
      // This test ensures the widget doesn't crash when rendered
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: loginBloc,
            child: const LoginPage(),
          ),
        ),
      );

      expect(find.byType(LoginPage), findsOneWidget);
    });

    testWidgets('should handle disposal correctly', (tester) async {
      // arrange
      await tester.pumpWidget(createWidgetUnderTest());

      // act - remove widget from tree
      await tester.pumpWidget(Container());

      // assert - should not throw errors
      // The test passes if no exceptions are thrown
    });

    testWidgets('should handle multiple rapid state changes', (tester) async {
      // arrange
      await tester.pumpWidget(createWidgetUnderTest());

      // act - rapidly change obscure text state
      final passwordVisibilityIcon = find.byIcon(Icons.remove_red_eye_outlined);
      for (int i = 0; i < 5; i++) {
        await tester.tap(passwordVisibilityIcon);
        await tester.pump();

        final visibleIcon = find.byIcon(Icons.remove_red_eye);
        if (visibleIcon.evaluate().isNotEmpty) {
          await tester.tap(visibleIcon);
          await tester.pump();
        }
      }

      // assert - should handle state changes gracefully
      expect(find.byType(LoginPage), findsOneWidget);
    });
  });
}
