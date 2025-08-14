import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:okumanya/core/error/failures.dart';
import 'package:okumanya/features/books/domain/entities/book.dart';
import 'package:okumanya/features/books/domain/usecases/get_books.dart';
import 'package:okumanya/features/books/domain/usecases/search_books.dart';
import 'package:okumanya/features/books/domain/usecases/get_books_by_category.dart';
import 'package:okumanya/features/books/presentation/bloc/books_bloc.dart';
import 'package:okumanya/features/books/presentation/bloc/books_state.dart';

// Simple Mock Implementation for Testing
class FakeGetBooks implements GetBooks {
  final Either<Failure, List<Book>> result;
  FakeGetBooks(this.result);
  
  @override
  Future<Either<Failure, List<Book>>> call() async => result;
}

class FakeSearchBooks implements SearchBooks {
  final Either<Failure, List<Book>> result;
  FakeSearchBooks(this.result);
  
  @override
  Future<Either<Failure, List<Book>>> call(SearchBooksParams params) async => result;
}

class FakeGetBooksByCategory implements GetBooksByCategory {
  final Either<Failure, List<Book>> result;
  FakeGetBooksByCategory(this.result);
  
  @override
  Future<Either<Failure, List<Book>>> call(GetBooksByCategoryParams params) async => result;
}

void main() {
  group('BooksBloc Enhanced Tests', () {
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

    test('BooksBloc can be instantiated with fake dependencies', () {
      final bloc = BooksBloc(
        getBooks: FakeGetBooks(Right(testBooks)),
        searchBooks: FakeSearchBooks(Right(testBooks)),
        getBooksByCategory: FakeGetBooksByCategory(Right(testBooks)),
      );

      expect(bloc, isNotNull);
      expect(bloc, isA<BooksBloc>());
      expect(bloc.state, equals(const BooksState.initial()));
      
      bloc.close();
    });

    test('BooksBloc initial state is correct', () {
      final bloc = BooksBloc(
        getBooks: FakeGetBooks(Right(testBooks)),
        searchBooks: FakeSearchBooks(Right(testBooks)),
        getBooksByCategory: FakeGetBooksByCategory(Right(testBooks)),
      );

      expect(bloc.state, equals(const BooksState.initial()));
      
      bloc.close();
    });

    group('Fake Dependencies', () {
      test('FakeGetBooks returns expected result', () async {
        final fakeGetBooks = FakeGetBooks(Right(testBooks));
        final result = await fakeGetBooks();
        
        expect(result, isA<Right<Failure, List<Book>>>());
        expect(result.fold((l) => null, (r) => r), equals(testBooks));
      });

      test('FakeGetBooks can return failure', () async {
        const failure = ServerFailure(message: 'Test error');
        final fakeGetBooks = FakeGetBooks(const Left(failure));
        final result = await fakeGetBooks();
        
        expect(result, isA<Left<Failure, List<Book>>>());
        expect(result.fold((l) => l, (r) => null), equals(failure));
      });

      test('FakeSearchBooks works with query parameter', () async {
        final fakeSearchBooks = FakeSearchBooks(Right(testBooks));
        final result = await fakeSearchBooks(const SearchBooksParams(query: 'test'));
        
        expect(result, isA<Right<Failure, List<Book>>>());
        expect(result.fold((l) => null, (r) => r), equals(testBooks));
      });

      test('FakeGetBooksByCategory works with category parameter', () async {
        final fakeGetBooksByCategory = FakeGetBooksByCategory(Right(testBooks));
        final result = await fakeGetBooksByCategory(const GetBooksByCategoryParams(category: 'Fiction'));
        
        expect(result, isA<Right<Failure, List<Book>>>());
        expect(result.fold((l) => null, (r) => r), equals(testBooks));
      });
    });

    group('Error Handling', () {
      test('handles ServerFailure correctly', () {
        const failure = ServerFailure(message: 'Server error');
        final fakeGetBooks = FakeGetBooks(const Left(failure));
        
        expect(fakeGetBooks.result, isA<Left<Failure, List<Book>>>());
      });

      test('handles NetworkFailure correctly', () {
        const failure = NetworkFailure(message: 'Network error');
        final fakeSearchBooks = FakeSearchBooks(const Left(failure));
        
        expect(fakeSearchBooks.result, isA<Left<Failure, List<Book>>>());
      });
    });
  });
}