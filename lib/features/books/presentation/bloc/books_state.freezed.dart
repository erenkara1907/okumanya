// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'books_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BooksState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery,
            bool isSearching)
        loaded,
    required TResult Function(
            String message, String selectedCategory, String searchQuery)
        error,
    required TResult Function(
            List<Book> searchResults, String query, bool isLoading)
        searchResults,
    required TResult Function(List<Book> favoriteBooks) favoritesLoaded,
    required TResult Function(List<Book> recentBooks) recentBooksLoaded,
    required TResult Function(
            Book updatedBook,
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery)
        bookUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery,
            bool isSearching)?
        loaded,
    TResult? Function(
            String message, String selectedCategory, String searchQuery)?
        error,
    TResult? Function(List<Book> searchResults, String query, bool isLoading)?
        searchResults,
    TResult? Function(List<Book> favoriteBooks)? favoritesLoaded,
    TResult? Function(List<Book> recentBooks)? recentBooksLoaded,
    TResult? Function(
            Book updatedBook,
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery)?
        bookUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery,
            bool isSearching)?
        loaded,
    TResult Function(
            String message, String selectedCategory, String searchQuery)?
        error,
    TResult Function(List<Book> searchResults, String query, bool isLoading)?
        searchResults,
    TResult Function(List<Book> favoriteBooks)? favoritesLoaded,
    TResult Function(List<Book> recentBooks)? recentBooksLoaded,
    TResult Function(
            Book updatedBook,
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery)?
        bookUpdated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
    required TResult Function(Error value) error,
    required TResult Function(SearchResults value) searchResults,
    required TResult Function(FavoritesLoaded value) favoritesLoaded,
    required TResult Function(RecentBooksLoaded value) recentBooksLoaded,
    required TResult Function(BookUpdated value) bookUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(Error value)? error,
    TResult? Function(SearchResults value)? searchResults,
    TResult? Function(FavoritesLoaded value)? favoritesLoaded,
    TResult? Function(RecentBooksLoaded value)? recentBooksLoaded,
    TResult? Function(BookUpdated value)? bookUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    TResult Function(Error value)? error,
    TResult Function(SearchResults value)? searchResults,
    TResult Function(FavoritesLoaded value)? favoritesLoaded,
    TResult Function(RecentBooksLoaded value)? recentBooksLoaded,
    TResult Function(BookUpdated value)? bookUpdated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BooksStateCopyWith<$Res> {
  factory $BooksStateCopyWith(
          BooksState value, $Res Function(BooksState) then) =
      _$BooksStateCopyWithImpl<$Res, BooksState>;
}

