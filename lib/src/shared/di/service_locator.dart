import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../app/network/network_data_manager.dart';
import '../../app/network/custom_interceptors.dart';
import '../../domain/repository/auth_repository.dart';
import '../../app/pages/login/bloc/login_bloc.dart';
import '../../app/pages/home/bloc/home/home_bloc.dart';
import '../../app/pages/profile/bloc/profile_bloc.dart';
import '../../app/pages/home/bloc/reading/reading_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Network
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio();
    dio.interceptors.add(AuthInterceptor());
    return dio;
  });

  sl.registerLazySingleton<NetworkDataManager>(
    () => NetworkDataManager(sl<Dio>()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepository(networkDataManager: sl<NetworkDataManager>()),
  );

  // BLoCs
  sl.registerFactory<LoginBloc>(() => LoginBloc(sl<AuthRepository>()));
  sl.registerFactory<HomeBloc>(() => HomeBloc());
  sl.registerFactory<ProfileBloc>(() => ProfileBloc());
  sl.registerFactory<ReadingBloc>(() => ReadingBloc());
}