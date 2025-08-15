import 'dart:async';
import 'dart:developer' as developer;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../config/app_config.dart';
import '../network/exceptions.dart';
import '../enum/exception_type.dart';

class GlobalErrorHandler {
  static void initialize() {
    // Catch all uncaught errors
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      _logError(details.exception, details.stack);
    };

    // Catch async errors
    PlatformDispatcher.instance.onError = (error, stack) {
      _logError(error, stack);
      return true;
    };
  }

  static void _logError(dynamic error, StackTrace? stack) {
    if (AppConfig.isDevelopment) {
      developer.log(
        'Global Error: $error',
        name: 'GlobalErrorHandler',
        error: error,
        stackTrace: stack,
      );
    }

    // In production, you might want to send this to a crash reporting service
    // like Firebase Crashlytics, Sentry, etc.
  }

  static void handleError(dynamic error, {BuildContext? context}) {
    String errorMessage;

    if (error is ServerException) {
      errorMessage = _getServerErrorMessage(error);
    } else if (error is FormatException) {
      errorMessage = "errors.unknownError".tr();
    } else if (error is TimeoutException) {
      errorMessage = "errors.networkError".tr();
    } else {
      errorMessage = "errors.unknownError".tr();
    }

    _showErrorToast(errorMessage);

    if (AppConfig.isDevelopment) {
      developer.log(
        'Handled Error: $error',
        name: 'ErrorHandler',
        error: error,
      );
    }
  }

  static String _getServerErrorMessage(ServerException exception) {
    switch (exception.exceptionType) {
      case ExceptionType.unauthorisedRequest:
      case ExceptionType.unauthorizedUser:
        return "errors.sessionExpired".tr();
      case ExceptionType.noInternetConnection:
        return "errors.networkError".tr();
      case ExceptionType.internalServerError:
        return "errors.serverError".tr();
      case ExceptionType.badRequest:
        return exception.message ?? "errors.unknownError".tr();
      case ExceptionType.notFound:
        return "errors.unknownError".tr();
      case ExceptionType.requestTimeout:
      case ExceptionType.timeout:
        return "errors.networkError".tr();
      case ExceptionType.formatException:
        return "errors.unknownError".tr();
      default:
        return exception.message ?? "errors.unknownError".tr();
    }
  }

  static void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red[600],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static void showSuccessToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green[600],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static void showInfoToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.blue[600],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
