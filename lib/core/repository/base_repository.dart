import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../error/failures.dart';
import '../error/error_mapper.dart';
import '../network/network_info.dart';

/// Base repository class with common functionality
abstract class BaseRepository {
  final NetworkInfo networkInfo;

  BaseRepository(this.networkInfo);

  /// Safe API call wrapper with error handling
  Future<Either<Failure, T>> safeApiCall<T>(
    Future<T> Function() apiCall,
  ) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await apiCall();
        return Right(result);
      } else {
        return const Left(NetworkFailure(message: 'No internet connection'));
      }
    } on DioException catch (e) {
      return Left(ErrorMapper.mapDioExceptionToFailure(e));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  /// Safe API call with caching support
  Future<Either<Failure, T>> safeApiCallWithCache<T>(
    Future<T> Function() apiCall,
    Future<T?> Function() cacheCall,
    Future<void> Function(T) cacheStore,
  ) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await apiCall();
        await cacheStore(result);
        return Right(result);
      } else {
        final cachedData = await cacheCall();
        if (cachedData != null) {
          return Right(cachedData);
        } else {
          return const Left(NetworkFailure(message: 'No internet connection and no cached data'));
        }
      }
    } on DioException catch (e) {
      // Try to return cached data on API error
      final cachedData = await cacheCall();
      if (cachedData != null) {
        return Right(cachedData);
      }
      return Left(ErrorMapper.mapDioExceptionToFailure(e));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}