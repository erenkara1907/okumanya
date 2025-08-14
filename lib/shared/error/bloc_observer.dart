import 'dart:developer' as developer;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../config/app_config.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    if (AppConfig.isDevelopment) {
      developer.log('onCreate -- ${bloc.runtimeType}', name: 'BlocObserver');
    }
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    if (AppConfig.isDevelopment) {
      developer.log('onEvent -- ${bloc.runtimeType}, $event', name: 'BlocObserver');
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (AppConfig.isDevelopment) {
      developer.log('onChange -- ${bloc.runtimeType}, $change', name: 'BlocObserver');
    }
  }

  @override
  void onTransition(Bloc<dynamic, dynamic> bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (AppConfig.isDevelopment) {
      developer.log('onTransition -- ${bloc.runtimeType}, $transition', name: 'BlocObserver');
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    
    developer.log(
      'onError -- ${bloc.runtimeType}',
      name: 'BlocObserver',
      error: error,
      stackTrace: stackTrace,
    );

    // Handle the error globally
    // You could integrate this with your error reporting service
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    if (AppConfig.isDevelopment) {
      developer.log('onClose -- ${bloc.runtimeType}', name: 'BlocObserver');
    }
  }
}