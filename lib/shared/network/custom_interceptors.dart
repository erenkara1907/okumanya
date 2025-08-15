import 'package:dio/dio.dart';
import 'dart:developer' as developer;
import '../../shared/storage/secure_storage_service.dart';
import '../../shared/config/app_config.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await SecureStorageService.getAuthToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';

    if (AppConfig.isDevelopment) {
      developer.log('Request: ${options.method} ${options.uri}',
          name: 'NetworkRequest');
      developer.log('Headers: ${options.headers}', name: 'NetworkRequest');
      if (options.data != null) {
        developer.log('Data: ${options.data}', name: 'NetworkRequest');
      }
    }

    handler.next(options);
  }

  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    if (AppConfig.isDevelopment) {
      developer.log(
          'Response: ${response.statusCode} ${response.requestOptions.uri}',
          name: 'NetworkResponse');
      developer.log('Data: ${response.data}', name: 'NetworkResponse');
    }
    handler.next(response);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (AppConfig.isDevelopment) {
      developer.log('Error: ${err.message}', name: 'NetworkError');
      developer.log('Response: ${err.response?.data}', name: 'NetworkError');
    }

    // Token expired, try to refresh
    if (err.response?.statusCode == 401) {
      final refreshToken = await SecureStorageService.getRefreshToken();
      if (refreshToken != null) {
        // TODO: Implement token refresh logic here
        // For now, clear auth data and redirect to login
        await SecureStorageService.clearAuthData();
      }
    }

    handler.next(err);
  }
}
