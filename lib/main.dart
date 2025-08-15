import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:okumanya/features/auth/presentation/bloc/login_bloc.dart';
import 'package:okumanya/features/books/presentation/bloc/books_bloc.dart';
import 'package:okumanya/features/home/presentation/bloc/home/home_bloc.dart';
import 'package:okumanya/features/home/presentation/bloc/reading/reading_bloc.dart';
import 'package:okumanya/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'core/app/my_app.dart';
import 'shared/hive/hive_init.dart';
import 'shared/config/app_config.dart';
import 'shared/di/service_locator.dart';
import 'shared/error/global_error_handler.dart';
import 'shared/error/bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize global error handling
  GlobalErrorHandler.initialize();

  // Set up BLoC observer for debugging
  Bloc.observer = AppBlocObserver();

  // Initialize app configuration from environment variables
  await AppConfig.initialize();

  // Initialize dependency injection
  await configureDependencies();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await EasyLocalization.ensureInitialized();

  final appDocumentDirection =
      await path_provider.getApplicationDocumentsDirectory();

  await hiveInit(appDocumentDirection);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<LoginBloc>()),
        BlocProvider(create: (context) => getIt<HomeBloc>()),
        BlocProvider(create: (context) => getIt<ReadingBloc>()),
        BlocProvider(create: (context) => getIt<ProfileBloc>()),
        BlocProvider(create: (context) => getIt<BooksBloc>()),
      ],
      child: EasyLocalization(
        supportedLocales: const [
          Locale('tr', 'TR'),
          Locale('en', 'US'),
        ],
        path: 'assets/lang',
        fallbackLocale: const Locale('tr', 'TR'),
        child: const MyApp(),
      ),
    ),
  );
}
