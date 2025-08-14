import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/book.dart';
import '../../domain/repositories/books_repository.dart';
import '../datasources/books_remote_data_source.dart';
import '../datasources/books_local_data_source.dart';

/// Implementation of BooksRepository following Clean Architecture principles
@LazySingleton(as: BooksRepository)
class BooksRepositoryImpl implements BooksRepository {
  const BooksRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  final BooksRemoteDataSource remoteDataSource;
  final BooksLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<Book>>> getAllBooks() async {
    try {
      if (await networkInfo.isConnected) {
        // Try to get data from remote source
        try {
          final bookModels = await remoteDataSource.getAllBooks();
          final books = bookModels.map((model) => model.toDomain()).toList();
          
          // Cache the data for offline use
          await localDataSource.cacheBooks(bookModels);
          
          return Right(books);
        } on Exception catch (e) {
          // If remote fails, try to get cached data
          final cachedModels = await localDataSource.getCachedBooks();
          if (cachedModels != null && cachedModels.isNotEmpty) {
            final books = cachedModels.map((model) => model.toDomain()).toList();
            return Right(books);
          }
          return Left(_mapExceptionToFailure(e));
        }
      } else {
        // No internet connection, get cached data
        final cachedModels = await localDataSource.getCachedBooks();
        if (cachedModels != null && cachedModels.isNotEmpty) {
          final books = cachedModels.map((model) => model.toDomain()).toList();
          return Right(books);
        }
        return const Left(NetworkFailure(message: 'No internet connection and no cached data available'));
      }
    } on Exception catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<Book>>> getBooksByCategory(String category) async {
    try {
      if (await networkInfo.isConnected) {
        try {
          final bookModels = await remoteDataSource.getBooksByCategory(category);
          final books = bookModels.map((model) => model.toDomain()).toList();
          
          // Cache the data for offline use
          await localDataSource.cacheBooksByCategory(category, bookModels);
          
          return Right(books);
        } on Exception catch (e) {
          // If remote fails, try to get cached data
          final cachedModels = await localDataSource.getCachedBooksByCategory(category);
          if (cachedModels != null && cachedModels.isNotEmpty) {
            final books = cachedModels.map((model) => model.toDomain()).toList();
            return Right(books);
          }
          return Left(_mapExceptionToFailure(e));
        }
      } else {
        // No internet connection, get cached data
        final cachedModels = await localDataSource.getCachedBooksByCategory(category);
        if (cachedModels != null && cachedModels.isNotEmpty) {
          final books = cachedModels.map((model) => model.toDomain()).toList();
          return Right(books);
        }
        return const Left(NetworkFailure(message: 'No internet connection and no cached data available'));
      }
    } on Exception catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<Book>>> searchBooks(String query) async {
    try {
      if (await networkInfo.isConnected) {
        try {
          final bookModels = await remoteDataSource.searchBooks(query);
          final books = bookModels.map((model) => model.toDomain()).toList();
          
          // Cache the search results
          await localDataSource.cacheSearchResults(query, bookModels);
          
          return Right(books);
        } on Exception catch (e) {
          // If remote fails, try to get cached search results
          final cachedModels = await localDataSource.getCachedSearchResults(query);
          if (cachedModels != null && cachedModels.isNotEmpty) {
            final books = cachedModels.map((model) => model.toDomain()).toList();
            return Right(books);
          }
          return Left(_mapExceptionToFailure(e));
        }
      } else {
        // No internet connection, get cached search results
        final cachedModels = await localDataSource.getCachedSearchResults(query);
        if (cachedModels != null && cachedModels.isNotEmpty) {
          final books = cachedModels.map((model) => model.toDomain()).toList();
          return Right(books);
        }
        return const Left(NetworkFailure(message: 'No internet connection and no cached search results available'));
      }
    } on Exception catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Book>> getBookById(String id) async {
    try {
      if (await networkInfo.isConnected) {
        try {
          final bookModel = await remoteDataSource.getBookById(id);
          
          // Cache the individual book
          await localDataSource.cacheBook(bookModel);
          
          return Right(bookModel.toDomain());
        } on Exception catch (e) {
          // If remote fails, try to get cached book
          final cachedModel = await localDataSource.getCachedBook(id);
          if (cachedModel != null) {
            return Right(cachedModel.toDomain());
          }
          return Left(_mapExceptionToFailure(e));
        }
      } else {
        // No internet connection, get cached book
        final cachedModel = await localDataSource.getCachedBook(id);
        if (cachedModel != null) {
          return Right(cachedModel.toDomain());
        }
        return const Left(NetworkFailure(message: 'No internet connection and book not cached'));
      }
    } on Exception catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Book>> updateBookProgress(String bookId, double progress) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(message: 'No internet connection'));
    }

    try {
      final bookModel = await remoteDataSource.updateBookProgress(bookId, progress);
      return Right(bookModel.toDomain());
    } on Exception catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Book>> toggleBookFavorite(String bookId) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(message: 'No internet connection'));
    }

    try {
      final bookModel = await remoteDataSource.toggleBookFavorite(bookId);
      return Right(bookModel.toDomain());
    } on Exception catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<Book>>> getFavoriteBooks() async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(message: 'No internet connection'));
    }

    try {
      final bookModels = await remoteDataSource.getFavoriteBooks();
      final books = bookModels.map((model) => model.toDomain()).toList();
      return Right(books);
    } on Exception catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<Book>>> getRecentBooks() async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(message: 'No internet connection'));
    }

    try {
      final bookModels = await remoteDataSource.getRecentBooks();
      final books = bookModels.map((model) => model.toDomain()).toList();
      return Right(books);
    } on Exception catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    try {
      if (await networkInfo.isConnected) {
        try {
          final categories = await remoteDataSource.getCategories();
          
          // Cache the categories
          await localDataSource.cacheCategories(categories);
          
          return Right(categories);
        } on Exception catch (e) {
          // If remote fails, try to get cached categories
          final cachedCategories = await localDataSource.getCachedCategories();
          if (cachedCategories != null && cachedCategories.isNotEmpty) {
            return Right(cachedCategories);
          }
          return Left(_mapExceptionToFailure(e));
        }
      } else {
        // No internet connection, get cached categories
        final cachedCategories = await localDataSource.getCachedCategories();
        if (cachedCategories != null && cachedCategories.isNotEmpty) {
          return Right(cachedCategories);
        }
        return const Left(NetworkFailure(message: 'No internet connection and no cached categories available'));
      }
    } on Exception catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  /// Maps exceptions to appropriate failure types
  Failure _mapExceptionToFailure(Exception exception) {
    final message = exception.toString();
    
    if (message.contains('timeout')) {
      return const NetworkFailure(message: 'Request timeout');
    }
    
    if (message.contains('Server error')) {
      // Extract status code if available
      final statusCodeMatch = RegExp(r'\((\d+)\)').firstMatch(message);
      final statusCode = statusCodeMatch != null 
          ? int.tryParse(statusCodeMatch.group(1) ?? '')
          : null;
      
      if (statusCode == 401) {
        return const AuthFailure(message: 'Authentication required');
      } else if (statusCode == 404) {
        return const ServerFailure(message: 'Resource not found');
      } else if (statusCode != null && statusCode >= 500) {
        return ServerFailure(
          message: 'Server error occurred', 
          statusCode: statusCode,
        );
      }
      
      return ServerFailure(
        message: message, 
        statusCode: statusCode,
      );
    }
    
    if (message.contains('No internet connection') || 
        message.contains('Connection timeout')) {
      return const NetworkFailure(message: 'Network connection failed');
    }
    
    return UnexpectedFailure(message: message);
  }
}