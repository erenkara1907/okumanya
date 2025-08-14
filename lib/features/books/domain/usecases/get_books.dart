import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/book.dart';
import '../repositories/books_repository.dart';

/// Use case for retrieving all books
@lazySingleton
class GetBooks implements NoParamsUseCase<List<Book>> {
  const GetBooks(this._repository);

  final BooksRepository _repository;

  @override
  Future<Either<Failure, List<Book>>> call() {
    return _repository.getAllBooks();
  }
}