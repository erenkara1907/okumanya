import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

final GetIt getIt = GetIt.instance;

/// Configures dependency injection using Injectable and GetIt
@InjectableInit()
Future<void> configureDependencies() async {
  getIt.init();
}