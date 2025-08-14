import 'package:freezed_annotation/freezed_annotation.dart';

part 'books_event.freezed.dart';

/// Events for the Books BLoC using Freezed for immutability
@freezed
class BooksEvent with _$BooksEvent {
  /// Event to load all books
  const factory BooksEvent.loadBooks() = LoadBooks;
  
  /// Event to search books by query
  const factory BooksEvent.searchBooks({required String query}) = SearchBooks;
  
  /// Event to filter books by category
  const factory BooksEvent.filterByCategory({required String category}) = FilterByCategory;
  
  /// Event to load books by category
  const factory BooksEvent.loadBooksByCategory({required String category}) = LoadBooksByCategory;
  
  /// Event to refresh books data
  const factory BooksEvent.refreshBooks() = RefreshBooks;
  
  /// Event to load favorite books
  const factory BooksEvent.loadFavoriteBooks() = LoadFavoriteBooks;
  
  /// Event to load recent books
  const factory BooksEvent.loadRecentBooks() = LoadRecentBooks;
  
  /// Event to toggle book favorite status
  const factory BooksEvent.toggleBookFavorite({required String bookId}) = ToggleBookFavorite;
  
  /// Event to update book progress
  const factory BooksEvent.updateBookProgress({
    required String bookId,
    required double progress,
  }) = UpdateBookProgress;
  
  /// Event to clear search
  const factory BooksEvent.clearSearch() = ClearSearch;
}