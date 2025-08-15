import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';

import 'package:okumanya/core/di/injection.dart';
import 'package:okumanya/core/error/failures.dart';
import 'package:okumanya/features/books/domain/entities/book.dart';
import 'package:okumanya/features/books/domain/repositories/books_repository.dart';
import 'package:okumanya/features/books/domain/usecases/get_books.dart';
import 'package:okumanya/features/books/domain/usecases/search_books.dart';
import 'package:okumanya/features/books/domain/usecases/get_books_by_category.dart';

// Fake Implementation for Testing
class FakeBooksRepository implements BooksRepository {
  final List<Book> books;
  final bool shouldFail;

  FakeBooksRepository({this.books = const [], this.shouldFail = false});

  @override
  Future<Either<Failure, List<Book>>> getAllBooks() async {
    if (shouldFail) {
      return const Left(ServerFailure(message: 'Server error'));
    }
    return Right(books);
  }

  @override
  Future<Either<Failure, List<Book>>> searchBooks(String query) async {
    if (shouldFail) {
      return const Left(NetworkFailure(message: 'Network error'));
    }
    final filtered = books
        .where((book) =>
            book.title.toLowerCase().contains(query.toLowerCase()) ||
            book.author.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return Right(filtered);
  }

  @override
  Future<Either<Failure, List<Book>>> getBooksByCategory(
      String category) async {
    if (shouldFail) {
      return const Left(ServerFailure(message: 'Category not found'));
    }
    final filtered = books.where((book) => book.category == category).toList();
    return Right(filtered);
  }

  @override
  Future<Either<Failure, Book>> getBookById(String id) async {
    if (shouldFail) {
      return const Left(NotFoundFailure(message: 'Book not found'));
    }
    try {
      final book = books.firstWhere((book) => book.id == id);
      return Right(book);
    } catch (e) {
      return const Left(NotFoundFailure(message: 'Book not found'));
    }
  }

  @override
  Future<Either<Failure, Book>> updateBookProgress(
      String bookId, double progress) async {
    if (shouldFail) {
      return const Left(ServerFailure(message: 'Update failed'));
    }
    try {
      final bookIndex = books.indexWhere((book) => book.id == bookId);
      if (bookIndex == -1) {
        return const Left(NotFoundFailure(message: 'Book not found'));
      }
      final updatedBook = books[bookIndex].copyWith(progress: progress);
      return Right(updatedBook);
    } catch (e) {
      return const Left(ServerFailure(message: 'Update failed'));
    }
  }

  @override
  Future<Either<Failure, Book>> toggleBookFavorite(String bookId) async {
    if (shouldFail) {
      return const Left(ServerFailure(message: 'Toggle failed'));
    }
    try {
      final book = books.firstWhere((book) => book.id == bookId);
      final updatedBook = book.copyWith(isFavorite: !book.isFavorite);
      return Right(updatedBook);
    } catch (e) {
      return const Left(NotFoundFailure(message: 'Book not found'));
    }
  }

  @override
  Future<Either<Failure, List<Book>>> getFavoriteBooks() async {
    if (shouldFail) {
      return const Left(ServerFailure(message: 'Server error'));
    }
    final favorites = books.where((book) => book.isFavorite).toList();
    return Right(favorites);
  }

  @override
  Future<Either<Failure, List<Book>>> getRecentBooks() async {
    if (shouldFail) {
      return const Left(ServerFailure(message: 'Server error'));
    }
    final recent = books.where((book) => book.progress > 0).toList();
    return Right(recent);
  }

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    if (shouldFail) {
      return const Left(ServerFailure(message: 'Server error'));
    }
    final categories = books.map((book) => book.category).toSet().toList();
    categories.sort();
    return Right(categories);
  }
}

class FakeGetBooks implements GetBooks {
  final FakeBooksRepository repository;
  FakeGetBooks(this.repository);

  @override
  Future<Either<Failure, List<Book>>> call() => repository.getAllBooks();
}

class FakeSearchBooks implements SearchBooks {
  final FakeBooksRepository repository;
  FakeSearchBooks(this.repository);

