# 🏗️ Architecture Guide

## Overview

**Okumanya** follows **Clean Architecture** principles with a feature-driven development approach, ensuring maintainability, testability, and scalability. Built with Flutter 3.24.1 and modern development practices including Firebase-free custom analytics.

## 📋 Table of Contents

- [Architecture Layers](#architecture-layers)
- [Directory Structure](#directory-structure)
- [Design Patterns](#design-patterns)
- [Data Flow](#data-flow)
- [Dependency Management](#dependency-management)
- [State Management](#state-management)
- [Error Handling](#error-handling)

## Architecture Layers

### 🎯 Presentation Layer
- **Responsibility**: UI components, state management, user interactions
- **Technologies**: Flutter Widgets, BLoC pattern with Freezed, Auto Route
- **Location**: `lib/features/*/presentation/`

```dart
// Example BLoC structure
class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final GetBooks getBooks;
  final SearchBooks searchBooks;
  
  BooksBloc({required this.getBooks, required this.searchBooks})
    : super(const BooksState.initial()) {
    on<LoadBooks>(_onLoadBooks);
    on<SearchBooks>(_onSearchBooks);
  }
}
```

### 🧠 Domain Layer
- **Responsibility**: Business logic, entities, use cases
- **Technologies**: Pure Dart, abstract interfaces
- **Location**: `lib/features/*/domain/`

```dart
// Example Use Case
class GetBooks extends UseCase<List<Book>, NoParams> {
  final BooksRepository repository;
  
  GetBooks(this.repository);
  
  @override
  Future<Either<Failure, List<Book>>> call(NoParams params) {
    return repository.getBooks();
  }
}
```

### 💾 Data Layer
- **Responsibility**: Data sources, models, repository implementations
- **Technologies**: Dio, Hive, JSON serialization, FlutterSecureStorage
- **Location**: `lib/features/*/data/`

```dart
// Example Repository Implementation
class BooksRepositoryImpl implements BooksRepository {
  final BooksRemoteDataSource remoteDataSource;
  final BooksLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  
  BooksRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  
  @override
  Future<Either<Failure, List<Book>>> getBooks() async {
    if (await networkInfo.isConnected) {
      try {
        final books = await remoteDataSource.getBooks();
        await localDataSource.cacheBooks(books);
        return Right(books.map((model) => model.toDomain()).toList());
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      final cachedBooks = await localDataSource.getCachedBooks();
      return Right(cachedBooks.map((model) => model.toDomain()).toList());
    }
  }
}
```

## Directory Structure

```
lib/
├── core/                        # Core functionality
│   ├── analytics/              # Custom analytics services (Firebase-free)
│   ├── cache/                  # Caching mechanisms (Hive)
│   ├── constants/              # App constants
│   ├── di/                     # Dependency injection (Injectable/GetIt)
│   ├── error/                  # Error handling
│   ├── localization/           # Internationalization (easy_localization)
│   ├── network/                # Network utilities (Dio)
│   ├── performance/            # Performance monitoring
│   ├── repository/             # Base repository pattern
│   ├── theme/                  # Theme management (Material Design 3.0)
│   ├── usecase/               # Base use case pattern
│   └── widgets/               # Reusable widgets
├── features/                   # Feature modules
│   ├── auth/                  # Authentication
│   │   ├── data/             # Data layer
│   │   ├── domain/           # Domain layer
│   │   └── presentation/     # Presentation layer
│   ├── books/                # Book management
│   ├── home/                 # Home screen
│   ├── profile/              # User profile
│   └── splash/               # Splash screen
├── shared/                    # Shared utilities
│   ├── config/               # Configuration
│   ├── di/                   # Service locator
│   ├── error/                # Global error handling
│   ├── navigation/           # Routing
│   ├── network/              # Network layer
│   ├── resources/            # Resources & styles
│   └── storage/              # Local storage
└── main.dart                 # App entry point
```

## Design Patterns

### 🎯 Repository Pattern
Abstracts data sources and provides a unified interface for data access.

```dart
abstract class BooksRepository {
  Future<Either<Failure, List<Book>>> getBooks();
  Future<Either<Failure, Book>> getBookById(String id);
  Future<Either<Failure, List<Book>>> searchBooks(String query);
}
```

### 🔄 Use Case Pattern
Encapsulates business logic in reusable, testable units.

```dart
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
```

### 🏭 Factory Pattern
Used for creating complex objects, especially in dependency injection.

```dart
@injectable
class BooksBloc extends Bloc<BooksEvent, BooksState> {
  factory BooksBloc({
    required GetBooks getBooks,
    required SearchBooks searchBooks,
  }) = _$BooksBloc;
}
```

### 🎨 BLoC Pattern
Separates business logic from UI, providing predictable state management.

```dart
sealed class BooksEvent extends Equatable {
  const BooksEvent();
}

class LoadBooks extends BooksEvent {
  @override
  List<Object> get props => [];
}

@freezed
class BooksState with _$BooksState {
  const factory BooksState.initial() = _Initial;
  const factory BooksState.loading() = _Loading;
  const factory BooksState.loaded(List<Book> books) = _Loaded;
  const factory BooksState.error(String message) = _Error;
}
```

## Data Flow

### 📱 User Interaction Flow
```
User Action → Widget → BLoC → Use Case → Repository → Data Source → API/Database
                ↓        ↓        ↓          ↓           ↓
            UI Update ← State ← Result ← Either ← Response ← Data
```

### 🔄 State Management Flow
```
Event → BLoC → Use Case → Repository → Data Source
  ↓       ↓       ↓          ↓           ↓
State → UI → Loading → Caching → Response
```

## Dependency Management

### 🎯 Dependency Injection
Using `Injectable` and `GetIt` for dependency management (replacing manual DI setup):

```dart
@module
abstract class DioModule {
  @lazySingleton
  Dio get dio => Dio(BaseOptions(
    baseUrl: AppConfig.apiBaseUrl,
    connectTimeout: Duration(milliseconds: AppConstants.connectTimeout),
    receiveTimeout: Duration(milliseconds: AppConstants.receiveTimeout),
  ));
}

@injectable
class BooksRemoteDataSourceImpl implements BooksRemoteDataSource {
  final Dio dio;
  
  BooksRemoteDataSourceImpl(this.dio);
}
```

### 📦 Service Locator
```dart
final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  getIt.init();
}
```

## State Management

### 🎯 BLoC Pattern Implementation
```dart
class BooksBloc extends Bloc<BooksEvent, BooksState> {
  BooksBloc({
    required this.getBooks,
    required this.searchBooks,
  }) : super(const BooksState.initial()) {
    on<LoadBooks>(_onLoadBooks);
    on<SearchBooksEvent>(_onSearchBooks);
  }
  
  Future<void> _onLoadBooks(LoadBooks event, Emitter<BooksState> emit) async {
    emit(const BooksState.loading());
    
    final result = await getBooks(NoParams());
    
    result.fold(
      (failure) => emit(BooksState.error(failure.message)),
      (books) => emit(BooksState.loaded(books)),
    );
  }
}
```

### 🎨 State Classes with Freezed
```dart
@freezed
class BooksState with _$BooksState {
  const factory BooksState.initial() = _Initial;
  const factory BooksState.loading() = _Loading;
  const factory BooksState.loaded(List<Book> books) = _Loaded;
  const factory BooksState.error(String message) = _Error;
}
```

## Error Handling

### 🚨 Failure Hierarchy
```dart
abstract class Failure extends Equatable {
  const Failure({required this.message, this.statusCode});
  final String message;
  final int? statusCode;
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'Network error', super.statusCode});
}

class ServerFailure extends Failure {
  const ServerFailure({super.message = 'Server error', super.statusCode});
}

class ValidationFailure extends Failure {
  const ValidationFailure({super.message = 'Validation error', super.statusCode});
}
```

### 🎯 Either Pattern for Error Handling
```dart
Future<Either<Failure, List<Book>>> getBooks() async {
  try {
    final books = await remoteDataSource.getBooks();
    return Right(books);
  } on DioException catch (e) {
    return Left(_mapDioExceptionToFailure(e));
  } catch (e) {
    return Left(UnknownFailure(e.toString()));
  }
}
```

## Best Practices

### ✅ Do's
- Use const constructors whenever possible
- Implement proper error handling with Either pattern
- Keep business logic in use cases
- Use dependency injection for loose coupling
- Write tests for critical business logic
- Follow single responsibility principle

### ❌ Don'ts
- Don't put business logic in widgets
- Don't use BuildContext across async boundaries
- Don't ignore error states
- Don't create God classes
- Don't skip testing critical paths

## Testing Strategy

### 🧪 Unit Tests
```dart
group('GetBooks UseCase', () {
  test('should return books when repository call is successful', () async {
    // arrange
    when(mockRepository.getBooks()).thenAnswer((_) async => Right(testBooks));
    
    // act
    final result = await usecase(NoParams());
    
    // assert
    expect(result, Right(testBooks));
    verify(mockRepository.getBooks());
  });
});
```

### 🎯 BLoC Tests
```dart
blocTest<BooksBloc, BooksState>(
  'emits [loading, loaded] when books are loaded successfully',
  build: () => BooksBloc(getBooks: mockGetBooks, searchBooks: mockSearchBooks),
  act: (bloc) => bloc.add(const LoadBooks()),
  expect: () => [
    const BooksState.loading(),
    BooksState.loaded(testBooks),
  ],
);
```

## Performance Considerations

- **Lazy Loading**: Implement for large lists
- **Caching**: Use Hive for local data persistence
- **Image Optimization**: Use CachedNetworkImage
- **Build Optimization**: Use const constructors and RepaintBoundary
- **Memory Management**: Proper disposal in BLoCs and controllers

## Security Considerations

- **Data Encryption**: Sensitive data encrypted in local storage
- **Network Security**: HTTPS only, certificate pinning
- **Authentication**: JWT tokens with proper expiration handling
- **Input Validation**: All user inputs validated at domain layer