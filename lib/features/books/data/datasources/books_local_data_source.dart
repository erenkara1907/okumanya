import 'package:injectable/injectable.dart';

import '../../../../core/cache/cache_manager.dart';
import '../models/book_model.dart';

/// Abstract interface for books local data source
abstract class BooksLocalDataSource {
  Future<List<BookModel>?> getCachedBooks();
  Future<void> cacheBooks(List<BookModel> books);
  Future<List<BookModel>?> getCachedBooksByCategory(String category);
  Future<void> cacheBooksByCategory(String category, List<BookModel> books);
  Future<List<BookModel>?> getCachedSearchResults(String query);
  Future<void> cacheSearchResults(String query, List<BookModel> books);
  Future<BookModel?> getCachedBook(String id);
  Future<void> cacheBook(BookModel book);
  Future<List<String>?> getCachedCategories();
  Future<void> cacheCategories(List<String> categories);
  Future<void> clearCache();
}

/// Implementation of BooksLocalDataSource using cache manager
@LazySingleton(as: BooksLocalDataSource)
class BooksLocalDataSourceImpl implements BooksLocalDataSource {
  const BooksLocalDataSourceImpl(this._cacheManager);

  final CacheManager _cacheManager;

  // Cache keys
  static const String _allBooksKey = 'books_all';
  static const String _categoriesKey = 'books_categories';
  static const Duration _defaultExpiry = Duration(hours: 24);

  @override
  Future<List<BookModel>?> getCachedBooks() async {
    try {
      final data = await _cacheManager.retrieve<List<dynamic>>(_allBooksKey);
      if (data == null) return null;
      
      return data.map((json) => BookModel.fromJson(json)).toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheBooks(List<BookModel> books) async {
    final data = books.map((book) => book.toJson()).toList();
    await _cacheManager.store(_allBooksKey, data, expiry: _defaultExpiry);
  }

  @override
  Future<List<BookModel>?> getCachedBooksByCategory(String category) async {
    try {
      final key = 'books_category_$category';
      final data = await _cacheManager.retrieve<List<dynamic>>(key);
      if (data == null) return null;
      
      return data.map((json) => BookModel.fromJson(json)).toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheBooksByCategory(String category, List<BookModel> books) async {
    final key = 'books_category_$category';
    final data = books.map((book) => book.toJson()).toList();
    await _cacheManager.store(key, data, expiry: _defaultExpiry);
  }

  @override
  Future<List<BookModel>?> getCachedSearchResults(String query) async {
    try {
      final key = 'books_search_${query.toLowerCase().replaceAll(' ', '_')}';
      final data = await _cacheManager.retrieve<List<dynamic>>(key);
      if (data == null) return null;
      
      return data.map((json) => BookModel.fromJson(json)).toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheSearchResults(String query, List<BookModel> books) async {
    final key = 'books_search_${query.toLowerCase().replaceAll(' ', '_')}';
    final data = books.map((book) => book.toJson()).toList();
    await _cacheManager.store(key, data, expiry: const Duration(hours: 6)); // Shorter expiry for search
  }

  @override
  Future<BookModel?> getCachedBook(String id) async {
    try {
      final key = 'book_$id';
      final data = await _cacheManager.retrieve<Map<String, dynamic>>(key);
      if (data == null) return null;
      
      return BookModel.fromJson(data);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheBook(BookModel book) async {
    final key = 'book_${book.id}';
    await _cacheManager.store(key, book.toJson(), expiry: _defaultExpiry);
  }

  @override
  Future<List<String>?> getCachedCategories() async {
    try {
      return await _cacheManager.retrieve<List<String>>(_categoriesKey);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheCategories(List<String> categories) async {
    await _cacheManager.store(_categoriesKey, categories, expiry: _defaultExpiry);
  }

  @override
  Future<void> clearCache() async {
    await _cacheManager.clear();
  }
}