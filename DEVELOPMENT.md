# 🛠️ Development Guide

## Getting Started

This guide will help you set up the development environment and contribute to the Okumanya project.

## 📋 Prerequisites

### Required Software
- **Flutter SDK**: 3.24.1 or higher
- **Dart SDK**: 3.6.1 or higher
- **Git**: Latest version
- **IDE**: Android Studio, VS Code, or IntelliJ IDEA

### Platform-Specific Requirements

#### Android Development
- **Android Studio**: Latest version
- **Android SDK**: API level 21 or higher
- **Java**: JDK 11 or higher

#### iOS Development (macOS only)
- **Xcode**: 15.0 or higher
- **CocoaPods**: Latest version
- **iOS Deployment Target**: 12.0 or higher

## 🚀 Setup Instructions

### 1. Clone Repository
```bash
git clone https://github.com/your-username/okumanya.git
cd okumanya
```

### 2. Install Dependencies
```bash
# Install Flutter dependencies
flutter pub get

# Install iOS dependencies (macOS only)
cd ios && pod install && cd ..
```

### 3. Code Generation
```bash
# Generate code for models, routes, and DI
dart run build_runner build --delete-conflicting-outputs
```

### 4. Environment Configuration
```bash
# Copy example environment file
cp .env.example .env

# Edit .env with your configuration
# API_BASE_URL=https://api.okumanya.com
# API_TIMEOUT=30000
```

### 5. Run the Application
```bash
# Debug mode
flutter run

# Release mode
flutter run --release

# Specific device
flutter run -d <device-id>
```

## 🏗️ Project Structure

```
lib/
├── core/                    # Core functionality and utilities
│   ├── analytics/          # Custom analytics service
│   ├── cache/              # Caching mechanisms (Hive)
│   ├── constants/          # Application constants
│   ├── di/                 # Dependency injection setup
│   ├── error/              # Error handling and failures
│   ├── localization/       # Internationalization support
│   ├── network/            # Network utilities and info
│   ├── performance/        # Performance monitoring tools
│   ├── repository/         # Base repository pattern
│   ├── theme/              # Theme management
│   ├── usecase/           # Base use case pattern
│   └── widgets/           # Reusable UI components
├── features/               # Feature-based modules
│   ├── auth/              # Authentication feature
│   │   ├── data/          # Data sources and models
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/        # Business logic
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/  # UI and state management
│   │       ├── bloc/
│   │       ├── pages/
│   │       └── widgets/
│   ├── books/             # Book management feature
│   ├── home/              # Home screen feature
│   ├── profile/           # User profile feature
│   └── splash/            # Splash screen
├── shared/                # Shared utilities
│   ├── config/           # App configuration
│   ├── di/               # Service locator
│   ├── error/            # Global error handling
│   ├── navigation/       # Auto Route navigation
│   ├── network/          # Dio network layer
│   ├── resources/        # Colors, themes, constants
│   └── storage/          # Secure storage utilities
└── main.dart             # Application entry point
```

## 🔧 Development Workflow

### Branch Strategy
```bash
# Feature branches
git checkout -b feature/book-search
git checkout -b fix/login-validation
git checkout -b refactor/performance-improvements

# Branch naming convention
feature/[description]    # New features
fix/[description]        # Bug fixes
refactor/[description]   # Code improvements
docs/[description]       # Documentation updates
```

### Commit Message Convention
```bash
# Format: type(scope): description

feat(books): add search functionality
fix(auth): resolve login validation issue
refactor(core): improve error handling
docs(readme): update installation guide
test(books): add unit tests for book repository
```

### Code Generation
```bash
# Generate all code
dart run build_runner build --delete-conflicting-outputs

# Watch for changes (during development)
dart run build_runner watch

# Clean and regenerate
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```

## 🧪 Testing

### Running Tests
```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/features/books/domain/usecases/get_books_test.dart

# Run widget tests
flutter test test/widgets/

# Run integration tests
flutter test integration_test/
```

### Test Structure
```
test/
├── features/              # Feature-specific tests
│   ├── auth/
│   │   ├── data/         # Data layer tests
│   │   ├── domain/       # Domain layer tests
│   │   └── presentation/ # Presentation layer tests
│   └── books/
├── unit/                 # Unit tests
├── widget/               # Widget tests
├── integration/          # Integration tests
└── test_helpers.dart     # Test utilities
```

### Writing Tests

#### Unit Test Example
```dart
group('GetBooks UseCase', () {
  late GetBooks useCase;
  late MockBooksRepository mockRepository;

  setUp(() {
    mockRepository = MockBooksRepository();
    useCase = GetBooks(mockRepository);
  });

  test('should return books when repository call is successful', () async {
    // arrange
    final testBooks = [Book(id: '1', title: 'Test Book')];
    when(mockRepository.getBooks()).thenAnswer(
      (_) async => Right(testBooks),
    );

    // act
    final result = await useCase(NoParams());

    // assert
    expect(result, Right(testBooks));
    verify(mockRepository.getBooks());
    verifyNoMoreInteractions(mockRepository);
  });
});
```

