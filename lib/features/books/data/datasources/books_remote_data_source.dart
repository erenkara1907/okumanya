import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../models/book_model.dart';

/// Abstract interface for books remote data source
abstract class BooksRemoteDataSource {
  Future<List<BookModel>> getAllBooks();
  Future<List<BookModel>> getBooksByCategory(String category);
  Future<List<BookModel>> searchBooks(String query);
  Future<BookModel> getBookById(String id);
  Future<BookModel> updateBookProgress(String bookId, double progress);
  Future<BookModel> toggleBookFavorite(String bookId);
  Future<List<BookModel>> getFavoriteBooks();
  Future<List<BookModel>> getRecentBooks();
  Future<List<String>> getCategories();
}

/// Implementation of BooksRemoteDataSource using Dio
@LazySingleton(as: BooksRemoteDataSource)
class BooksRemoteDataSourceImpl implements BooksRemoteDataSource {
  const BooksRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<BookModel>> getAllBooks() async {
    try {
      final response = await _dio.get('/books');
      final List<dynamic> jsonList = response.data['data'] ?? response.data;
      return jsonList.map((json) => BookModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  @override
  Future<List<BookModel>> getBooksByCategory(String category) async {
    try {
      final response =
          await _dio.get('/books', queryParameters: {'category': category});
      final List<dynamic> jsonList = response.data['data'] ?? response.data;
      return jsonList.map((json) => BookModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  @override
  Future<List<BookModel>> searchBooks(String query) async {
    try {
      final response =
          await _dio.get('/books/search', queryParameters: {'q': query});
      final List<dynamic> jsonList = response.data['data'] ?? response.data;
      return jsonList.map((json) => BookModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  @override
  Future<BookModel> getBookById(String id) async {
    try {
      final response = await _dio.get('/books/$id');
      final Map<String, dynamic> json = response.data['data'] ?? response.data;
      return BookModel.fromJson(json);
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  @override
  Future<BookModel> updateBookProgress(String bookId, double progress) async {
    try {
      final response = await _dio
          .patch('/books/$bookId/progress', data: {'progress': progress});
      final Map<String, dynamic> json = response.data['data'] ?? response.data;
      return BookModel.fromJson(json);
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  @override
  Future<BookModel> toggleBookFavorite(String bookId) async {
    try {
      final response = await _dio.post('/books/$bookId/favorite');
      final Map<String, dynamic> json = response.data['data'] ?? response.data;
      return BookModel.fromJson(json);
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  @override
  Future<List<BookModel>> getFavoriteBooks() async {
    try {
      final response = await _dio.get('/books/favorites');
      final List<dynamic> jsonList = response.data['data'] ?? response.data;
      return jsonList.map((json) => BookModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  @override
  Future<List<BookModel>> getRecentBooks() async {
    try {
      final response = await _dio.get('/books/recent');
      final List<dynamic> jsonList = response.data['data'] ?? response.data;
      return jsonList.map((json) => BookModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  @override
  Future<List<String>> getCategories() async {
    try {
      final response = await _dio.get('/books/categories');
      final List<dynamic> jsonList = response.data['data'] ?? response.data;
      return jsonList.cast<String>();
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  Exception _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('Connection timeout');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = e.response?.data?['message'] ?? 'Server error';
        return Exception('Server error ($statusCode): $message');
      case DioExceptionType.cancel:
        return Exception('Request cancelled');
      case DioExceptionType.connectionError:
        return Exception('No internet connection');
      default:
        return Exception('Unknown error occurred');
    }
  }
}
