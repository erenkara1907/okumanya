import '../../shared/enum/exception_type.dart';

class ServerException implements Exception {
  final ExceptionType exceptionType;
  final String? message;

  ServerException(this.exceptionType, {this.message});
}

class CacheException implements Exception {}
