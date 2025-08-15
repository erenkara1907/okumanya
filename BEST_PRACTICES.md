# 📚 Best Practices Guide

## Overview

This guide outlines the best practices, conventions, and standards followed in the **Okumanya** project to ensure code quality, maintainability, and team collaboration. Built with Flutter using Clean Architecture principles and Firebase-free custom analytics.

## 📋 Table of Contents

- [Code Organization](#code-organization)
- [Clean Architecture](#clean-architecture)
- [State Management](#state-management)
- [Error Handling](#error-handling)
- [Performance Optimization](#performance-optimization)
- [Testing Practices](#testing-practices)
- [Security Guidelines](#security-guidelines)
- [UI/UX Guidelines](#ui-ux-guidelines)
- [Code Review Guidelines](#code-review-guidelines)

## Code Organization

### 🧹 Repository Management

#### Generated Files Policy
```bash
# Generated files are excluded from Git
*.g.dart
*.freezed.dart
*.config.dart
*.gr.dart
*.mocks.dart

# Use regeneration script after clone/pull
./scripts/regenerate_code.sh
```

#### Clean Repository Benefits
- **90% smaller repository** - No build artifacts
- **Faster clones** - Optimized for team collaboration
- **No merge conflicts** - Generated files excluded
- **Consistent environment** - Everyone regenerates locally

### 📁 File Naming Conventions

```bash
# Use snake_case for files
book_repository.dart
home_page.dart
user_profile_model.dart

# Use PascalCase for classes
class BookRepository {}
class HomePage {}
class UserProfileModel {}

# Use camelCase for variables and functions
String userName = 'John';
void fetchUserData() {}

# Use camelCase for constants (following Dart conventions)
const String apiBaseUrl = 'https://api.okumanya.com';
const int defaultTimeout = 30000;
```

### 📦 Import Organization

```dart
// 1. Dart imports
import 'dart:async';
import 'dart:convert';

// 2. Flutter imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 3. Third-party imports
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

// 4. Project imports (use barrel exports when possible)
import 'package:okumanya/core/core.dart';
import 'package:okumanya/shared/shared.dart';

// 5. Relative imports (avoid deep nesting)
import '../widgets/book_card.dart';
import '../../domain/entities/book.dart';
```

### 🏗️ Directory Structure Rules

```
✅ DO: Group by feature
features/
  books/
    data/
    domain/
    presentation/

✅ DO: Keep related files together
widgets/
  book_card.dart
  book_list.dart
  book_detail.dart

❌ DON'T: Group by file type across features
widgets/
  all_widgets_here.dart  # Too generic
```

## Clean Architecture

### 🎯 Layer Responsibilities

#### Presentation Layer
```dart
// ✅ DO: Keep UI logic minimal
class BookListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BooksBloc, BooksState>(
      builder: (context, state) {
        return state.when(
          initial: () => const InitialWidget(),
          loading: () => const LoadingWidget(),
          loaded: (books) => BookList(books: books),
          error: (message) => ErrorWidget(message: message),
        );
      },
    );
  }
}

// ❌ DON'T: Put business logic in widgets
class BadBookListPage extends StatefulWidget {
  @override
  _BadBookListPageState createState() => _BadBookListPageState();
}

class _BadBookListPageState extends State<BadBookListPage> {
  List<Book> books = [];
  
  @override
  void initState() {
    super.initState();
    // ❌ Business logic in UI
    fetchBooksFromAPI();
  }
  
  Future<void> fetchBooksFromAPI() async {
    // ❌ Direct API calls from UI
    final response = await Dio().get('/books');
    setState(() {
      books = response.data.map((json) => Book.fromJson(json)).toList();
    });
  }
}
```

#### Domain Layer
```dart
// ✅ DO: Pure business logic
class GetBooks extends UseCase<List<Book>, NoParams> {
  final BooksRepository repository;
  
  GetBooks(this.repository);
  
  @override
  Future<Either<Failure, List<Book>>> call(NoParams params) {
    return repository.getBooks();
  }
}

// ✅ DO: Abstract interfaces
abstract class BooksRepository {
  Future<Either<Failure, List<Book>>> getBooks();
  Future<Either<Failure, Book>> getBookById(String id);
}

// ❌ DON'T: Framework dependencies in domain
class BadUseCase {
  Future<List<Book>> getBooks() async {
    // ❌ Direct framework usage
    final prefs = await SharedPreferences.getInstance();
    final dio = Dio();
    // ...
  }
}
```

#### Data Layer
```dart
// ✅ DO: Implement domain interfaces
class BooksRepositoryImpl extends BaseRepository implements BooksRepository {
  final BooksRemoteDataSource remoteDataSource;
  final BooksLocalDataSource localDataSource;
  
  BooksRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required NetworkInfo networkInfo,
  }) : super(networkInfo);
  
  @override
  Future<Either<Failure, List<Book>>> getBooks() {
    return safeApiCallWithCache(
      () async {
        final models = await remoteDataSource.getBooks();
        return models.map((model) => model.toDomain()).toList();
      },
      () => localDataSource.getCachedBooks(),
      (books) => localDataSource.cacheBooks(books),
    );
  }
}

// ❌ DON'T: Skip error handling
class BadRepository implements BooksRepository {
  @override
  Future<Either<Failure, List<Book>>> getBooks() async {
    // ❌ No error handling
    final response = await dio.get('/books');
    return Right(response.data.map((json) => Book.fromJson(json)).toList());
  }
}
```

## State Management

### 🎯 BLoC Pattern Best Practices

#### Event Design
```dart
// ✅ DO: Use sealed classes for events
@freezed
sealed class BooksEvent with _$BooksEvent {
  const factory BooksEvent.loadBooks() = LoadBooks;
  const factory BooksEvent.searchBooks(String query) = SearchBooks;
  const factory BooksEvent.refreshBooks() = RefreshBooks;
}

// ❌ DON'T: Use loose class hierarchy
abstract class BooksEvent extends Equatable {}
class LoadBooks extends BooksEvent { /* ... */ }
class SearchBooks extends BooksEvent { /* ... */ }
```

#### State Design
```dart
// ✅ DO: Use freezed for immutable states
@freezed
class BooksState with _$BooksState {
  const factory BooksState.initial() = _Initial;
  const factory BooksState.loading() = _Loading;
  const factory BooksState.loaded(List<Book> books) = _Loaded;
  const factory BooksState.error(String message) = _Error;
}

// ✅ DO: Handle all states in UI
state.when(
  initial: () => const SizedBox.shrink(),
  loading: () => const CircularProgressIndicator(),
  loaded: (books) => BookList(books: books),
  error: (message) => ErrorMessage(message: message),
)

// ❌ DON'T: Use mutable state classes
class BadBooksState {
  List<Book>? books; // ❌ Mutable
  bool isLoading = false; // ❌ Mutable
  String? error; // ❌ Mutable
}
```

#### BLoC Implementation
```dart
// ✅ DO: Use dependency injection
class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final GetBooks _getBooks;
  final SearchBooks _searchBooks;
  
  BooksBloc({
    required GetBooks getBooks,
    required SearchBooks searchBooks,
  }) : _getBooks = getBooks,
       _searchBooks = searchBooks,
       super(const BooksState.initial()) {
    on<LoadBooks>(_onLoadBooks);
    on<SearchBooks>(_onSearchBooks);
  }
  
  Future<void> _onLoadBooks(LoadBooks event, Emitter<BooksState> emit) async {
    emit(const BooksState.loading());
    
    final result = await _getBooks(NoParams());
    
    result.fold(
      (failure) => emit(BooksState.error(failure.message)),
      (books) => emit(BooksState.loaded(books)),
    );
  }
}

// ❌ DON'T: Create dependencies inside BLoC
class BadBooksBloc extends Bloc<BooksEvent, BooksState> {
  BadBooksBloc() : super(const BooksState.initial()) {
    // ❌ Creating dependencies here
    final repository = BooksRepositoryImpl(/* ... */);
    final getBooks = GetBooks(repository);
  }
}
```

## Error Handling

### 🚨 Failure Pattern

```dart
// ✅ DO: Use Either pattern for error handling
abstract class Failure extends Equatable {
  const Failure({required this.message, this.statusCode});
  final String message;
  final int? statusCode;
}

class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'Network connection failed',
    super.statusCode,
  });
}

// ✅ DO: Handle errors gracefully
Future<Either<Failure, List<Book>>> getBooks() async {
  try {
    if (await networkInfo.isConnected) {
      final books = await remoteDataSource.getBooks();
      return Right(books);
    } else {
      return const Left(NetworkFailure());
    }
  } on DioException catch (e) {
    return Left(_mapDioExceptionToFailure(e));
  } catch (e) {
    return Left(UnknownFailure(e.toString()));
  }
}

// ❌ DON'T: Ignore errors
Future<List<Book>> getBooksWrong() async {
  final response = await dio.get('/books'); // ❌ Can throw
  return response.data.map((json) => Book.fromJson(json)).toList();
}
```

### 🎯 Error UI Handling

```dart
// ✅ DO: Provide user-friendly error messages
Widget _buildErrorWidget(String error) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Icon(Icons.error_outline, size: 64, color: Colors.red),
      const SizedBox(height: 16),
      Text(
        LocaleKeys.errors.generic,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      const SizedBox(height: 8),
      Text(error, textAlign: TextAlign.center),
      const SizedBox(height: 16),
      ElevatedButton(
        onPressed: () => context.read<BooksBloc>().add(const LoadBooks()),
        child: Text(LocaleKeys.common.retry),
      ),
    ],
  );
}

// ❌ DON'T: Show raw error messages
Text(error) // ❌ Raw error might be technical
```

## Performance Optimization

### 🚀 Widget Performance

```dart
// ✅ DO: Use const constructors
class BookCard extends StatelessWidget {
  const BookCard({super.key, required this.book}); // ✅ const constructor
  
  final Book book;
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          // ✅ const widgets when possible
          const SizedBox(height: 8),
          Text(book.title),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// ✅ DO: Use RepaintBoundary for expensive widgets
RepaintBoundary(
  child: ComplexChart(data: chartData),
)

// ✅ DO: Use ListView.builder for large lists
ListView.builder(
  itemCount: books.length,
  itemBuilder: (context, index) => BookCard(book: books[index]),
)

// ❌ DON'T: Create widgets in build method
Widget build(BuildContext context) {
  return Column(
    children: books.map((book) => BookCard(book: book)).toList(), // ❌ Creates all widgets
  );
}
```

### 📱 Memory Management

```dart
// ✅ DO: Dispose controllers and streams
class BookDetailPage extends StatefulWidget {
  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  late ScrollController _scrollController;
  StreamSubscription? _subscription;
  
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _subscription = someStream.listen(/* ... */);
  }
  
  @override
  void dispose() {
    _scrollController.dispose(); // ✅ Dispose controllers
    _subscription?.cancel(); // ✅ Cancel subscriptions
    super.dispose();
  }
}

// ✅ DO: Use AutomaticKeepAliveClientMixin for expensive widgets
class ExpensiveWidget extends StatefulWidget {
  @override
  _ExpensiveWidgetState createState() => _ExpensiveWidgetState();
}

class _ExpensiveWidgetState extends State<ExpensiveWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // ✅ Keep state alive
  
  @override
  Widget build(BuildContext context) {
    super.build(context); // ✅ Don't forget this
    return ExpensiveChildWidget();
  }
}
```

### 🖼️ Image Optimization

```dart
// ✅ DO: Use CachedNetworkImage
CachedNetworkImage(
  imageUrl: book.imageUrl ?? '',
  placeholder: (context, url) => const CircularProgressIndicator(),
  errorWidget: (context, url, error) => const Icon(Icons.book),
  fit: BoxFit.cover,
  memCacheHeight: 300, // ✅ Resize for memory efficiency
  memCacheWidth: 200,
)

// ✅ DO: Optimize image sizes
Image.asset(
  'assets/images/book_placeholder.png',
  width: 150,
  height: 200,
  fit: BoxFit.cover,
  cacheWidth: 150, // ✅ Cache at display size
  cacheHeight: 200,
)

// ❌ DON'T: Load large images without resizing
Image.network(book.imageUrl) // ❌ No size constraints
```

## Testing Practices

### 🧪 Unit Testing

```dart
// ✅ DO: Test business logic thoroughly
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

// ❌ DON'T: Test implementation details
test('should call http client get method', () async {
  // ❌ Testing internal implementation
  verify(mockHttpClient.get('/books'));
});
```

### 🎯 BLoC Testing

```dart
// ✅ DO: Test all state transitions
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

// ✅ DO: Test error states
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

### 🖼️ Widget Testing

```dart
// ✅ DO: Test widget behavior
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
});

// ✅ DO: Test user interactions
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

## Security Guidelines

### 🔒 Data Protection

```dart
// ✅ DO: Use secure storage for sensitive data
class TokenStorage {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  
  static Future<void> saveToken(String token) async {
    await _storage.write(key: 'auth_token', value: token);
  }
  
  static Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }
  
  static Future<void> deleteToken() async {
    await _storage.delete(key: 'auth_token');
  }
}

// ❌ DON'T: Store sensitive data in plain text
class BadTokenStorage {
  static Future<void> saveToken(String token) async {
    // ❌ Using Hive without encryption for sensitive data
    final box = await Hive.openBox('tokens');
    await box.put('auth_token', token); // ❌ Plain text storage
  }
}
```

### 🌐 Network Security

```dart
// ✅ DO: Use HTTPS only
final dio = Dio(BaseOptions(
  baseUrl: 'https://api.okumanya.com', // ✅ HTTPS
  connectTimeout: Duration(milliseconds: AppConstants.connectTimeout),
  receiveTimeout: Duration(milliseconds: AppConstants.receiveTimeout),
  headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  },
));

// ✅ DO: Validate input data
class BookValidation {
  static bool isValidTitle(String title) {
    return title.trim().isNotEmpty && title.length <= 200;
  }
  
  static bool isValidAuthor(String author) {
    return author.trim().isNotEmpty && author.length <= 100;
  }
}

// ❌ DON'T: Use HTTP in production
final badDio = Dio(BaseOptions(
  baseUrl: 'http://api.okumanya.com', // ❌ Insecure HTTP
));
```

## UI/UX Guidelines

### 🎨 Design Consistency

```dart
// ✅ DO: Use theme colors and styles
Container(
  padding: EdgeInsets.all(AppConstants.defaultPadding),
  decoration: BoxDecoration(
    color: Theme.of(context).colorScheme.surface,
    borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
  ),
  child: Text(
    book.title,
    style: Theme.of(context).textTheme.headlineSmall,
  ),
)

// ❌ DON'T: Use hard-coded colors and styles
Container(
  padding: const EdgeInsets.all(16), // ❌ Hard-coded
  decoration: BoxDecoration(
    color: Colors.white, // ❌ Hard-coded color
    borderRadius: BorderRadius.circular(8),
  ),
  child: Text(
    book.title,
    style: const TextStyle(fontSize: 18), // ❌ Hard-coded style
  ),
)
```

### 📱 Responsive Design

```dart
// ✅ DO: Use responsive measurements
Container(
  width: MediaQuery.of(context).size.width * 0.8, // ✅ Responsive
  height: 200.h, // ✅ Using flutter_screenutil
  child: BookCard(book: book),
)

// ✅ DO: Handle different screen sizes
Widget _buildBookGrid(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final crossAxisCount = screenWidth > 600 ? 3 : 2; // ✅ Adaptive
  
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
    ),
    itemBuilder: (context, index) => BookCard(book: books[index]),
  );
}

// ❌ DON'T: Use fixed sizes for all screens
Container(
  width: 300, // ❌ Fixed width
  height: 400, // ❌ Fixed height
  child: BookCard(book: book),
)
```

### ♿ Accessibility

```dart
// ✅ DO: Add semantic labels
Semantics(
  label: 'Book titled ${book.title} by ${book.author}',
  child: BookCard(book: book),
)

// ✅ DO: Use proper button semantics
ElevatedButton(
  onPressed: () => _addToFavorites(),
  child: Row(
    children: [
      Icon(Icons.favorite),
      SizedBox(width: 8),
      Text(LocaleKeys.books.addToFavorites),
    ],
  ),
)

// ✅ DO: Support different text scales
Text(
  book.title,
  style: Theme.of(context).textTheme.headlineSmall,
  maxLines: 2,
  overflow: TextOverflow.ellipsis, // ✅ Handle text overflow
)

// ❌ DON'T: Ignore accessibility
GestureDetector( // ❌ No semantic information
  onTap: () => _addToFavorites(),
  child: Icon(Icons.favorite),
)
```

## Code Review Guidelines

### ✅ What to Look For

#### Architecture & Design
- [ ] Follows Clean Architecture principles
- [ ] Proper separation of concerns
- [ ] SOLID principles applied
- [ ] Appropriate design patterns used

#### Code Quality
- [ ] Code is readable and self-documenting
- [ ] No code duplication
- [ ] Consistent naming conventions
- [ ] Proper error handling

#### Performance
- [ ] Efficient algorithms used
- [ ] No memory leaks
- [ ] Proper widget optimization
- [ ] Image optimization applied

#### Testing
- [ ] Adequate test coverage
- [ ] Tests are meaningful and not brittle
- [ ] Edge cases considered
- [ ] Mocking done correctly

#### Security
- [ ] No sensitive data in version control
- [ ] Input validation implemented
- [ ] Secure storage for sensitive data
- [ ] HTTPS used for network calls

### 📝 Review Checklist

```markdown
## Code Review Checklist

### Architecture
- [ ] Clean Architecture layers respected
- [ ] Dependencies flow inward
- [ ] Business logic in domain layer
- [ ] UI logic minimal

### Code Quality
- [ ] Code follows style guide
- [ ] No magic numbers or strings
- [ ] Proper error handling
- [ ] Adequate documentation

### Performance
- [ ] Const constructors used
- [ ] Efficient list building
- [ ] Proper image handling
- [ ] No memory leaks

### Testing
- [ ] Unit tests for business logic
- [ ] Widget tests for UI components
- [ ] Error cases tested
- [ ] Edge cases covered

### Security
- [ ] No hardcoded secrets
- [ ] Input validation present
- [ ] Secure data storage
- [ ] Network security implemented

### Repository
- [ ] No generated files committed
- [ ] .gitignore properly configured
- [ ] Code regeneration documented
- [ ] Build artifacts excluded
```

### 💬 Review Comments Examples

```markdown
✅ Good feedback:
"Consider using a const constructor here for better performance."
"This could benefit from error handling for the network call."
"Great use of the Repository pattern here!"

❌ Poor feedback:
"This is wrong."
"Change this."
"I don't like this approach."
```

## Conclusion

Following these best practices ensures:

- **Maintainable Code**: Easy to read, understand, and modify
- **Scalable Architecture**: Can grow with the application
- **Performance**: Optimized for mobile devices
- **Security**: Protected against common vulnerabilities
- **Team Collaboration**: Consistent standards across the team
- **Quality Assurance**: Reduced bugs and issues

Remember: These are guidelines, not strict rules. Use judgment and adapt based on specific requirements and context.