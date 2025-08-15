import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';
  static String get apiVersion => dotenv.env['API_VERSION'] ?? 'v1';
  static String get emailDomain => dotenv.env['EMAIL_DOMAIN'] ?? '';
  static String get environment => dotenv.env['ENVIRONMENT'] ?? 'development';
  static int get apiTimeout =>
      int.tryParse(dotenv.env['API_TIMEOUT'] ?? '30000') ?? 30000;

  static String get fullApiUrl => '$baseUrl/$apiVersion';

  static bool get isProduction => environment == 'production';
  static bool get isDevelopment => environment == 'development';

  static Future<void> initialize() async {
    await dotenv.load(fileName: '.env');
  }
}
