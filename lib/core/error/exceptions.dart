import 'package:equatable/equatable.dart';

/// Base class for all exceptions in the application
abstract class AppException extends Equatable implements Exception {
  const AppException({required this.message, this.statusCode});

  /// Human-readable error message
  final String message;
  
  /// Optional HTTP status code or error code
  final int? statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

/// Exception related to network connectivity issues
class NetworkException extends AppException {
  const NetworkException({
    super.message = 'Network connection failed',
    super.statusCode,
  });
}

/// Exception related to server errors
class ServerException extends AppException {
  const ServerException({
    super.message = 'Server error occurred',
    super.statusCode,
  });
}

/// Exception related to authentication
class AuthException extends AppException {
  const AuthException({
    super.message = 'Authentication failed',
    super.statusCode,
  });
}

/// Exception related to validation errors
class ValidationException extends AppException {
  const ValidationException({
    super.message = 'Validation error',
    super.statusCode,
  });
}

/// Exception related to caching operations
class CacheException extends AppException {
  const CacheException({
    super.message = 'Cache operation failed',
    super.statusCode,
  });
}

/// Exception for unexpected errors
class UnexpectedException extends AppException {
  const UnexpectedException({
    super.message = 'An unexpected error occurred',
    super.statusCode,
  });
}

/// Exception when resource is not found
class NotFoundException extends AppException {
  const NotFoundException({
    super.message = 'Resource not found',
    super.statusCode = 404,
  });
}