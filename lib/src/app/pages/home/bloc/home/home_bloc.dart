import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:okumanya/src/shared/error/global_error_handler.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<LoadBooks>(_onLoadBooks);
    on<SearchBooks>(_onSearchBooks);
    on<FilterBooks>(_onFilterBooks);
  }

  Future<void> _onLoadBooks(LoadBooks event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));

    try {
      // Mock data for now - replace with actual API call
      await Future.delayed(const Duration(milliseconds: 500));

      final mockBooks = [
        const BookModel(
          id: '1',
          title: 'Flutter Development',
          author: 'John Doe',
          category: 'Programming',
          imageUrl: 'assets/images/book3.png',
          progress: 0.3,
        ),
        const BookModel(
          id: '2',
          title: 'Dart Language Guide',
          author: 'Jane Smith',
          category: 'Programming',
          imageUrl: 'assets/images/book4.png',
          progress: 0.7,
        ),
        const BookModel(
          id: '3',
          title: 'Physics Fundamentals',
          author: 'Albert Einstein',
          category: 'Science',
          imageUrl: 'assets/images/book3.png',
          progress: 0.5,
        ),
      ];

      final categories = ['All', 'Programming', 'Science', 'Fiction'];

      emit(state.copyWith(
        status: HomeStatus.success,
        books: mockBooks,
        filteredBooks: mockBooks,
        categories: categories,
      ));
    } catch (e) {
      GlobalErrorHandler.handleError(e);
      emit(state.copyWith(
        status: HomeStatus.error,
        errorMessage: 'home.errorLoadingBooks'.tr(),
      ));
    }
  }

  Future<void> _onSearchBooks(SearchBooks event, Emitter<HomeState> emit) async {
    final query = event.query.toLowerCase();

    if (query.isEmpty) {
      emit(state.copyWith(
        filteredBooks: state.books,
        searchQuery: query,
      ));
      return;
    }

    final filteredBooks = state.books.where((book) {
      return book.title.toLowerCase().contains(query) || book.author.toLowerCase().contains(query);
    }).toList();

    emit(state.copyWith(
      filteredBooks: filteredBooks,
      searchQuery: query,
    ));
  }

  Future<void> _onFilterBooks(FilterBooks event, Emitter<HomeState> emit) async {
    final category = event.category;

    List<BookModel> filteredBooks;
    if (category == 'All' || category.isEmpty) {
      filteredBooks = state.books;
    } else {
      filteredBooks = state.books.where((book) {
        return book.category == category;
      }).toList();
    }

    // Apply search query if exists
    if (state.searchQuery.isNotEmpty) {
      final query = state.searchQuery.toLowerCase();
      filteredBooks = filteredBooks.where((book) {
        return book.title.toLowerCase().contains(query) || book.author.toLowerCase().contains(query);
      }).toList();
    }

    emit(state.copyWith(
      filteredBooks: filteredBooks,
      selectedCategory: category,
    ));
  }
}
