import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/get_books.dart';
import '../../domain/usecases/search_books.dart' as use_cases;
import '../../domain/usecases/get_books_by_category.dart';
import 'books_event.dart';
import 'books_state.dart';

/// BLoC for managing books state using Clean Architecture principles
@injectable
class BooksBloc extends Bloc<BooksEvent, BooksState> {
  BooksBloc({
    required GetBooks getBooks,
    required use_cases.SearchBooks searchBooks,
    required GetBooksByCategory getBooksByCategory,
  })  : _getBooks = getBooks,
        _searchBooks = searchBooks,
        _getBooksByCategory = getBooksByCategory,
        super(const BooksState.initial()) {
    on<LoadBooks>(_onLoadBooks);
    on<SearchBooks>(_onSearchBooks);
    on<FilterByCategory>(_onFilterByCategory);
    on<LoadBooksByCategory>(_onLoadBooksByCategory);
    on<RefreshBooks>(_onRefreshBooks);
    on<ClearSearch>(_onClearSearch);
  }

  final GetBooks _getBooks;
  final use_cases.SearchBooks _searchBooks;
  final GetBooksByCategory _getBooksByCategory;

  /// Handles loading all books
  Future<void> _onLoadBooks(LoadBooks event, Emitter<BooksState> emit) async {
    emit(const BooksState.loading());

    final result = await _getBooks();

    result.fold(
      (failure) => emit(BooksState.error(message: failure.message)),
      (books) {
        final categories = _extractCategories(books);
        emit(BooksState.loaded(
          books: books,
          filteredBooks: books,
          categories: categories,
        ));
      },
    );
  }

  /// Handles searching books
  Future<void> _onSearchBooks(
      SearchBooks event, Emitter<BooksState> emit) async {
    if (event.query.trim().isEmpty) {
      add(const BooksEvent.clearSearch());
      return;
    }

    emit(BooksState.searchResults(
      searchResults: [],
      query: event.query,
      isLoading: true,
    ));

    final result =
        await _searchBooks(use_cases.SearchBooksParams(query: event.query));

    result.fold(
      (failure) => emit(BooksState.error(
        message: failure.message,
        searchQuery: event.query,
      )),
      (books) => emit(BooksState.searchResults(
        searchResults: books,
        query: event.query,
        isLoading: false,
      )),
    );
  }

  /// Handles filtering books by category
  void _onFilterByCategory(FilterByCategory event, Emitter<BooksState> emit) {
    state.maybeWhen(
      loaded: (books, filteredBooks, categories, selectedCategory, searchQuery,
          isSearching) {
        final filtered = event.category.isEmpty || event.category == 'All'
            ? books
            : books.where((book) => book.category == event.category).toList();

        emit(BooksState.loaded(
          books: books,
          filteredBooks: filtered,
          categories: categories,
          selectedCategory: event.category,
          searchQuery: searchQuery,
          isSearching: isSearching,
        ));
      },
      orElse: () {
        // If not in loaded state, load books first
        add(const BooksEvent.loadBooks());
      },
    );
  }

  /// Handles loading books by specific category
  Future<void> _onLoadBooksByCategory(
    LoadBooksByCategory event,
    Emitter<BooksState> emit,
  ) async {
    emit(const BooksState.loading());

    final result = await _getBooksByCategory(
      GetBooksByCategoryParams(category: event.category),
    );

    result.fold(
      (failure) => emit(BooksState.error(
        message: failure.message,
        selectedCategory: event.category,
      )),
      (books) {
        final categories = _extractCategories(books);
        emit(BooksState.loaded(
          books: books,
          filteredBooks: books,
          categories: categories,
          selectedCategory: event.category,
        ));
      },
    );
  }

  /// Handles refreshing books data
  Future<void> _onRefreshBooks(
      RefreshBooks event, Emitter<BooksState> emit) async {
    // Keep current category if available
    final currentCategory = state.currentSelectedCategory;

    if (currentCategory.isNotEmpty && currentCategory != 'All') {
      add(BooksEvent.loadBooksByCategory(category: currentCategory));
    } else {
      add(const BooksEvent.loadBooks());
    }
  }

  /// Handles clearing search
  void _onClearSearch(ClearSearch event, Emitter<BooksState> emit) {
    state.maybeWhen(
      loaded: (books, filteredBooks, categories, selectedCategory, searchQuery,
          isSearching) {
        emit(BooksState.loaded(
          books: books,
          filteredBooks: filteredBooks,
          categories: categories,
          selectedCategory: selectedCategory,
          searchQuery: '',
          isSearching: false,
        ));
      },
      searchResults: (_, __, ___) {
        add(const BooksEvent.loadBooks());
      },
      error: (_, selectedCategory, __) {
        if (selectedCategory.isNotEmpty && selectedCategory != 'All') {
          add(BooksEvent.loadBooksByCategory(category: selectedCategory));
        } else {
          add(const BooksEvent.loadBooks());
        }
      },
      orElse: () {
        add(const BooksEvent.loadBooks());
      },
    );
  }

  /// Extracts unique categories from books list
  List<String> _extractCategories(List books) {
    final categorySet = <String>{'All'};
    for (final book in books) {
      if (book.category.isNotEmpty) {
        categorySet.add(book.category);
      }
    }
    return categorySet.toList()..sort();
  }
}
