import 'package:dio/dio.dart';
import '../../shared/enum/exception_type.dart';
import 'failures.dart';

class ErrorMapper {
  static Failure mapDioExceptionToFailure(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkFailure(
          message: ExceptionType.timeout.message,
          statusCode: dioException.response?.statusCode,
        );

      case DioExceptionType.connectionError:
        return NetworkFailure(
          message: ExceptionType.noInternetConnection.message,
          statusCode: dioException.response?.statusCode,
        );

      case DioExceptionType.badResponse:
        return _mapStatusCodeToFailure(dioException);

      case DioExceptionType.cancel:
        return NetworkFailure(
          message: ExceptionType.requestCancelled.message,
          statusCode: dioException.response?.statusCode,
        );

      case DioExceptionType.unknown:
      default:
        return UnexpectedFailure(
          message: ExceptionType.unknownError.message,
          statusCode: dioException.response?.statusCode,
        );
    }
  }

  static Failure _mapStatusCodeToFailure(DioException dioException) {
    final statusCode = dioException.response?.statusCode;

    switch (statusCode) {
      case 400:
        return ValidationFailure(
          message: ExceptionType.badRequest.message,
          statusCode: statusCode,
        );
      case 401:
        return AuthFailure(
          message: ExceptionType.unauthorisedRequest.message,
          statusCode: statusCode,
        );
      case 404:
        return NotFoundFailure(
          message: ExceptionType.notFound.message,
          statusCode: statusCode,
        );
      case 409:
        return ValidationFailure(
          message: ExceptionType.conflict.message,
          statusCode: statusCode,
        );
      case 488:
        return AuthFailure(
          message: ExceptionType.unauthorizedUser.message,
          statusCode: statusCode,
        );
      case 500:
        return ServerFailure(
          message: ExceptionType.internalServerError.message,
          statusCode: statusCode,
        );
      case 503:
        return ServerFailure(
          message: ExceptionType.serviceUnavailable.message,
          statusCode: statusCode,
        );
      default:
        return UnexpectedFailure(
          message: ExceptionType.unknownError.message,
          statusCode: statusCode,
        );
    }
  }

  static Failure mapExceptionTypeToFailure(ExceptionType exceptionType) {
    switch (exceptionType) {
      case ExceptionType.noInternetConnection:
      case ExceptionType.requestTimeout:
      case ExceptionType.timeout:
      case ExceptionType.requestCancelled:
        return NetworkFailure(message: exceptionType.message);

      case ExceptionType.unauthorisedRequest:
      case ExceptionType.unauthorizedUser:
        return AuthFailure(message: exceptionType.message);

      case ExceptionType.badRequest:
      case ExceptionType.conflict:
      case ExceptionType.formatException:
        return ValidationFailure(message: exceptionType.message);

      case ExceptionType.notFound:
        return NotFoundFailure(message: exceptionType.message);

      case ExceptionType.internalServerError:
      case ExceptionType.serviceUnavailable:
        return ServerFailure(message: exceptionType.message);

      case ExceptionType.unknownError:
        return UnexpectedFailure(message: exceptionType.message);
    }
  }
}
