# Okumanya Test Suite Documentation

Bu dosya, Okumanya Flutter uygulaması için kapsamlı test suite'ini açıklar.

## 📋 Test Yapısı Genel Bakış

Proje, Clean Architecture prensiplerine uygun olarak düzenlenmiş kapsamlı testlere sahiptir:

```
test/
├── core/
│   └── services/
│       └── auth_service_test.dart
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── auth_remote_data_source_test.dart
│   │   │   └── repositories/
│   │   │       └── auth_repository_test.dart (mevcut)
│   │   ├── domain/
│   │   │   └── usecases/
│   │   │       └── login_usecase_test.dart
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   └── login_bloc_test.dart
│   │       └── pages/
│   │           └── login_page_test.dart
│   ├── books/
│   │   ├── data/ (mevcut testler)
│   │   ├── domain/ (mevcut testler)
│   │   └── presentation/ (mevcut testler)
│   ├── home/
│   │   └── presentation/
│   │       └── bloc/
│   │           ├── home_bloc_test.dart
│   │           └── reading_bloc_test.dart
│   └── profile/
│       └── presentation/
│           └── bloc/
│               └── profile_bloc_test.dart
├── integration_test/
│   └── app_integration_test.dart
├── unit/ (enhanced testler)
└── widget_test.dart
```

## 🧪 Test Türleri

### 1. Unit Tests
**Konum:** `test/features/*/domain/usecases/`, `test/core/services/`

- **Login UseCase Test:** Giriş iş mantığını test eder
- **Auth Service Test:** Authentication servis işlevlerini test eder
- Tüm use case'lerin doğru çalışmasını doğrular
- Error handling ve edge case'leri kapsar

### 2. BLoC Tests
**Konum:** `test/features/*/presentation/bloc/`

#### LoginBloc Tests (`login_bloc_test.dart`)
- ✅ Başarılı login senaryosu
- ✅ Network hatası durumu
- ✅ Authentication hatası durumu
- ✅ Storage hatası durumu
- ✅ Password visibility toggle
- ✅ Multiple login attempts
- ✅ Edge cases ve error handling

#### HomeBloc Tests (`home_bloc_test.dart`)
- ✅ Home data loading
- ✅ Data refresh işlemleri
- ✅ Weekly goal güncelleme
- ✅ Performance testleri
- ✅ Concurrent operations

#### ReadingBloc Tests (`reading_bloc_test.dart`)
- ✅ Reading modal açma/kapama
- ✅ Sayfa navigasyonu (next/previous/goto)
- ✅ Large dataset handling
- ✅ Rapid navigation testleri
- ✅ Edge cases

#### ProfileBloc Tests (`profile_bloc_test.dart`)
- ✅ Profile loading ve güncelleme
- ✅ Statistics loading
- ✅ Combined operations
- ✅ Performance optimizations
- ✅ Error handling

### 3. Data Layer Tests
**Konum:** `test/features/*/data/`

#### AuthRemoteDataSource Tests (`auth_remote_data_source_test.dart`)
- ✅ HTTP POST request testleri
- ✅ Success response handling (200)
- ✅ Authentication errors (401)
- ✅ Not found errors (404)
- ✅ Server errors (500)
- ✅ Network connectivity issues
- ✅ Timeout scenarios
- ✅ JSON parsing errors
- ✅ Special characters ve unicode support
- ✅ Large response payloads
- ✅ Malformed responses

### 4. Widget Tests
**Konum:** `test/features/*/presentation/pages/`

#### LoginPage Tests (`login_page_test.dart`)
- ✅ UI element görünürlüğü
- ✅ Form validation
- ✅ Password visibility toggle
- ✅ Loading states
- ✅ Success/error handling
- ✅ Text input işlemleri
- ✅ Accessibility features
- ✅ Performance testleri
- ✅ Edge cases

### 5. Integration Tests
**Konum:** `test/integration_test/`

#### App Integration Tests (`app_integration_test.dart`)
- ✅ Complete app flow
- ✅ Login flow end-to-end
- ✅ Password visibility integration
- ✅ App launch performance
- ✅ Device rotation handling
- ✅ Memory stress tests
- ✅ Network connectivity simulation
- ✅ Accessibility features
- ✅ Localization support
- ✅ State persistence
- ✅ Error handling scenarios

## 🚀 Test Çalıştırma

### Tüm Unit ve Widget Testleri
```bash
flutter test
```

### Specific Test Dosyası
```bash
flutter test test/features/auth/presentation/bloc/login_bloc_test.dart
```

