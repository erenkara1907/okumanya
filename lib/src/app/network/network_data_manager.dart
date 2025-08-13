import 'package:dio/dio.dart';

import '../../shared/url/endpoints.dart';
import '../../shared/config/app_config.dart';
import 'custom_interceptors.dart';
import 'dio_exceptions.dart';

class NetworkDataManager {
  final Dio dio;

  NetworkDataManager(this.dio) {
    dio.options.baseUrl = Endpoints.baseUrl;
    dio.options.connectTimeout = Duration(milliseconds: AppConfig.apiTimeout);
    dio.options.receiveTimeout = Duration(milliseconds: AppConfig.apiTimeout);
    dio.options.sendTimeout = Duration(milliseconds: AppConfig.apiTimeout);
    dio.interceptors.add(AuthInterceptor());
  }

  Future<Response> get(String path, {queryParameters}) async {
    try {
      final response = await dio.get(path, queryParameters: queryParameters);
      return response;
    } on DioException catch (err) {
      final errorMessage = _extractErrorMessage(err);
      throw handleException(err, message: errorMessage);
    }
  }

  Future<Response> post(String path, {data, queryParameters}) async {
    try {
      final response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (err) {
      final errorMessage = _extractErrorMessage(err);
      throw handleException(err, message: errorMessage);
    }
  }

  Future<Response> put(String path, {data}) async {
    try {
      final response = await dio.put(path, data: data);
      return response;
    } on DioException catch (err) {
      final errorMessage = _extractErrorMessage(err);
      throw handleException(err, message: errorMessage);
    }
  }

  Future<Response> delete(String path, {data}) async {
    try {
      final response = await dio.delete(path, data: data);
      return response;
    } on DioException catch (err) {
      final errorMessage = _extractErrorMessage(err);
      throw handleException(err, message: errorMessage);
    }
  }

  String _extractErrorMessage(DioException err) {
    try {
      final response = err.response;
      if (response?.data != null) {
        final data = response!.data;
        if (data is Map<String, dynamic>) {
          final message = data['message'];
          if (message != null && message is String && message.isNotEmpty) {
            return message;
          }
        } else if (data is String && data.isNotEmpty) {
          return data;
        }
      }
      return err.message ?? 'Bilinmeyen bir hata oluştu';
    } catch (e) {
      return 'Bilinmeyen bir hata oluştu';
    }
  }
}