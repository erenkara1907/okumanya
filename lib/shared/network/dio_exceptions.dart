import 'dart:io';

import 'package:dio/dio.dart';

import '../../shared/enum/exception_type.dart';
import 'exceptions.dart';

ServerException handleException(dynamic error, {String? message}) {
  if (error is Exception) {
    try {
      ServerException exception = ServerException(ExceptionType.unknownError);
      if (error is DioException) {
        switch (error.type) {
          case DioExceptionType.cancel:
            exception = ServerException(ExceptionType.requestCancelled);
            break;
          case DioExceptionType.connectionTimeout:
            exception = ServerException(ExceptionType.requestTimeout);
            break;
          case DioExceptionType.receiveTimeout:
            exception = ServerException(ExceptionType.timeout);
            break;
          case DioExceptionType.badResponse:
            final statusCode = error.response?.statusCode;
            switch (statusCode) {
              case 400:
                exception = ServerException(ExceptionType.badRequest, message: message);
                break;
              case 401:
                exception = ServerException(ExceptionType.unauthorisedRequest);
                break;
              case 403:
                exception = ServerException(ExceptionType.unauthorisedRequest);
                break;
              case 404:
                exception = ServerException(ExceptionType.notFound);
                break;
              case 408:
                exception = ServerException(ExceptionType.requestTimeout);
                break;
              case 500:
                exception = ServerException(ExceptionType.internalServerError);
                break;
              case 503:
                exception = ServerException(ExceptionType.serviceUnavailable);
                break;
              case 488:
                exception = ServerException(ExceptionType.unauthorizedUser);
                break;
              case 409:
                exception = ServerException(ExceptionType.conflict);
                break;
              default:
                exception = ServerException(ExceptionType.unknownError, message: message);
            }
            break;
          case DioExceptionType.sendTimeout:
            exception = ServerException(ExceptionType.timeout);
            break;
          case DioExceptionType.badCertificate:
            exception = ServerException(ExceptionType.badRequest);
            break;
          case DioExceptionType.connectionError:
            exception = ServerException(ExceptionType.noInternetConnection);
            break;
          case DioExceptionType.unknown:
            exception = ServerException(ExceptionType.unknownError);
            break;
        }
      } else if (error is SocketException) {
        exception = ServerException(ExceptionType.noInternetConnection);
      } else {
        exception = ServerException(ExceptionType.unknownError);
      }
      return exception;
    } on FormatException catch (_) {
      return ServerException(ExceptionType.formatException);
    } catch (_) {
      return ServerException(ExceptionType.unknownError);
    }
  } else {
    return ServerException(ExceptionType.unknownError);
  }
}