import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failures.dart';

/// Abstract base class for all use cases
/// 
/// [T] - return type of the use case
/// [P] - parameters required for the use case
abstract class UseCase<T, P> {
  /// Executes the use case with given parameters
  Future<Either<Failure, T>> call(P params);
}

/// Use case for operations that don't require parameters
abstract class NoParamsUseCase<T> {
  /// Executes the use case without parameters
  Future<Either<Failure, T>> call();
}

/// Base class for use case parameters
abstract class Params extends Equatable {
  const Params();
}

/// Empty parameters class for use cases that don't require parameters
class NoParams extends Params {
  const NoParams();

  @override
  List<Object?> get props => [];
}