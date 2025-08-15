import 'package:equatable/equatable.dart';

/// Base class for all failures in the application
abstract class Failure extends Equatable {
  const Failure({required this.message, this.statusCode});

  /// Human-readable error message
  final String message;

  /// Optional HTTP status code or error code
  final int? statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

/// Failure related to network connectivity issues
class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'Network connection failed',
    super.statusCode,
  });
}

/// Failure related to server errors
class ServerFailure extends Failure {
  const ServerFailure({
    super.message = 'Server error occurred',
    super.statusCode,
  });
}

/// Failure related to authentication
class AuthFailure extends Failure {
  const AuthFailure({
    super.message = 'Authentication failed',
    super.statusCode,
  });
}

/// Failure related to validation errors
class ValidationFailure extends Failure {
  const ValidationFailure({
    super.message = 'Validation error',
    super.statusCode,
  });
}

/// Failure related to caching operations
class CacheFailure extends Failure {
  const CacheFailure({
    super.message = 'Cache operation failed',
    super.statusCode,
  });
}

/// Failure for unexpected errors
class UnexpectedFailure extends Failure {
  const UnexpectedFailure({
    super.message = 'An unexpected error occurred',
    super.statusCode,
  });
}

/// Failure for unknown errors
class UnknownFailure extends Failure {
  const UnknownFailure(String errorMessage) : super(message: errorMessage);
}

/// Failure when resource is not found
class NotFoundFailure extends Failure {
  const NotFoundFailure({
    super.message = 'Resource not found',
    super.statusCode = 404,
  });
}