/// @nodoc
class _$BooksStateCopyWithImpl<$Res, $Val extends BooksState>
    implements $BooksStateCopyWith<$Res> {
  _$BooksStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$BooksStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'BooksState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery,
            bool isSearching)
        loaded,
    required TResult Function(
            String message, String selectedCategory, String searchQuery)
        error,
    required TResult Function(
            List<Book> searchResults, String query, bool isLoading)
        searchResults,
    required TResult Function(List<Book> favoriteBooks) favoritesLoaded,
    required TResult Function(List<Book> recentBooks) recentBooksLoaded,
    required TResult Function(
            Book updatedBook,
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery)
        bookUpdated,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery,
            bool isSearching)?
        loaded,
    TResult? Function(
            String message, String selectedCategory, String searchQuery)?
        error,
    TResult? Function(List<Book> searchResults, String query, bool isLoading)?
        searchResults,
    TResult? Function(List<Book> favoriteBooks)? favoritesLoaded,
    TResult? Function(List<Book> recentBooks)? recentBooksLoaded,
    TResult? Function(
            Book updatedBook,
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery)?
        bookUpdated,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery,
            bool isSearching)?
        loaded,
    TResult Function(
            String message, String selectedCategory, String searchQuery)?
        error,
    TResult Function(List<Book> searchResults, String query, bool isLoading)?
        searchResults,
    TResult Function(List<Book> favoriteBooks)? favoritesLoaded,
    TResult Function(List<Book> recentBooks)? recentBooksLoaded,
    TResult Function(
            Book updatedBook,
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery)?
        bookUpdated,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
    required TResult Function(Error value) error,
    required TResult Function(SearchResults value) searchResults,
    required TResult Function(FavoritesLoaded value) favoritesLoaded,
    required TResult Function(RecentBooksLoaded value) recentBooksLoaded,
    required TResult Function(BookUpdated value) bookUpdated,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(Error value)? error,
    TResult? Function(SearchResults value)? searchResults,
    TResult? Function(FavoritesLoaded value)? favoritesLoaded,
    TResult? Function(RecentBooksLoaded value)? recentBooksLoaded,
    TResult? Function(BookUpdated value)? bookUpdated,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    TResult Function(Error value)? error,
    TResult Function(SearchResults value)? searchResults,
    TResult Function(FavoritesLoaded value)? favoritesLoaded,
    TResult Function(RecentBooksLoaded value)? recentBooksLoaded,
    TResult Function(BookUpdated value)? bookUpdated,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class Initial implements BooksState {
  const factory Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$BooksStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingImpl implements Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'BooksState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery,
            bool isSearching)
        loaded,
    required TResult Function(
            String message, String selectedCategory, String searchQuery)
        error,
    required TResult Function(
            List<Book> searchResults, String query, bool isLoading)
        searchResults,
    required TResult Function(List<Book> favoriteBooks) favoritesLoaded,
    required TResult Function(List<Book> recentBooks) recentBooksLoaded,
    required TResult Function(
            Book updatedBook,
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery)
        bookUpdated,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery,
            bool isSearching)?
        loaded,
    TResult? Function(
            String message, String selectedCategory, String searchQuery)?
        error,
    TResult? Function(List<Book> searchResults, String query, bool isLoading)?
        searchResults,
    TResult? Function(List<Book> favoriteBooks)? favoritesLoaded,
    TResult? Function(List<Book> recentBooks)? recentBooksLoaded,
    TResult? Function(
            Book updatedBook,
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery)?
        bookUpdated,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery,
            bool isSearching)?
        loaded,
    TResult Function(
            String message, String selectedCategory, String searchQuery)?
        error,
    TResult Function(List<Book> searchResults, String query, bool isLoading)?
        searchResults,
    TResult Function(List<Book> favoriteBooks)? favoritesLoaded,
    TResult Function(List<Book> recentBooks)? recentBooksLoaded,
    TResult Function(
            Book updatedBook,
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery)?
        bookUpdated,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
    required TResult Function(Error value) error,
    required TResult Function(SearchResults value) searchResults,
    required TResult Function(FavoritesLoaded value) favoritesLoaded,
    required TResult Function(RecentBooksLoaded value) recentBooksLoaded,
    required TResult Function(BookUpdated value) bookUpdated,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(Error value)? error,
    TResult? Function(SearchResults value)? searchResults,
    TResult? Function(FavoritesLoaded value)? favoritesLoaded,
    TResult? Function(RecentBooksLoaded value)? recentBooksLoaded,
    TResult? Function(BookUpdated value)? bookUpdated,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    TResult Function(Error value)? error,
    TResult Function(SearchResults value)? searchResults,
    TResult Function(FavoritesLoaded value)? favoritesLoaded,
    TResult Function(RecentBooksLoaded value)? recentBooksLoaded,
    TResult Function(BookUpdated value)? bookUpdated,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class Loading implements BooksState {
  const factory Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<Book> books,
      List<Book> filteredBooks,
      List<String> categories,
      String selectedCategory,
      String searchQuery,
      bool isSearching});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$BooksStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? books = null,
    Object? filteredBooks = null,
    Object? categories = null,
    Object? selectedCategory = null,
    Object? searchQuery = null,
    Object? isSearching = null,
  }) {
    return _then(_$LoadedImpl(
      books: null == books
          ? _value._books
          : books // ignore: cast_nullable_to_non_nullable
              as List<Book>,
      filteredBooks: null == filteredBooks
          ? _value._filteredBooks
          : filteredBooks // ignore: cast_nullable_to_non_nullable
              as List<Book>,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      selectedCategory: null == selectedCategory
          ? _value.selectedCategory
          : selectedCategory // ignore: cast_nullable_to_non_nullable
              as String,
      searchQuery: null == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String,
      isSearching: null == isSearching
          ? _value.isSearching
          : isSearching // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements Loaded {
  const _$LoadedImpl(
      {required final List<Book> books,
      required final List<Book> filteredBooks,
      required final List<String> categories,
      this.selectedCategory = '',
      this.searchQuery = '',
      this.isSearching = false})
      : _books = books,
        _filteredBooks = filteredBooks,
        _categories = categories;

  final List<Book> _books;
  @override
  List<Book> get books {
    if (_books is EqualUnmodifiableListView) return _books;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_books);
  }

  final List<Book> _filteredBooks;
  @override
  List<Book> get filteredBooks {
    if (_filteredBooks is EqualUnmodifiableListView) return _filteredBooks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredBooks);
  }

  final List<String> _categories;
  @override
  List<String> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  @JsonKey()
  final String selectedCategory;
  @override
  @JsonKey()
  final String searchQuery;
  @override
  @JsonKey()
  final bool isSearching;

  @override
  String toString() {
    return 'BooksState.loaded(books: $books, filteredBooks: $filteredBooks, categories: $categories, selectedCategory: $selectedCategory, searchQuery: $searchQuery, isSearching: $isSearching)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(other._books, _books) &&
            const DeepCollectionEquality()
                .equals(other._filteredBooks, _filteredBooks) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            (identical(other.selectedCategory, selectedCategory) ||
                other.selectedCategory == selectedCategory) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.isSearching, isSearching) ||
                other.isSearching == isSearching));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_books),
      const DeepCollectionEquality().hash(_filteredBooks),
      const DeepCollectionEquality().hash(_categories),
      selectedCategory,
      searchQuery,
      isSearching);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery,
            bool isSearching)
        loaded,
    required TResult Function(
            String message, String selectedCategory, String searchQuery)
        error,
    required TResult Function(
            List<Book> searchResults, String query, bool isLoading)
        searchResults,
    required TResult Function(List<Book> favoriteBooks) favoritesLoaded,
    required TResult Function(List<Book> recentBooks) recentBooksLoaded,
    required TResult Function(
            Book updatedBook,
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery)
        bookUpdated,
  }) {
    return loaded(books, filteredBooks, categories, selectedCategory,
        searchQuery, isSearching);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery,
            bool isSearching)?
        loaded,
    TResult? Function(
            String message, String selectedCategory, String searchQuery)?
        error,
    TResult? Function(List<Book> searchResults, String query, bool isLoading)?
        searchResults,
    TResult? Function(List<Book> favoriteBooks)? favoritesLoaded,
    TResult? Function(List<Book> recentBooks)? recentBooksLoaded,
    TResult? Function(
            Book updatedBook,
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery)?
        bookUpdated,
  }) {
    return loaded?.call(books, filteredBooks, categories, selectedCategory,
        searchQuery, isSearching);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery,
            bool isSearching)?
        loaded,
    TResult Function(
            String message, String selectedCategory, String searchQuery)?
        error,
    TResult Function(List<Book> searchResults, String query, bool isLoading)?
        searchResults,
    TResult Function(List<Book> favoriteBooks)? favoritesLoaded,
    TResult Function(List<Book> recentBooks)? recentBooksLoaded,
    TResult Function(
            Book updatedBook,
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery)?
        bookUpdated,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(books, filteredBooks, categories, selectedCategory,
          searchQuery, isSearching);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
    required TResult Function(Error value) error,
    required TResult Function(SearchResults value) searchResults,
    required TResult Function(FavoritesLoaded value) favoritesLoaded,
    required TResult Function(RecentBooksLoaded value) recentBooksLoaded,
    required TResult Function(BookUpdated value) bookUpdated,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(Error value)? error,
    TResult? Function(SearchResults value)? searchResults,
    TResult? Function(FavoritesLoaded value)? favoritesLoaded,
    TResult? Function(RecentBooksLoaded value)? recentBooksLoaded,
    TResult? Function(BookUpdated value)? bookUpdated,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    TResult Function(Error value)? error,
    TResult Function(SearchResults value)? searchResults,
    TResult Function(FavoritesLoaded value)? favoritesLoaded,
    TResult Function(RecentBooksLoaded value)? recentBooksLoaded,
    TResult Function(BookUpdated value)? bookUpdated,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class Loaded implements BooksState {
  const factory Loaded(
      {required final List<Book> books,
      required final List<Book> filteredBooks,
      required final List<String> categories,
      final String selectedCategory,
      final String searchQuery,
      final bool isSearching}) = _$LoadedImpl;

  List<Book> get books;
  List<Book> get filteredBooks;
  List<String> get categories;
  String get selectedCategory;
  String get searchQuery;
  bool get isSearching;
  @JsonKey(ignore: true)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, String selectedCategory, String searchQuery});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$BooksStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? selectedCategory = null,
    Object? searchQuery = null,
  }) {
    return _then(_$ErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      selectedCategory: null == selectedCategory
          ? _value.selectedCategory
          : selectedCategory // ignore: cast_nullable_to_non_nullable
              as String,
      searchQuery: null == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements Error {
  const _$ErrorImpl(
      {required this.message,
      this.selectedCategory = '',
      this.searchQuery = ''});

  @override
  final String message;
  @override
  @JsonKey()
  final String selectedCategory;
  @override
  @JsonKey()
  final String searchQuery;

  @override
  String toString() {
    return 'BooksState.error(message: $message, selectedCategory: $selectedCategory, searchQuery: $searchQuery)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.selectedCategory, selectedCategory) ||
                other.selectedCategory == selectedCategory) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, message, selectedCategory, searchQuery);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery,
            bool isSearching)
        loaded,
    required TResult Function(
            String message, String selectedCategory, String searchQuery)
        error,
    required TResult Function(
            List<Book> searchResults, String query, bool isLoading)
        searchResults,
    required TResult Function(List<Book> favoriteBooks) favoritesLoaded,
    required TResult Function(List<Book> recentBooks) recentBooksLoaded,
    required TResult Function(
            Book updatedBook,
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery)
        bookUpdated,
  }) {
    return error(message, selectedCategory, searchQuery);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery,
            bool isSearching)?
        loaded,
    TResult? Function(
            String message, String selectedCategory, String searchQuery)?
        error,
    TResult? Function(List<Book> searchResults, String query, bool isLoading)?
        searchResults,
    TResult? Function(List<Book> favoriteBooks)? favoritesLoaded,
    TResult? Function(List<Book> recentBooks)? recentBooksLoaded,
    TResult? Function(
            Book updatedBook,
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery)?
        bookUpdated,
  }) {
    return error?.call(message, selectedCategory, searchQuery);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery,
            bool isSearching)?
        loaded,
    TResult Function(
            String message, String selectedCategory, String searchQuery)?
        error,
    TResult Function(List<Book> searchResults, String query, bool isLoading)?
        searchResults,
    TResult Function(List<Book> favoriteBooks)? favoritesLoaded,
    TResult Function(List<Book> recentBooks)? recentBooksLoaded,
    TResult Function(
            Book updatedBook,
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery)?
        bookUpdated,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, selectedCategory, searchQuery);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
    required TResult Function(Error value) error,
    required TResult Function(SearchResults value) searchResults,
    required TResult Function(FavoritesLoaded value) favoritesLoaded,
    required TResult Function(RecentBooksLoaded value) recentBooksLoaded,
    required TResult Function(BookUpdated value) bookUpdated,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(Error value)? error,
    TResult? Function(SearchResults value)? searchResults,
    TResult? Function(FavoritesLoaded value)? favoritesLoaded,
    TResult? Function(RecentBooksLoaded value)? recentBooksLoaded,
    TResult? Function(BookUpdated value)? bookUpdated,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    TResult Function(Error value)? error,
    TResult Function(SearchResults value)? searchResults,
    TResult Function(FavoritesLoaded value)? favoritesLoaded,
    TResult Function(RecentBooksLoaded value)? recentBooksLoaded,
    TResult Function(BookUpdated value)? bookUpdated,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class Error implements BooksState {
  const factory Error(
      {required final String message,
      final String selectedCategory,
      final String searchQuery}) = _$ErrorImpl;

  String get message;
  String get selectedCategory;
  String get searchQuery;
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchResultsImplCopyWith<$Res> {
  factory _$$SearchResultsImplCopyWith(
          _$SearchResultsImpl value, $Res Function(_$SearchResultsImpl) then) =
      __$$SearchResultsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Book> searchResults, String query, bool isLoading});
}

