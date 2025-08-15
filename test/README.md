# 🧪 Testing Guide

## Overview

This guide covers the comprehensive testing strategy implemented in **Okumanya**, ensuring code quality, reliability, and maintainability through various testing approaches.

## 📋 Table of Contents

- [Testing Philosophy](#testing-philosophy)
- [Test Structure](#test-structure)
- [Testing Types](#testing-types)
- [Test Coverage](#test-coverage)
- [Running Tests](#running-tests)
- [Writing Tests](#writing-tests)
- [Testing Tools](#testing-tools)
- [Best Practices](#best-practices)
- [CI/CD Integration](#cicd-integration)

## Testing Philosophy

Okumanya follows a **test-driven development** approach with:

- **Quality First**: Ensure all features work as expected
- **Clean Architecture Testing**: Test each layer independently
- **BLoC Testing**: Comprehensive state management testing
- **User Experience**: Integration tests for real user scenarios
- **Performance**: Test app performance and memory usage

## Test Structure

```
test/
├── unit/                      # Unit tests for business logic
│   ├── core/                 # Core functionality tests
│   │   ├── analytics/        # Analytics service tests
│   │   ├── cache/           # Cache manager tests
│   │   ├── network/         # Network utilities tests
│   │   └── performance/     # Performance monitoring tests
│   └── features/            # Feature-specific unit tests
│       ├── auth/
│       │   ├── data/        # Data layer tests
│       │   ├── domain/      # Domain layer tests
│       │   └── presentation/ # BLoC tests
│       └── books/
├── widget/                   # Widget tests for UI components
│   ├── core/
│   │   └── widgets/         # Reusable widget tests
│   └── features/
│       ├── auth/
│       │   └── widgets/     # Feature widget tests
│       └── books/
├── integration_test/         # Integration tests
│   ├── app_integration_test.dart
│   ├── auth_flow_test.dart
│   └── books_flow_test.dart
├── golden/                   # Golden image tests
│   ├── widgets/
│   └── pages/
├── mocks/                    # Mock objects and test helpers
│   ├── mock_services.dart
│   ├── mock_repositories.dart
│   └── test_data.dart
└── test_helpers.dart         # Test utilities and helpers
```

## Testing Types

### 🔬 Unit Tests

Test individual units of code in isolation:

```dart
// Example: Testing a use case
group('GetBooks UseCase', () {
  late GetBooks useCase;
  late MockBooksRepository mockRepository;

  setUp(() {
    mockRepository = MockBooksRepository();
    useCase = GetBooks(mockRepository);
  });

  test('should return books when repository call is successful', () async {
    // arrange
    final testBooks = [
      Book(id: '1', title: 'Test Book', author: 'Test Author'),
    ];
    when(mockRepository.getBooks()).thenAnswer((_) async => Right(testBooks));

    // act
    final result = await useCase(NoParams());

    // assert
    expect(result, Right(testBooks));
    verify(mockRepository.getBooks());
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return failure when repository throws exception', () async {
    // arrange
    when(mockRepository.getBooks()).thenAnswer(
      (_) async => const Left(NetworkFailure()),
    );

    // act
    final result = await useCase(NoParams());

    // assert
    expect(result, const Left(NetworkFailure()));
  });
});
```

### 🎯 BLoC Tests

Test state management with bloc_test:

```dart
// Example: Testing BLoC
blocTest<BooksBloc, BooksState>(
  'emits [loading, loaded] when books are loaded successfully',
  build: () => BooksBloc(
    getBooks: mockGetBooks,
    searchBooks: mockSearchBooks,
  ),
  act: (bloc) => bloc.add(const LoadBooks()),
  setUp: () {
    when(mockGetBooks(NoParams())).thenAnswer(
      (_) async => Right(testBooks),
    );
  },
  expect: () => [
    const BooksState.loading(),
    BooksState.loaded(testBooks),
  ],
  verify: (_) {
    verify(mockGetBooks(NoParams()));
  },
);

blocTest<BooksBloc, BooksState>(
  'emits [loading, error] when books loading fails',
  build: () => BooksBloc(
    getBooks: mockGetBooks,
    searchBooks: mockSearchBooks,
  ),
  act: (bloc) => bloc.add(const LoadBooks()),
  setUp: () {
    when(mockGetBooks(NoParams())).thenAnswer(
      (_) async => const Left(NetworkFailure()),
    );
  },
  expect: () => [
    const BooksState.loading(),
    const BooksState.error('Network connection failed'),
  ],
);
```

### 📱 Widget Tests

Test UI components and their behavior:

```dart
// Example: Testing a widget
testWidgets('BookCard displays book information correctly', (tester) async {
  // arrange
  const testBook = Book(
    id: '1',
    title: 'Test Book',
    author: 'Test Author',
  );

  // act
  await tester.pumpWidget(
    MaterialApp(
      home: BookCard(book: testBook),
    ),
  );

  // assert
  expect(find.text('Test Book'), findsOneWidget);
  expect(find.text('Test Author'), findsOneWidget);
  expect(find.byType(Card), findsOneWidget);
});

testWidgets('BookCard calls onTap when tapped', (tester) async {
  // arrange
  bool wasTapped = false;
  const testBook = Book(id: '1', title: 'Test Book');

  // act
  await tester.pumpWidget(
    MaterialApp(
      home: BookCard(
        book: testBook,
        onTap: () => wasTapped = true,
      ),
    ),
  );

  await tester.tap(find.byType(BookCard));

  // assert
  expect(wasTapped, isTrue);
});
```

### 🔗 Integration Tests

Test complete user flows:

```dart
// Example: Integration test
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:okumanya/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Integration Tests', () {
    testWidgets('complete book search flow', (tester) async {
      // Start app
      app.main();
      await tester.pumpAndSettle();

      // Navigate to search
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      // Enter search query
      await tester.enterText(find.byType(TextField), 'flutter');
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pumpAndSettle();

      // Verify results
      expect(find.text('Search Results'), findsOneWidget);
      expect(find.byType(BookCard), findsWidgets);
    });
  });
}
```

### 🎨 Golden Tests

Test UI appearance with golden images:

```dart
// Example: Golden test
testWidgets('BookCard golden test', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: BookCard(
        book: Book(
          id: '1',
          title: 'Sample Book',
          author: 'Sample Author',
        ),
      ),
    ),
  );

  await expectLater(
    find.byType(BookCard),
    matchesGoldenFile('golden/book_card.png'),
  );
});
```

## Test Coverage

### Coverage Goals

- **Overall**: >80% line coverage
- **Business Logic**: >90% coverage
- **Critical Paths**: 100% coverage
- **UI Components**: >70% coverage

### Generating Coverage Reports

```bash
# Generate coverage
flutter test --coverage

# Generate HTML report (requires lcov)
genhtml coverage/lcov.info -o coverage/html

# Open report
open coverage/html/index.html
```

### Coverage Analysis

```bash
# Check coverage percentage
lcov --summary coverage/lcov.info

# Find uncovered lines
lcov --list coverage/lcov.info | grep -E "^[^|]*\|[^|]*\|[^1]"
```

## Running Tests

### Test Scripts

Use the provided test script for comprehensive testing:

```bash
# Run all tests with coverage
./scripts/run_tests.sh all

# Run specific test types
./scripts/run_tests.sh unit
./scripts/run_tests.sh widget
./scripts/run_tests.sh integration
./scripts/run_tests.sh golden

# Update golden files
./scripts/run_tests.sh golden --update-goldens
```

### Manual Test Commands

```bash
# Unit tests
flutter test test/unit/

# Widget tests
flutter test test/widget/

# Integration tests
flutter test integration_test/

# Specific test file
flutter test test/unit/features/books/domain/usecases/get_books_test.dart

# Run with coverage
flutter test --coverage

# Watch mode (reruns on file changes)
flutter test --watch
```

## Writing Tests

### Test Naming Convention

```dart
// Use descriptive test names
test('should return books when repository call is successful', () {});
test('should throw NetworkException when no internet connection', () {});
test('should cache books locally after successful fetch', () {});

// Group related tests
group('GetBooks UseCase', () {
  group('when repository returns success', () {
    // Happy path tests
  });
  
  group('when repository returns failure', () {
    // Error case tests
  });
});
```

### Mock Setup

```dart
// Create mocks
@GenerateMocks([BooksRepository, NetworkInfo, CacheManager])
void main() {
  late MockBooksRepository mockRepository;
  late MockNetworkInfo mockNetworkInfo;
  
  setUp(() {
    mockRepository = MockBooksRepository();
    mockNetworkInfo = MockNetworkInfo();
  });
}
```

### Test Data Setup

```dart
// Create test data helpers
class TestData {
  static const testBook = Book(
    id: '1',
    title: 'Test Book',
    author: 'Test Author',
    category: 'Fiction',
    publishedDate: '2024-01-01',
  );
  
  static final testBooks = [testBook];
  
  static const testUser = User(
    id: '1',
    name: 'Test User',
    email: 'test@example.com',
  );
}
```

## Testing Tools

### Core Testing Dependencies

```yaml
dev_dependencies:
  # Core testing
  flutter_test:
    sdk: flutter
  test: ^1.24.0
  
  # BLoC testing
  bloc_test: ^9.1.4
  
  # Mocking
  mockito: ^5.4.2
  
  # Integration testing
  integration_test:
    sdk: flutter
  
  # UI testing
  patrol: ^3.6.1
  alchemist: ^0.9.0
  
  # Golden testing
  golden_toolkit: ^0.15.0
```

### Test Utilities

```dart
// Test helpers
class TestHelpers {
  // Create test app wrapper
  static Widget wrapWithApp(Widget child) {
    return MaterialApp(
      home: Scaffold(body: child),
      theme: AppTheme.lightTheme,
    );
  }
  
  // Create BLoC provider wrapper
  static Widget wrapWithBlocProvider<T extends BlocBase>(
    T bloc,
    Widget child,
  ) {
    return BlocProvider<T>(
      create: (_) => bloc,
      child: wrapWithApp(child),
    );
  }
  
  // Pump with localization
  static Future<void> pumpWithLocalization(
    WidgetTester tester,
    Widget widget,
  ) async {
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('tr')],
        path: 'assets/lang',
        fallbackLocale: const Locale('en'),
        child: wrapWithApp(widget),
      ),
    );
  }
}
```

## Best Practices

### ✅ DO's

- **Test Behavior, Not Implementation**: Test what the code does, not how
- **Use Descriptive Names**: Make test intentions clear
- **Arrange-Act-Assert**: Structure tests clearly
- **Mock External Dependencies**: Keep tests isolated
- **Test Edge Cases**: Cover error scenarios and boundary conditions
- **Keep Tests Fast**: Avoid unnecessary delays
- **One Assertion Per Test**: Focus on single behavior

### ❌ DON'Ts

- **Don't Test Private Methods**: Test public interface only
- **Don't Use Real Network Calls**: Always mock external services
- **Don't Ignore Test Failures**: Fix broken tests immediately
- **Don't Copy-Paste Tests**: Create reusable test helpers
- **Don't Skip Error Testing**: Test failure scenarios

### Testing Checklist

- [ ] All public methods tested
- [ ] Error cases covered
- [ ] Edge cases tested
- [ ] Mocks properly configured
- [ ] Tests are independent
- [ ] Coverage meets requirements
- [ ] Performance tests included
- [ ] Integration flows tested

## CI/CD Integration

Tests are automatically run in GitHub Actions:

### Automated Testing Pipeline

1. **Unit Tests**: Run on every commit
2. **Widget Tests**: Validate UI components
3. **Integration Tests**: Test complete flows
4. **Coverage Analysis**: Ensure coverage requirements
5. **Performance Tests**: Monitor app performance

### Test Reports

- **Coverage**: Generated and uploaded to Codecov
- **Test Results**: Displayed in GitHub Actions
- **Performance**: Benchmarked and tracked over time

### Quality Gates

Tests must pass before:
- **Merging PRs**: All tests green
- **Deployment**: Integration tests pass
- **Release**: Full test suite passes

## Troubleshooting

### Common Issues

#### Test Failures
```bash
# Clear test cache
flutter clean
flutter pub get

# Reset test database
rm -rf test/.dart_tool
```

#### Coverage Issues
```bash
# Ensure coverage directory exists
mkdir -p coverage

# Check lcov installation
which lcov
```

#### Integration Test Issues
```bash
# Check device/emulator
flutter devices

# Run with verbose logging
flutter test integration_test/ -v
```

### Performance Testing

```dart
// Example: Performance test
test('book loading performance', () async {
  final stopwatch = Stopwatch()..start();
  
  final result = await getBooksUseCase(NoParams());
  
  stopwatch.stop();
  
  expect(stopwatch.elapsedMilliseconds, lessThan(1000));
  expect(result.isRight(), true);
});
```

## Resources

- **[Flutter Testing Documentation](https://docs.flutter.dev/testing)**
- **[BLoC Testing Guide](https://bloclibrary.dev/#/testing)**
- **[Mockito Documentation](https://pub.dev/packages/mockito)**
- **[Integration Testing](https://docs.flutter.dev/testing/integration-tests)**

---

Remember: **Good tests are as important as good code!** 🎯