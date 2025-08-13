import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:okumanya/src/app/pages/home/bloc/home/home_bloc.dart';
import 'package:okumanya/src/app/pages/home/bloc/reading/reading_bloc.dart';
import 'package:okumanya/src/app/pages/login/bloc/login_bloc.dart';
import 'package:okumanya/src/app/pages/profile/bloc/profile_bloc.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'generated/codegen_loader.g.dart';
import 'src/app/my_app.dart';
import 'src/shared/hive/hive_init.dart';
import 'src/shared/config/app_config.dart';
import 'src/shared/di/service_locator.dart';
import 'src/shared/error/global_error_handler.dart';
import 'src/shared/error/bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize global error handling
  GlobalErrorHandler.initialize();
  
  // Set up BLoC observer for debugging
  Bloc.observer = AppBlocObserver();

  // Initialize app configuration from environment variables
  await AppConfig.initialize();

  // Initialize dependency injection
  await initializeDependencies();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await EasyLocalization.ensureInitialized();

  final appDocumentDirection = await path_provider.getApplicationDocumentsDirectory();

  await hiveInit(appDocumentDirection);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<LoginBloc>()),
        BlocProvider(create: (context) => sl<HomeBloc>()),
        BlocProvider(create: (context) => sl<ReadingBloc>()),
        BlocProvider(create: (context) => sl<ProfileBloc>()),
      ],
      child: EasyLocalization(
        supportedLocales: const [
          Locale('tr', 'TR'),
        ],
        path: 'assets/lang',
        fallbackLocale: const Locale('tr', 'TR'),
        // flutter pub run easy_localization:generate --source-dir ./assets/lang
        assetLoader: const CodegenLoader(),
        child: const MyApp(),
      ),
    ),
  );
}