/// @nodoc
class __$$SearchResultsImplCopyWithImpl<$Res>
    extends _$BooksStateCopyWithImpl<$Res, _$SearchResultsImpl>
    implements _$$SearchResultsImplCopyWith<$Res> {
  __$$SearchResultsImplCopyWithImpl(
      _$SearchResultsImpl _value, $Res Function(_$SearchResultsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchResults = null,
    Object? query = null,
    Object? isLoading = null,
  }) {
    return _then(_$SearchResultsImpl(
      searchResults: null == searchResults
          ? _value._searchResults
          : searchResults // ignore: cast_nullable_to_non_nullable
              as List<Book>,
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SearchResultsImpl implements SearchResults {
  const _$SearchResultsImpl(
      {required final List<Book> searchResults,
      required this.query,
      this.isLoading = false})
      : _searchResults = searchResults;

  final List<Book> _searchResults;
  @override
  List<Book> get searchResults {
    if (_searchResults is EqualUnmodifiableListView) return _searchResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchResults);
  }

  @override
  final String query;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'BooksState.searchResults(searchResults: $searchResults, query: $query, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchResultsImpl &&
            const DeepCollectionEquality()
                .equals(other._searchResults, _searchResults) &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_searchResults), query, isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchResultsImplCopyWith<_$SearchResultsImpl> get copyWith =>
      __$$SearchResultsImplCopyWithImpl<_$SearchResultsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery,
            bool isSearching)
        loaded,
    required TResult Function(
            String message, String selectedCategory, String searchQuery)
        error,
    required TResult Function(
            List<Book> searchResults, String query, bool isLoading)
        searchResults,
    required TResult Function(List<Book> favoriteBooks) favoritesLoaded,
    required TResult Function(List<Book> recentBooks) recentBooksLoaded,
    required TResult Function(
            Book updatedBook,
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery)
        bookUpdated,
  }) {
    return searchResults(this.searchResults, query, isLoading);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery,
            bool isSearching)?
        loaded,
    TResult? Function(
            String message, String selectedCategory, String searchQuery)?
        error,
    TResult? Function(List<Book> searchResults, String query, bool isLoading)?
        searchResults,
    TResult? Function(List<Book> favoriteBooks)? favoritesLoaded,
    TResult? Function(List<Book> recentBooks)? recentBooksLoaded,
    TResult? Function(
            Book updatedBook,
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery)?
        bookUpdated,
  }) {
    return searchResults?.call(this.searchResults, query, isLoading);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery,
            bool isSearching)?
        loaded,
    TResult Function(
            String message, String selectedCategory, String searchQuery)?
        error,
    TResult Function(List<Book> searchResults, String query, bool isLoading)?
        searchResults,
    TResult Function(List<Book> favoriteBooks)? favoritesLoaded,
    TResult Function(List<Book> recentBooks)? recentBooksLoaded,
    TResult Function(
            Book updatedBook,
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery)?
        bookUpdated,
    required TResult orElse(),
  }) {
    if (searchResults != null) {
      return searchResults(this.searchResults, query, isLoading);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
    required TResult Function(Error value) error,
    required TResult Function(SearchResults value) searchResults,
    required TResult Function(FavoritesLoaded value) favoritesLoaded,
    required TResult Function(RecentBooksLoaded value) recentBooksLoaded,
    required TResult Function(BookUpdated value) bookUpdated,
  }) {
    return searchResults(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(Error value)? error,
    TResult? Function(SearchResults value)? searchResults,
    TResult? Function(FavoritesLoaded value)? favoritesLoaded,
    TResult? Function(RecentBooksLoaded value)? recentBooksLoaded,
    TResult? Function(BookUpdated value)? bookUpdated,
  }) {
    return searchResults?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    TResult Function(Error value)? error,
    TResult Function(SearchResults value)? searchResults,
    TResult Function(FavoritesLoaded value)? favoritesLoaded,
    TResult Function(RecentBooksLoaded value)? recentBooksLoaded,
    TResult Function(BookUpdated value)? bookUpdated,
    required TResult orElse(),
  }) {
    if (searchResults != null) {
      return searchResults(this);
    }
    return orElse();
  }
}

