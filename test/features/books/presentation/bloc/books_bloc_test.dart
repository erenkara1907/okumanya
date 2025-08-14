import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:okumanya/core/error/failures.dart';
import 'package:okumanya/features/books/domain/entities/book.dart';
import 'package:okumanya/features/books/domain/usecases/get_books.dart';
import 'package:okumanya/features/books/domain/usecases/search_books.dart' as use_cases;
import 'package:okumanya/features/books/domain/usecases/get_books_by_category.dart';
import 'package:okumanya/features/books/presentation/bloc/books_bloc.dart';
import 'package:okumanya/features/books/presentation/bloc/books_event.dart';
import 'package:okumanya/features/books/presentation/bloc/books_state.dart';

import 'books_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GetBooks>(),
  MockSpec<use_cases.SearchBooks>(),
  MockSpec<GetBooksByCategory>(),
])
void main() {
  late BooksBloc bloc;
  late MockGetBooks mockGetBooks;
  late MockSearchBooks mockSearchBooks;
  late MockGetBooksByCategory mockGetBooksByCategory;

  setUp(() {
    mockGetBooks = MockGetBooks();
    mockSearchBooks = MockSearchBooks();
    mockGetBooksByCategory = MockGetBooksByCategory();
    bloc = BooksBloc(
      getBooks: mockGetBooks,
      searchBooks: mockSearchBooks,
      getBooksByCategory: mockGetBooksByCategory,
    );
  });

  tearDown(() {
    bloc.close();
  });

  group('BooksBloc', () {
    final tBooks = [
      const Book(
        id: '1',
        title: 'Test Book 1',
        author: 'Author 1',
        category: 'Fiction',
      ),
      const Book(
        id: '2',
        title: 'Test Book 2',
        author: 'Author 2',
        category: 'Science',
      ),
    ];

    test('initial state should be Initial', () {
      expect(bloc.state, equals(const BooksState.initial()));
    });

    group('LoadBooks', () {
      blocTest<BooksBloc, BooksState>(
        'emits [loading, loaded] when LoadBooks succeeds',
        build: () {
          when(mockGetBooks()).thenAnswer((_) async => Right(tBooks));
          return bloc;
        },
        act: (bloc) => bloc.add(const BooksEvent.loadBooks()),
        expect: () => [
          const BooksState.loading(),
          BooksState.loaded(
            books: tBooks,
            filteredBooks: tBooks,
            categories: const ['All', 'Fiction', 'Science'],
          ),
        ],
        verify: (_) {
          verify(mockGetBooks()).called(1);
        },
      );

      blocTest<BooksBloc, BooksState>(
        'emits [loading, error] when LoadBooks fails',
        build: () {
          when(mockGetBooks()).thenAnswer(
            (_) async => const Left(ServerFailure(message: 'Server Error')),
          );
          return bloc;
        },
        act: (bloc) => bloc.add(const BooksEvent.loadBooks()),
        expect: () => [
          const BooksState.loading(),
          const BooksState.error(message: 'Server Error'),
        ],
        verify: (_) {
          verify(mockGetBooks()).called(1);
        },
      );
    });

    group('SearchBooks', () {
      const tQuery = 'test query';
      final tSearchResults = [tBooks[0]];

      blocTest<BooksBloc, BooksState>(
        'emits [searchResults loading, searchResults] when SearchBooks succeeds',
        build: () {
          when(mockSearchBooks(
            const use_cases.SearchBooksParams(query: tQuery),
          )).thenAnswer(
            (_) async => Right(tSearchResults),
          );
          return bloc;
        },
        act: (bloc) => bloc.add(const BooksEvent.searchBooks(query: tQuery)),
        expect: () => [
          const BooksState.searchResults(
            searchResults: [],
            query: tQuery,
            isLoading: true,
          ),
          BooksState.searchResults(
            searchResults: tSearchResults,
            query: tQuery,
            isLoading: false,
          ),
        ],
        verify: (_) {
          verify(mockSearchBooks(
            const use_cases.SearchBooksParams(query: tQuery),
          )).called(1);
        },
      );

      blocTest<BooksBloc, BooksState>(
        'calls clearSearch when query is empty',
        build: () => bloc,
        act: (bloc) => bloc.add(const BooksEvent.searchBooks(query: '')),
        expect: () => [],
      );
    });

    group('FilterByCategory', () {
      const tCategory = 'Fiction';

      blocTest<BooksBloc, BooksState>(
        'filters books by category when in loaded state',
        build: () => bloc,
        seed: () => BooksState.loaded(
          books: tBooks,
          filteredBooks: tBooks,
          categories: const ['All', 'Fiction', 'Science'],
        ),
        act: (bloc) => bloc.add(
          const BooksEvent.filterByCategory(category: tCategory),
        ),
        expect: () => [
          BooksState.loaded(
            books: tBooks,
            filteredBooks: [tBooks[0]], // Only Fiction book
            categories: const ['All', 'Fiction', 'Science'],
            selectedCategory: tCategory,
          ),
        ],
      );
    });
  });
}