import '../config/app_config.dart';

class Endpoints {
  const Endpoints._();

  static String get baseUrl => AppConfig.fullApiUrl;

  static const login = '/auth/get_token';
  static const getProfile = '/user/profile';
}
