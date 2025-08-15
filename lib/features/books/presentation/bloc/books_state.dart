import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/book.dart';

part 'books_state.freezed.dart';

/// States for the Books BLoC using Freezed for immutability and sealed unions
@freezed
class BooksState with _$BooksState {
  /// Initial state
  const factory BooksState.initial() = Initial;

  /// Loading state
  const factory BooksState.loading() = Loading;

  /// Loaded state with books data
  const factory BooksState.loaded({
    required List<Book> books,
    required List<Book> filteredBooks,
    required List<String> categories,
    @Default('') String selectedCategory,
    @Default('') String searchQuery,
    @Default(false) bool isSearching,
  }) = Loaded;

  /// Error state
  const factory BooksState.error({
    required String message,
    @Default('') String selectedCategory,
    @Default('') String searchQuery,
  }) = Error;

  /// Search results state
  const factory BooksState.searchResults({
    required List<Book> searchResults,
    required String query,
    @Default(false) bool isLoading,
  }) = SearchResults;

  /// Favorites loaded state
  const factory BooksState.favoritesLoaded({
    required List<Book> favoriteBooks,
  }) = FavoritesLoaded;

  /// Recent books loaded state
  const factory BooksState.recentBooksLoaded({
    required List<Book> recentBooks,
  }) = RecentBooksLoaded;

  /// Book updated state (for progress or favorite updates)
  const factory BooksState.bookUpdated({
    required Book updatedBook,
    required List<Book> books,
    required List<Book> filteredBooks,
    required List<String> categories,
    @Default('') String selectedCategory,
    @Default('') String searchQuery,
  }) = BookUpdated;
}

/// Extension to provide convenient getters for BooksState
extension BooksStateX on BooksState {
  /// Returns true if the state is loading
  bool get isLoading => maybeWhen(
        loading: () => true,
        searchResults: (_, __, isLoading) => isLoading,
        orElse: () => false,
      );

  /// Returns true if the state has an error
  bool get hasError => maybeWhen(
        error: (_, __, ___) => true,
        orElse: () => false,
      );

  /// Returns the error message if available
  String? get errorMessage => maybeWhen(
        error: (message, _, __) => message,
        orElse: () => null,
      );

  /// Returns the current books list
  List<Book> get currentBooks => maybeWhen(
        loaded: (books, _, __, ___, ____, _____) => books,
        bookUpdated: (_, books, __, ___, ____, _____) => books,
        searchResults: (results, _, __) => results,
        favoritesLoaded: (favorites) => favorites,
        recentBooksLoaded: (recent) => recent,
        orElse: () => [],
      );

  /// Returns the current filtered books list
  List<Book> get currentFilteredBooks => maybeWhen(
        loaded: (_, filteredBooks, __, ___, ____, _____) => filteredBooks,
        bookUpdated: (_, __, filteredBooks, ___, ____, _____) => filteredBooks,
        orElse: () => currentBooks,
      );

  /// Returns the current search query
  String get currentSearchQuery => maybeWhen(
        loaded: (_, __, ___, ____, searchQuery, _____) => searchQuery,
        error: (_, __, searchQuery) => searchQuery,
        bookUpdated: (_, __, ___, ____, _____, searchQuery) => searchQuery,
        searchResults: (_, query, __) => query,
        orElse: () => '',
      );

  /// Returns the current selected category
  String get currentSelectedCategory => maybeWhen(
        loaded: (_, __, ___, selectedCategory, ____, _____) => selectedCategory,
        error: (_, selectedCategory, __) => selectedCategory,
        bookUpdated: (_, __, ___, ____, selectedCategory, _____) =>
            selectedCategory,
        orElse: () => '',
      );
}