abstract class SearchResults implements BooksState {
  const factory SearchResults(
      {required final List<Book> searchResults,
      required final String query,
      final bool isLoading}) = _$SearchResultsImpl;

  List<Book> get searchResults;
  String get query;
  bool get isLoading;
  @JsonKey(ignore: true)
  _$$SearchResultsImplCopyWith<_$SearchResultsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FavoritesLoadedImplCopyWith<$Res> {
  factory _$$FavoritesLoadedImplCopyWith(_$FavoritesLoadedImpl value,
          $Res Function(_$FavoritesLoadedImpl) then) =
      __$$FavoritesLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Book> favoriteBooks});
}

/// @nodoc
class __$$FavoritesLoadedImplCopyWithImpl<$Res>
    extends _$BooksStateCopyWithImpl<$Res, _$FavoritesLoadedImpl>
    implements _$$FavoritesLoadedImplCopyWith<$Res> {
  __$$FavoritesLoadedImplCopyWithImpl(
      _$FavoritesLoadedImpl _value, $Res Function(_$FavoritesLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? favoriteBooks = null,
  }) {
    return _then(_$FavoritesLoadedImpl(
      favoriteBooks: null == favoriteBooks
          ? _value._favoriteBooks
          : favoriteBooks // ignore: cast_nullable_to_non_nullable
              as List<Book>,
    ));
  }
}

