// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:okumanya/core/analytics/analytics_service.dart' as _i726;
import 'package:okumanya/core/auth/auth_service.dart' as _i751;
import 'package:okumanya/core/cache/cache_manager.dart' as _i885;
import 'package:okumanya/core/di/connectivity_module.dart' as _i1009;
import 'package:okumanya/core/di/dio_module.dart' as _i1043;
import 'package:okumanya/core/network/network_info.dart' as _i1032;
import 'package:okumanya/core/performance/performance_service.dart' as _i1027;
import 'package:okumanya/features/auth/data/datasources/auth_remote_data_source.dart'
    as _i650;
import 'package:okumanya/features/auth/data/repositories/auth_repository_impl.dart'
    as _i292;
import 'package:okumanya/features/auth/domain/repositories/auth_repository.dart'
    as _i663;
import 'package:okumanya/features/auth/domain/usecases/login_usecase.dart'
    as _i1033;
import 'package:okumanya/features/auth/presentation/bloc/login_bloc.dart'
    as _i592;
import 'package:okumanya/features/books/data/datasources/books_local_data_source.dart'
    as _i1050;
import 'package:okumanya/features/books/data/datasources/books_remote_data_source.dart'
    as _i596;
import 'package:okumanya/features/books/data/repositories/books_repository_impl.dart'
    as _i748;
import 'package:okumanya/features/books/domain/repositories/books_repository.dart'
    as _i687;
import 'package:okumanya/features/books/domain/usecases/get_books.dart'
    as _i935;
import 'package:okumanya/features/books/domain/usecases/get_books_by_category.dart'
    as _i496;
import 'package:okumanya/features/books/domain/usecases/search_books.dart'
    as _i269;
import 'package:okumanya/features/books/presentation/bloc/books_bloc.dart'
    as _i876;
import 'package:okumanya/features/home/presentation/bloc/home/home_bloc.dart'
    as _i872;
import 'package:okumanya/features/home/presentation/bloc/reading/reading_bloc.dart'
    as _i639;
import 'package:okumanya/features/profile/presentation/bloc/profile_bloc.dart'
    as _i860;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioModule = _$DioModule();
    final connectivityModule = _$ConnectivityModule();
    gh.factory<_i639.ReadingBloc>(() => _i639.ReadingBloc());
    gh.factory<_i872.HomeBloc>(() => _i872.HomeBloc());
    gh.factory<_i860.ProfileBloc>(() => _i860.ProfileBloc());
    gh.lazySingleton<_i361.Dio>(() => dioModule.dio);
    gh.lazySingleton<_i726.AnalyticsService>(() => _i726.AnalyticsService());
    gh.lazySingleton<_i895.Connectivity>(() => connectivityModule.connectivity);
    gh.lazySingleton<_i751.AuthService>(() => _i751.AuthService());
    gh.lazySingleton<_i596.BooksRemoteDataSource>(
        () => _i596.BooksRemoteDataSourceImpl(gh<_i361.Dio>()));
    gh.lazySingleton<_i885.CacheManager>(() => _i885.HiveCacheManager());
    gh.lazySingleton<_i650.AuthRemoteDataSource>(
        () => _i650.AuthRemoteDataSourceImpl(gh<_i361.Dio>()));
    gh.lazySingleton<_i1032.NetworkInfo>(() => _i1032.NetworkInfoImpl());
    gh.lazySingleton<_i1027.PerformanceService>(
        () => _i1027.PerformanceService(gh<_i726.AnalyticsService>()));
    gh.lazySingleton<_i1050.BooksLocalDataSource>(
        () => _i1050.BooksLocalDataSourceImpl(gh<_i885.CacheManager>()));
    gh.lazySingleton<_i663.AuthRepository>(() => _i292.AuthRepositoryImpl(
          gh<_i650.AuthRemoteDataSource>(),
          gh<_i1032.NetworkInfo>(),
        ));
    gh.factory<_i1033.LoginUseCase>(
        () => _i1033.LoginUseCase(gh<_i663.AuthRepository>()));
    gh.factory<_i592.LoginBloc>(() => _i592.LoginBloc(
          gh<_i1033.LoginUseCase>(),
          gh<_i751.AuthService>(),
        ));
    gh.lazySingleton<_i687.BooksRepository>(() => _i748.BooksRepositoryImpl(
          remoteDataSource: gh<_i596.BooksRemoteDataSource>(),
          localDataSource: gh<_i1050.BooksLocalDataSource>(),
          networkInfo: gh<_i1032.NetworkInfo>(),
        ));
    gh.lazySingleton<_i496.GetBooksByCategory>(
        () => _i496.GetBooksByCategory(gh<_i687.BooksRepository>()));
    gh.lazySingleton<_i935.GetBooks>(
        () => _i935.GetBooks(gh<_i687.BooksRepository>()));
    gh.lazySingleton<_i269.SearchBooks>(
        () => _i269.SearchBooks(gh<_i687.BooksRepository>()));
    gh.factory<_i876.BooksBloc>(() => _i876.BooksBloc(
          getBooks: gh<_i935.GetBooks>(),
          searchBooks: gh<_i269.SearchBooks>(),
          getBooksByCategory: gh<_i496.GetBooksByCategory>(),
        ));
    return this;
  }
}

class _$DioModule extends _i1043.DioModule {}

class _$ConnectivityModule extends _i1009.ConnectivityModule {}