### Integration Testleri
```bash
flutter test integration_test/app_integration_test.dart
```

### Test Coverage
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

## 🎯 Test Coverage Hedefleri

- **Unit Tests:** >95% code coverage
- **BLoC Tests:** 100% state ve event coverage
- **Widget Tests:** Tüm user interactions
- **Integration Tests:** Critical user journeys

## 📊 Test Metrikleri

### Performans Benchmarks
- **App Launch:** <10 seconds
- **Login Process:** <5 seconds
- **Widget Render:** <100ms
- **BLoC Operations:** <50ms
- **Data Operations:** <500ms

### Reliability Metrics
- **Test Success Rate:** >99%
- **Flaky Test Rate:** <1%
- **Test Execution Time:** <2 minutes (tüm testler)

## 🔧 Mock ve Test Utilities

### Mock Objects
- `MockLoginUseCase` - Login business logic mocking
- `MockAuthService` - Authentication service mocking
- `MockDio` - Network requests mocking
- `MockSecureStorageService` - Storage operations mocking

### Test Helpers
- **BLoC Test Setup:** Common BLoC test configurations
- **Widget Test Helpers:** Reusable widget test utilities
- **Integration Test Utils:** End-to-end test helpers

## 📝 Test Yazma Rehberi

### Unit Test Örneği
```dart
group('LoginUseCase', () {
  test('should return LoginEntity when repository call is successful', () async {
    // arrange
    when(mockAuthRepository.login(tEmail, tPassword))
        .thenAnswer((_) async => Right(tLoginEntity));

    // act
    final result = await useCase(tParams);

    // assert
    expect(result, Right(tLoginEntity));
    verify(mockAuthRepository.login(tEmail, tPassword));
  });
});
```

### BLoC Test Örneği
```dart
blocTest<LoginBloc, LoginState>(
  'emits [loading, success] when login is successful',
  build: () => loginBloc,
  act: (bloc) => bloc.add(Login(email: tEmail, password: tPassword)),
  expect: () => [
    LoginState().copyWith(status: LoginStatus.loading),
    LoginState().copyWith(status: LoginStatus.success, loginEntity: tLoginEntity),
  ],
);
```

### Widget Test Örneği
```dart
testWidgets('should display all required UI elements', (tester) async {
  // arrange
  await tester.pumpWidget(createWidgetUnderTest());

  // assert
  expect(find.byType(CommonTextField), findsNWidgets(2));
  expect(find.text('Giriş Yap'), findsOneWidget);
});
```

## 🐛 Test Debugging

### Test Failure Debugging
1. **Verbose Output:** `flutter test --verbose`
2. **Specific Test:** Tek test çalıştırma
3. **Debug Mode:** IDE debugger kullanımı
4. **Print Statements:** Test içinde debug çıktıları

### Common Issues
- **State Management:** BLoC state transitions
- **Async Operations:** Future/Stream handling
- **Widget Tree:** Widget hierarchy issues
- **Mock Setup:** Incorrect mock configurations

## 📈 Continuous Integration

### CI/CD Pipeline
```yaml
# Test stage example
test:
  stage: test
  script:
    - flutter test --coverage
    - flutter test integration_test/
  artifacts:
    reports:
      coverage_report:
        coverage_format: cobertura
        path: coverage/lcov.info
```

## 🔮 Gelecek İyileştirmeler

### Planlanan Test Geliştirmeleri
- **Golden Tests:** UI consistency testleri
- **Performance Profiling:** Detaylı performance analysis
- **Visual Regression Tests:** UI değişiklik tespiti
- **A11y Tests:** Enhanced accessibility testing
- **Load Tests:** High-volume data handling
- **Security Tests:** Authentication ve authorization

### Test Automation
- **Scheduled Tests:** Otomatik günlük test çalıştırma
- **Regression Suite:** Release öncesi kapsamlı testler
- **Device Farm Integration:** Multiple device testing
- **Snapshot Testing:** State snapshot comparisons

## 📚 Referanslar

- [Flutter Testing Documentation](https://docs.flutter.dev/testing)
- [BLoC Testing Guide](https://bloclibrary.dev/#/testing)
- [Mockito Documentation](https://pub.dev/packages/mockito)
- [Integration Testing](https://docs.flutter.dev/testing/integration-tests)

---

Bu test suite'i, Okumanya uygulamasının güvenilir, performanslı ve kullanıcı dostu olmasını sağlamak için tasarlanmıştır. Tüm testler düzenli olarak çalıştırılmalı ve yeni özellikler eklendiğinde ilgili testler de yazılmalıdır.