/// @nodoc

class _$FavoritesLoadedImpl implements FavoritesLoaded {
  const _$FavoritesLoadedImpl({required final List<Book> favoriteBooks})
      : _favoriteBooks = favoriteBooks;

  final List<Book> _favoriteBooks;
  @override
  List<Book> get favoriteBooks {
    if (_favoriteBooks is EqualUnmodifiableListView) return _favoriteBooks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_favoriteBooks);
  }

  @override
  String toString() {
    return 'BooksState.favoritesLoaded(favoriteBooks: $favoriteBooks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoritesLoadedImpl &&
            const DeepCollectionEquality()
                .equals(other._favoriteBooks, _favoriteBooks));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_favoriteBooks));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FavoritesLoadedImplCopyWith<_$FavoritesLoadedImpl> get copyWith =>
      __$$FavoritesLoadedImplCopyWithImpl<_$FavoritesLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery,
            bool isSearching)
        loaded,
    required TResult Function(
            String message, String selectedCategory, String searchQuery)
        error,
    required TResult Function(
            List<Book> searchResults, String query, bool isLoading)
        searchResults,
    required TResult Function(List<Book> favoriteBooks) favoritesLoaded,
    required TResult Function(List<Book> recentBooks) recentBooksLoaded,
    required TResult Function(
            Book updatedBook,
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery)
        bookUpdated,
  }) {
    return favoritesLoaded(favoriteBooks);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery,
            bool isSearching)?
        loaded,
    TResult? Function(
            String message, String selectedCategory, String searchQuery)?
        error,
    TResult? Function(List<Book> searchResults, String query, bool isLoading)?
        searchResults,
    TResult? Function(List<Book> favoriteBooks)? favoritesLoaded,
    TResult? Function(List<Book> recentBooks)? recentBooksLoaded,
    TResult? Function(
            Book updatedBook,
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery)?
        bookUpdated,
  }) {
    return favoritesLoaded?.call(favoriteBooks);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery,
            bool isSearching)?
        loaded,
    TResult Function(
            String message, String selectedCategory, String searchQuery)?
        error,
    TResult Function(List<Book> searchResults, String query, bool isLoading)?
        searchResults,
    TResult Function(List<Book> favoriteBooks)? favoritesLoaded,
    TResult Function(List<Book> recentBooks)? recentBooksLoaded,
    TResult Function(
            Book updatedBook,
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery)?
        bookUpdated,
    required TResult orElse(),
  }) {
    if (favoritesLoaded != null) {
      return favoritesLoaded(favoriteBooks);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
    required TResult Function(Error value) error,
    required TResult Function(SearchResults value) searchResults,
    required TResult Function(FavoritesLoaded value) favoritesLoaded,
    required TResult Function(RecentBooksLoaded value) recentBooksLoaded,
    required TResult Function(BookUpdated value) bookUpdated,
  }) {
    return favoritesLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(Error value)? error,
    TResult? Function(SearchResults value)? searchResults,
    TResult? Function(FavoritesLoaded value)? favoritesLoaded,
    TResult? Function(RecentBooksLoaded value)? recentBooksLoaded,
    TResult? Function(BookUpdated value)? bookUpdated,
  }) {
    return favoritesLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    TResult Function(Error value)? error,
    TResult Function(SearchResults value)? searchResults,
    TResult Function(FavoritesLoaded value)? favoritesLoaded,
    TResult Function(RecentBooksLoaded value)? recentBooksLoaded,
    TResult Function(BookUpdated value)? bookUpdated,
    required TResult orElse(),
  }) {
    if (favoritesLoaded != null) {
      return favoritesLoaded(this);
    }
    return orElse();
  }
}

