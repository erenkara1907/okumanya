import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/book.dart';

/// Abstract repository interface for books operations
/// This follows the Repository pattern and Dependency Inversion Principle
abstract class BooksRepository {
  /// Retrieves all books from the data source
  Future<Either<Failure, List<Book>>> getAllBooks();

  /// Retrieves books by category
  Future<Either<Failure, List<Book>>> getBooksByCategory(String category);

  /// Searches books by query (title or author)
  Future<Either<Failure, List<Book>>> searchBooks(String query);

  /// Retrieves a single book by ID
  Future<Either<Failure, Book>> getBookById(String id);

  /// Updates book progress
  Future<Either<Failure, Book>> updateBookProgress(String bookId, double progress);

  /// Toggles book favorite status
  Future<Either<Failure, Book>> toggleBookFavorite(String bookId);

  /// Retrieves user's favorite books
  Future<Either<Failure, List<Book>>> getFavoriteBooks();

  /// Retrieves recently read books
  Future<Either<Failure, List<Book>>> getRecentBooks();

  /// Retrieves book categories
  Future<Either<Failure, List<String>>> getCategories();
}