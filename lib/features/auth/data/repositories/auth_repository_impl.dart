import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/repository/base_repository.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/login_request_model.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(
    this.remoteDataSource,
    NetworkInfo networkInfo,
  ) : super(networkInfo);

  @override
  Future<Either<Failure, LoginEntity>> login(String email, String password) {
    log('📦 AuthRepositoryImpl: Starting login for $email', name: 'AuthRepo');
    
    return safeApiCall(() async {
      log('🔧 AuthRepositoryImpl: Creating login request', name: 'AuthRepo');
      final request = LoginRequestModel(email: email, password: password);
      
      log('🌐 AuthRepositoryImpl: Calling remote data source', name: 'AuthRepo');
      final response = await remoteDataSource.login(request);
      
      log('✅ AuthRepositoryImpl: Got response, creating LoginEntity', name: 'AuthRepo');
      return LoginEntity(
        token: response.token,
        isTeacher: response.isTeacher,
        user: response.user,
      );
    });
  }
}