abstract class FavoritesLoaded implements BooksState {
  const factory FavoritesLoaded({required final List<Book> favoriteBooks}) =
      _$FavoritesLoadedImpl;

  List<Book> get favoriteBooks;
  @JsonKey(ignore: true)
  _$$FavoritesLoadedImplCopyWith<_$FavoritesLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RecentBooksLoadedImplCopyWith<$Res> {
  factory _$$RecentBooksLoadedImplCopyWith(_$RecentBooksLoadedImpl value,
          $Res Function(_$RecentBooksLoadedImpl) then) =
      __$$RecentBooksLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Book> recentBooks});
}

/// @nodoc
class __$$RecentBooksLoadedImplCopyWithImpl<$Res>
    extends _$BooksStateCopyWithImpl<$Res, _$RecentBooksLoadedImpl>
    implements _$$RecentBooksLoadedImplCopyWith<$Res> {
  __$$RecentBooksLoadedImplCopyWithImpl(_$RecentBooksLoadedImpl _value,
      $Res Function(_$RecentBooksLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recentBooks = null,
  }) {
    return _then(_$RecentBooksLoadedImpl(
      recentBooks: null == recentBooks
          ? _value._recentBooks
          : recentBooks // ignore: cast_nullable_to_non_nullable
              as List<Book>,
    ));
  }
}

/// @nodoc

class _$RecentBooksLoadedImpl implements RecentBooksLoaded {
  const _$RecentBooksLoadedImpl({required final List<Book> recentBooks})
      : _recentBooks = recentBooks;

