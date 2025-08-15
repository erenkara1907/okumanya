import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/exceptions.dart';

import '../models/login_request_model.dart';
import '../models/login_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login(LoginRequestModel request);
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    log('🌍 AuthRemoteDataSource: Making API call to /login',
        name: 'DataSource');
    log('📤 AuthRemoteDataSource: Request data: ${request.toJson()}',
        name: 'DataSource');

    try {
      final response = await dio.post(
        '/login',
        data: request.toJson(),
      );

      log('📥 AuthRemoteDataSource: Response status: ${response.statusCode}',
          name: 'DataSource');
      log('📄 AuthRemoteDataSource: Response data: ${response.data}',
          name: 'DataSource');

      return LoginResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      log('❌ AuthRemoteDataSource: API call failed: $e', name: 'DataSource');

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw const NetworkException(message: 'Network connection failed');
      }

      final statusCode = e.response?.statusCode;
      switch (statusCode) {
        case 401:
          throw const AuthException(message: 'Invalid credentials');
        case 404:
          throw const NotFoundException(message: 'User not found');
        case 422:
          throw const ValidationException(message: 'Validation error');
        case 500:
        case 502:
        case 503:
          throw ServerException(
            message: 'Server error occurred',
            statusCode: statusCode,
          );
        default:
          throw ServerException(
            message: 'An unexpected error occurred',
            statusCode: statusCode,
          );
      }
    } catch (e) {
      log('❌ AuthRemoteDataSource: Unexpected error: $e', name: 'DataSource');
      throw const CacheException(message: 'An unexpected error occurred');
    }
  }
}
