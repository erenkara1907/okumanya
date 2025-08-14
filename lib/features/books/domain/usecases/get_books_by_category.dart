import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/book.dart';
import '../repositories/books_repository.dart';

/// Use case for retrieving books by category
@lazySingleton
class GetBooksByCategory implements UseCase<List<Book>, GetBooksByCategoryParams> {
  const GetBooksByCategory(this._repository);

  final BooksRepository _repository;

  @override
  Future<Either<Failure, List<Book>>> call(GetBooksByCategoryParams params) {
    return _repository.getBooksByCategory(params.category);
  }
}

/// Parameters for GetBooksByCategory use case
class GetBooksByCategoryParams extends Params {
  const GetBooksByCategoryParams({required this.category});

  final String category;

  @override
  List<Object?> get props => [category];
}