  final List<Book> _recentBooks;
  @override
  List<Book> get recentBooks {
    if (_recentBooks is EqualUnmodifiableListView) return _recentBooks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentBooks);
  }

  @override
  String toString() {
    return 'BooksState.recentBooksLoaded(recentBooks: $recentBooks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecentBooksLoadedImpl &&
            const DeepCollectionEquality()
                .equals(other._recentBooks, _recentBooks));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_recentBooks));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecentBooksLoadedImplCopyWith<_$RecentBooksLoadedImpl> get copyWith =>
      __$$RecentBooksLoadedImplCopyWithImpl<_$RecentBooksLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery,
            bool isSearching)
        loaded,
    required TResult Function(
            String message, String selectedCategory, String searchQuery)
        error,
    required TResult Function(
            List<Book> searchResults, String query, bool isLoading)
        searchResults,
    required TResult Function(List<Book> favoriteBooks) favoritesLoaded,
    required TResult Function(List<Book> recentBooks) recentBooksLoaded,
    required TResult Function(
            Book updatedBook,
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery)
        bookUpdated,
  }) {
    return recentBooksLoaded(recentBooks);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery,
            bool isSearching)?
        loaded,
    TResult? Function(
            String message, String selectedCategory, String searchQuery)?
        error,
    TResult? Function(List<Book> searchResults, String query, bool isLoading)?
        searchResults,
    TResult? Function(List<Book> favoriteBooks)? favoritesLoaded,
    TResult? Function(List<Book> recentBooks)? recentBooksLoaded,
    TResult? Function(
            Book updatedBook,
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery)?
        bookUpdated,
  }) {
    return recentBooksLoaded?.call(recentBooks);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery,
            bool isSearching)?
        loaded,
    TResult Function(
            String message, String selectedCategory, String searchQuery)?
        error,
    TResult Function(List<Book> searchResults, String query, bool isLoading)?
        searchResults,
    TResult Function(List<Book> favoriteBooks)? favoritesLoaded,
    TResult Function(List<Book> recentBooks)? recentBooksLoaded,
    TResult Function(
            Book updatedBook,
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery)?
        bookUpdated,
    required TResult orElse(),
  }) {
    if (recentBooksLoaded != null) {
      return recentBooksLoaded(recentBooks);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
    required TResult Function(Error value) error,
    required TResult Function(SearchResults value) searchResults,
    required TResult Function(FavoritesLoaded value) favoritesLoaded,
    required TResult Function(RecentBooksLoaded value) recentBooksLoaded,
    required TResult Function(BookUpdated value) bookUpdated,
  }) {
    return recentBooksLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(Error value)? error,
    TResult? Function(SearchResults value)? searchResults,
    TResult? Function(FavoritesLoaded value)? favoritesLoaded,
    TResult? Function(RecentBooksLoaded value)? recentBooksLoaded,
    TResult? Function(BookUpdated value)? bookUpdated,
  }) {
    return recentBooksLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    TResult Function(Error value)? error,
    TResult Function(SearchResults value)? searchResults,
    TResult Function(FavoritesLoaded value)? favoritesLoaded,
    TResult Function(RecentBooksLoaded value)? recentBooksLoaded,
    TResult Function(BookUpdated value)? bookUpdated,
    required TResult orElse(),
  }) {
    if (recentBooksLoaded != null) {
      return recentBooksLoaded(this);
    }
    return orElse();
  }
}

abstract class RecentBooksLoaded implements BooksState {
  const factory RecentBooksLoaded({required final List<Book> recentBooks}) =
      _$RecentBooksLoadedImpl;

  List<Book> get recentBooks;
  @JsonKey(ignore: true)
  _$$RecentBooksLoadedImplCopyWith<_$RecentBooksLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BookUpdatedImplCopyWith<$Res> {
  factory _$$BookUpdatedImplCopyWith(
          _$BookUpdatedImpl value, $Res Function(_$BookUpdatedImpl) then) =
      __$$BookUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {Book updatedBook,
      List<Book> books,
      List<Book> filteredBooks,
      List<String> categories,
      String selectedCategory,
      String searchQuery});

  $BookCopyWith<$Res> get updatedBook;
}

