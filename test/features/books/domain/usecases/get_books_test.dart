import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:okumanya/core/error/failures.dart';
import 'package:okumanya/features/books/domain/entities/book.dart';
import 'package:okumanya/features/books/domain/repositories/books_repository.dart';
import 'package:okumanya/features/books/domain/usecases/get_books.dart';

import 'get_books_test.mocks.dart';

@GenerateNiceMocks([MockSpec<BooksRepository>()])
void main() {
  late GetBooks usecase;
  late MockBooksRepository mockBooksRepository;

  setUp(() {
    mockBooksRepository = MockBooksRepository();
    usecase = GetBooks(mockBooksRepository);
  });

  group('GetBooks', () {
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

    test('should get books from the repository', () async {
      // Arrange
      when(mockBooksRepository.getAllBooks())
          .thenAnswer((_) async => Right(tBooks));

      // Act
      final result = await usecase();

      // Assert
      expect(result, equals(Right(tBooks)));
      verify(mockBooksRepository.getAllBooks()).called(1);
      verifyNoMoreInteractions(mockBooksRepository);
    });

    test('should return failure when repository call fails', () async {
      // Arrange
      const tFailure = ServerFailure(message: 'Server Error');
      when(mockBooksRepository.getAllBooks())
          .thenAnswer((_) async => const Left(tFailure));

      // Act
      final result = await usecase();

      // Assert
      expect(result, equals(const Left(tFailure)));
      verify(mockBooksRepository.getAllBooks()).called(1);
      verifyNoMoreInteractions(mockBooksRepository);
    });
  });
}