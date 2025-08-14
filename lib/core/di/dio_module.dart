import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

/// Injectable module for Dio HTTP client
@module
abstract class DioModule {
  @lazySingleton
  Dio get dio {
    final dio = Dio(BaseOptions(
      baseUrl: 'https://app.okumanya.com.tr/api',
      connectTimeout: Duration(milliseconds: 30000),
      receiveTimeout: Duration(milliseconds: 30000),
      sendTimeout: Duration(milliseconds: 30000),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));
    
    return dio;
  }
}