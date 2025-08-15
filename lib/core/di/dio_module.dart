import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../constants/app_constants.dart';

/// Injectable module for Dio HTTP client
@module
abstract class DioModule {
  @lazySingleton
  Dio get dio {
    final dio = Dio(BaseOptions(
      baseUrl: 'https://app.okumanya.com.tr/api',
      connectTimeout: Duration(milliseconds: AppConstants.connectTimeout),
      receiveTimeout: Duration(milliseconds: AppConstants.receiveTimeout),
      sendTimeout: Duration(milliseconds: AppConstants.apiTimeout),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));
    
    return dio;
  }
}