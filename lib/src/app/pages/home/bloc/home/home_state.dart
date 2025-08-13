part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, error, notfound }

extension HomeStatusX on HomeStatus {
  bool get isInitial => this == HomeStatus.initial;
  bool get isLoading => this == HomeStatus.loading;
  bool get isSuccess => this == HomeStatus.success;
  bool get isError => this == HomeStatus.error;
  bool get isNotFound => this == HomeStatus.notfound;
}

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.books = const [],
    this.filteredBooks = const [],
    this.categories = const [],
    this.selectedCategory = '',
    this.searchQuery = '',
    this.errorMessage = '',
  });

  final HomeStatus status;
  final List<BookModel> books;
  final List<BookModel> filteredBooks;
  final List<String> categories;
  final String selectedCategory;
  final String searchQuery;
  final String errorMessage;

  @override
  List<Object?> get props => [
        status,
        books,
        filteredBooks,
        categories,
        selectedCategory,
        searchQuery,
        errorMessage,
      ];

  HomeState copyWith({
    HomeStatus? status,
    List<BookModel>? books,
    List<BookModel>? filteredBooks,
    List<String>? categories,
    String? selectedCategory,
    String? searchQuery,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      books: books ?? this.books,
      filteredBooks: filteredBooks ?? this.filteredBooks,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// Temporary BookModel for now - should be moved to data layer
class BookModel extends Equatable {
  const BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.imageUrl,
    required this.progress,
  });

  final String id;
  final String title;
  final String author;
  final String category;
  final String imageUrl;
  final double progress;

  @override
  List<Object?> get props => [id, title, author, category, imageUrl, progress];
}
