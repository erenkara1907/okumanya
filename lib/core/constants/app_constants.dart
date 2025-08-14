/// Application-wide constants
class AppConstants {
  AppConstants._();

  // API Constants
  static const int apiTimeout = 30000; // 30 seconds
  static const int connectTimeout = 10000; // 10 seconds
  static const int receiveTimeout = 30000; // 30 seconds

  // Cache Constants
  static const int cacheMaxAge = 86400000; // 24 hours in milliseconds
  static const int maxCacheSize = 50 * 1024 * 1024; // 50MB

  // Authentication Constants
  static const int tokenExpiryHours = 24;
  static const int refreshThresholdHours = 12;

  // Pagination Constants
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double defaultRadius = 12.0;
  static const double cardElevation = 2.0;

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);

  // Debounce Durations
  static const Duration searchDebounce = Duration(milliseconds: 300);
  static const Duration actionDebounce = Duration(milliseconds: 500);

  // Reading Progress Constants
  static const double minProgress = 0.0;
  static const double maxProgress = 100.0;
  static const double progressStep = 1.0;
}