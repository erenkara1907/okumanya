import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/book.dart';
import '../repositories/books_repository.dart';

/// Use case for searching books by query
@lazySingleton
class SearchBooks implements UseCase<List<Book>, SearchBooksParams> {
  const SearchBooks(this._repository);

  final BooksRepository _repository;

  @override
  Future<Either<Failure, List<Book>>> call(SearchBooksParams params) {
    return _repository.searchBooks(params.query);
  }
}

/// Parameters for SearchBooks use case
class SearchBooksParams extends Params {
  const SearchBooksParams({required this.query});

  final String query;

  @override
  List<Object?> get props => [query];
}