  @override
  Future<Either<Failure, List<Book>>> call(SearchBooksParams params) =>
      repository.searchBooks(params.query);
}

class FakeGetBooksByCategory implements GetBooksByCategory {
  final FakeBooksRepository repository;
  FakeGetBooksByCategory(this.repository);

  @override
  Future<Either<Failure, List<Book>>> call(GetBooksByCategoryParams params) =>
      repository.getBooksByCategory(params.category);
}

void main() {
  group('Test Helpers', () {
    final testBooks = [
      const Book(
        id: '1',
        title: 'Test Book 1',
        author: 'Test Author 1',
        category: 'Fiction',
        progress: 0.5,
      ),
      const Book(
        id: '2',
        title: 'Test Book 2',
        author: 'Test Author 2',
        category: 'Science',
        progress: 0.0,
      ),
    ];

    group('FakeBooksRepository', () {
      test('returns books when getAllBooks is called', () async {
        final repository = FakeBooksRepository(books: testBooks);
        final result = await repository.getAllBooks();

        expect(result, isA<Right<Failure, List<Book>>>());
        expect(result.fold((l) => null, (r) => r), equals(testBooks));
      });

      test('returns failure when shouldFail is true', () async {
        final repository = FakeBooksRepository(shouldFail: true);
        final result = await repository.getAllBooks();

        expect(result, isA<Left<Failure, List<Book>>>());
      });

      test('filters books by search query', () async {
        final repository = FakeBooksRepository(books: testBooks);
        final result = await repository.searchBooks('Test Book 1');

        expect(result, isA<Right<Failure, List<Book>>>());
        final books = result.fold((l) => <Book>[], (r) => r);
        expect(books.length, equals(1));
        expect(books.first.title, equals('Test Book 1'));
      });

      test('filters books by category', () async {
        final repository = FakeBooksRepository(books: testBooks);
        final result = await repository.getBooksByCategory('Fiction');

        expect(result, isA<Right<Failure, List<Book>>>());
        final books = result.fold((l) => <Book>[], (r) => r);
        expect(books.length, equals(1));
        expect(books.first.category, equals('Fiction'));
      });
    });

    group('Fake Use Cases', () {
      late FakeBooksRepository repository;

      setUp(() {
        repository = FakeBooksRepository(books: testBooks);
      });

      test('FakeGetBooks works correctly', () async {
        final useCase = FakeGetBooks(repository);
        final result = await useCase();

        expect(result, isA<Right<Failure, List<Book>>>());
        expect(result.fold((l) => null, (r) => r), equals(testBooks));
      });

      test('FakeSearchBooks works correctly', () async {
        final useCase = FakeSearchBooks(repository);
        final result = await useCase(const SearchBooksParams(query: 'Test'));

        expect(result, isA<Right<Failure, List<Book>>>());
      });

      test('FakeGetBooksByCategory works correctly', () async {
        final useCase = FakeGetBooksByCategory(repository);
        final result =
            await useCase(const GetBooksByCategoryParams(category: 'Fiction'));

        expect(result, isA<Right<Failure, List<Book>>>());
      });
    });
  });
}

/// Sets up test dependencies by registering fake services
Future<void> setupTestDependencies() async {
  // Reset GetIt instance before each test
  await getIt.reset();

  final testBooks = [
    const Book(
      id: '1',
      title: 'Test Book 1',
      author: 'Test Author 1',
      category: 'Fiction',
      progress: 0.5,
    ),
    const Book(
      id: '2',
      title: 'Test Book 2',
      author: 'Test Author 2',
      category: 'Science',
      progress: 0.0,
    ),
  ];

  final repository = FakeBooksRepository(books: testBooks);

  // Register fake dependencies
  getIt.registerLazySingleton<BooksRepository>(() => repository);
  getIt.registerLazySingleton<GetBooks>(() => FakeGetBooks(repository));
  getIt.registerLazySingleton<SearchBooks>(() => FakeSearchBooks(repository));
  getIt.registerLazySingleton<GetBooksByCategory>(
      () => FakeGetBooksByCategory(repository));
}

/// Cleans up test dependencies after each test
Future<void> tearDownTestDependencies() async {
  await getIt.reset();
}