/// @nodoc
class __$$BookUpdatedImplCopyWithImpl<$Res>
    extends _$BooksStateCopyWithImpl<$Res, _$BookUpdatedImpl>
    implements _$$BookUpdatedImplCopyWith<$Res> {
  __$$BookUpdatedImplCopyWithImpl(
      _$BookUpdatedImpl _value, $Res Function(_$BookUpdatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? updatedBook = null,
    Object? books = null,
    Object? filteredBooks = null,
    Object? categories = null,
    Object? selectedCategory = null,
    Object? searchQuery = null,
  }) {
    return _then(_$BookUpdatedImpl(
      updatedBook: null == updatedBook
          ? _value.updatedBook
          : updatedBook // ignore: cast_nullable_to_non_nullable
              as Book,
      books: null == books
          ? _value._books
          : books // ignore: cast_nullable_to_non_nullable
              as List<Book>,
      filteredBooks: null == filteredBooks
          ? _value._filteredBooks
          : filteredBooks // ignore: cast_nullable_to_non_nullable
              as List<Book>,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      selectedCategory: null == selectedCategory
          ? _value.selectedCategory
          : selectedCategory // ignore: cast_nullable_to_non_nullable
              as String,
      searchQuery: null == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $BookCopyWith<$Res> get updatedBook {
    return $BookCopyWith<$Res>(_value.updatedBook, (value) {
      return _then(_value.copyWith(updatedBook: value));
    });
  }
}

/// @nodoc

class _$BookUpdatedImpl implements BookUpdated {
  const _$BookUpdatedImpl(
      {required this.updatedBook,
      required final List<Book> books,
      required final List<Book> filteredBooks,
      required final List<String> categories,
      this.selectedCategory = '',
      this.searchQuery = ''})
      : _books = books,
        _filteredBooks = filteredBooks,
        _categories = categories;

  @override
  final Book updatedBook;
  final List<Book> _books;
  @override
  List<Book> get books {
    if (_books is EqualUnmodifiableListView) return _books;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_books);
  }

  final List<Book> _filteredBooks;
  @override
  List<Book> get filteredBooks {
    if (_filteredBooks is EqualUnmodifiableListView) return _filteredBooks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredBooks);
  }

  final List<String> _categories;
  @override
  List<String> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  @JsonKey()
  final String selectedCategory;
  @override
  @JsonKey()
  final String searchQuery;

  @override
  String toString() {
    return 'BooksState.bookUpdated(updatedBook: $updatedBook, books: $books, filteredBooks: $filteredBooks, categories: $categories, selectedCategory: $selectedCategory, searchQuery: $searchQuery)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookUpdatedImpl &&
            (identical(other.updatedBook, updatedBook) ||
                other.updatedBook == updatedBook) &&
            const DeepCollectionEquality().equals(other._books, _books) &&
            const DeepCollectionEquality()
                .equals(other._filteredBooks, _filteredBooks) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            (identical(other.selectedCategory, selectedCategory) ||
                other.selectedCategory == selectedCategory) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      updatedBook,
      const DeepCollectionEquality().hash(_books),
      const DeepCollectionEquality().hash(_filteredBooks),
      const DeepCollectionEquality().hash(_categories),
      selectedCategory,
      searchQuery);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BookUpdatedImplCopyWith<_$BookUpdatedImpl> get copyWith =>
      __$$BookUpdatedImplCopyWithImpl<_$BookUpdatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery,
            bool isSearching)
        loaded,
    required TResult Function(
            String message, String selectedCategory, String searchQuery)
        error,
    required TResult Function(
            List<Book> searchResults, String query, bool isLoading)
        searchResults,
    required TResult Function(List<Book> favoriteBooks) favoritesLoaded,
    required TResult Function(List<Book> recentBooks) recentBooksLoaded,
    required TResult Function(
            Book updatedBook,
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery)
        bookUpdated,
  }) {
    return bookUpdated(updatedBook, books, filteredBooks, categories,
        selectedCategory, searchQuery);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery,
            bool isSearching)?
        loaded,
    TResult? Function(
            String message, String selectedCategory, String searchQuery)?
        error,
    TResult? Function(List<Book> searchResults, String query, bool isLoading)?
        searchResults,
    TResult? Function(List<Book> favoriteBooks)? favoritesLoaded,
    TResult? Function(List<Book> recentBooks)? recentBooksLoaded,
    TResult? Function(
            Book updatedBook,
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery)?
        bookUpdated,
  }) {
    return bookUpdated?.call(updatedBook, books, filteredBooks, categories,
        selectedCategory, searchQuery);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery,
            bool isSearching)?
        loaded,
    TResult Function(
            String message, String selectedCategory, String searchQuery)?
        error,
    TResult Function(List<Book> searchResults, String query, bool isLoading)?
        searchResults,
    TResult Function(List<Book> favoriteBooks)? favoritesLoaded,
    TResult Function(List<Book> recentBooks)? recentBooksLoaded,
    TResult Function(
            Book updatedBook,
            List<Book> books,
            List<Book> filteredBooks,
            List<String> categories,
            String selectedCategory,
            String searchQuery)?
        bookUpdated,
    required TResult orElse(),
  }) {
    if (bookUpdated != null) {
      return bookUpdated(updatedBook, books, filteredBooks, categories,
          selectedCategory, searchQuery);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
    required TResult Function(Error value) error,
    required TResult Function(SearchResults value) searchResults,
    required TResult Function(FavoritesLoaded value) favoritesLoaded,
    required TResult Function(RecentBooksLoaded value) recentBooksLoaded,
    required TResult Function(BookUpdated value) bookUpdated,
  }) {
    return bookUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(Error value)? error,
    TResult? Function(SearchResults value)? searchResults,
    TResult? Function(FavoritesLoaded value)? favoritesLoaded,
    TResult? Function(RecentBooksLoaded value)? recentBooksLoaded,
    TResult? Function(BookUpdated value)? bookUpdated,
  }) {
    return bookUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    TResult Function(Error value)? error,
    TResult Function(SearchResults value)? searchResults,
    TResult Function(FavoritesLoaded value)? favoritesLoaded,
    TResult Function(RecentBooksLoaded value)? recentBooksLoaded,
    TResult Function(BookUpdated value)? bookUpdated,
    required TResult orElse(),
  }) {
    if (bookUpdated != null) {
      return bookUpdated(this);
    }
    return orElse();
  }
}

abstract class BookUpdated implements BooksState {
  const factory BookUpdated(
      {required final Book updatedBook,
      required final List<Book> books,
      required final List<Book> filteredBooks,
      required final List<String> categories,
      final String selectedCategory,
      final String searchQuery}) = _$BookUpdatedImpl;

  Book get updatedBook;
  List<Book> get books;
  List<Book> get filteredBooks;
  List<String> get categories;
  String get selectedCategory;
  String get searchQuery;
  @JsonKey(ignore: true)
  _$$BookUpdatedImplCopyWith<_$BookUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