#### BLoC Test Example
```dart
blocTest<BooksBloc, BooksState>(
  'emits [loading, loaded] when books are loaded successfully',
  build: () => BooksBloc(
    getBooks: mockGetBooks,
    searchBooks: mockSearchBooks,
  ),
  act: (bloc) => bloc.add(const LoadBooks()),
  expect: () => [
    const BooksState.loading(),
    BooksState.loaded(testBooks),
  ],
  verify: (_) {
    verify(mockGetBooks(NoParams()));
  },
);
```

## 📱 Platform-Specific Development

### Android
```bash
# Build APK
flutter build apk --release

# Build App Bundle
flutter build appbundle --release

# Install debug APK
flutter install
```

### iOS
```bash
# Build iOS app
flutter build ios --release

# Build for simulator
flutter build ios --simulator

# Open in Xcode
open ios/Runner.xcworkspace
```

## 🔍 Debugging

### Debug Tools
```bash
# Flutter Inspector
flutter inspector

# Debug with DevTools
flutter run --debug
# Then open DevTools in browser

# Performance profiling
flutter run --profile
```

### Logging
```dart
// Use Flutter's built-in logging
import 'dart:developer' as developer;

developer.log('Debug message', name: 'MyApp');

// Custom analytics logging
analyticsService.logBreadcrumb('User action', data: {'action': 'button_tap'});
```

## 🚀 Performance Optimization

### Best Practices
- Use `const` constructors wherever possible
- Implement `AutomaticKeepAliveClientMixin` for expensive widgets
- Use `RepaintBoundary` for complex widgets
- Optimize images and use `CachedNetworkImage`
- Profile app regularly with Flutter DevTools

### Performance Testing
```dart
// Use built-in performance benchmarks
await PerformanceBenchmarks.runPerformanceTests();

// Measure specific operations
await PerformanceBenchmarks.measureNetworkCall(
  'fetch_books',
  () => booksRepository.getBooks(),
);
```

## 🌍 Internationalization

### Adding New Languages
```bash
# 1. Add locale to supported locales in main.dart
supportedLocales: const [
  Locale('tr', 'TR'), // Turkish
  Locale('en', 'US'), // English
  Locale('de', 'DE'), // German (new)
],

# 2. Create translation file
touch assets/lang/de-DE.json

# 3. Add translations to LocaleKeys
LocaleKeys.home.welcome // -> 'home.welcome'.tr()
```

### Using Translations
```dart
// In widgets
Text(LocaleKeys.common.loading), // Recommended

// With parameters
Text('errors.validation'.tr(args: ['username'])),

// Check current locale
if (context.locale == const Locale('tr', 'TR')) {
  // Turkish-specific logic
}
```

## 🏗️ Code Style and Conventions

### Flutter/Dart Style Guide
- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart)
- Use `dart format` before committing
- Fix all `flutter analyze` warnings

### Naming Conventions
```dart
// Classes: PascalCase
class BookRepository {}

// Variables/Functions: camelCase
String bookTitle = '';
void fetchBooks() {}

// Constants: camelCase with const
const int defaultTimeout = 30000;

// Private members: _underscore
String _privateField = '';

// Files: snake_case
book_repository.dart
home_page.dart
```

### Widget Structure
```dart
class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required this.book,
    this.onTap,
  });

  final Book book;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          children: [
            // Widget content
          ],
        ),
      ),
    );
  }
}
```

## 🔒 Security Best Practices

### Sensitive Data
```dart
// Use FlutterSecureStorage for sensitive data
final storage = FlutterSecureStorage();
await storage.write(key: 'auth_token', value: token);

// Never commit secrets to version control
// Use environment variables or secure configuration
```

### Network Security
```dart
// Use HTTPS only
final dio = Dio(BaseOptions(
  baseUrl: 'https://api.okumanya.com', // Always HTTPS
));

// Implement certificate pinning for production
```

## 🚨 Troubleshooting

### Common Issues

#### Build Errors
```bash
# Clean build
flutter clean
flutter pub get
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs

# Clear IDE cache
# Android Studio: File > Invalidate Caches and Restart
# VS Code: Reload window
```

#### iOS Build Issues
```bash
# Clean iOS build
cd ios
rm -rf Pods Podfile.lock
pod install
cd ..
flutter clean
flutter pub get
```

#### Android Build Issues
```bash
# Clean Android build
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

### Getting Help
- Check [Flutter documentation](https://docs.flutter.dev/)
- Search existing [GitHub issues](https://github.com/your-username/okumanya/issues)
- Create new issue with:
  - Flutter version (`flutter --version`)
  - Platform details
  - Steps to reproduce
  - Error logs

## 📊 CI/CD Integration

The project includes automated workflows for:
- **Code Quality**: Static analysis and linting
- **Testing**: Unit, widget, and integration tests
- **Build**: APK and App Bundle generation
- **Deployment**: Automated store uploads (when configured)

See `.github/workflows/` for workflow configurations.

## 🤝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Follow code style guidelines
4. Write tests for new functionality
5. Commit changes (`git commit -m 'feat: add amazing feature'`)
6. Push to branch (`git push origin feature/amazing-feature`)
7. Create Pull Request

### Pull Request Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Tests added/updated
- [ ] Documentation updated
- [ ] All CI checks pass