import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import '../utils/date_utils.dart';

/// Custom analytics service for tracking user behavior,
/// performance metrics, and errors (Firebase removed)
@lazySingleton
class AnalyticsService {
  final bool _isEnabled;

  AnalyticsService() : _isEnabled = !kDebugMode;

  /// Initialize analytics service
  Future<void> initialize() async {
    try {
      if (kDebugMode) {
        print('📊 Custom Analytics service initialized in debug mode');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Failed to initialize analytics: $e');
      }
    }
  }

  /// Set user properties for analytics
  Future<void> setUserProperties({
    required String userId,
    String? userType,
    String? preferredLanguage,
    String? readingLevel,
  }) async {
    if (!_isEnabled) return;

    try {
      // Custom analytics implementation
      // This can be replaced with your preferred analytics solution
      // (Mixpanel, Amplitude, PostHog, etc.)

      if (kDebugMode) {
        print(
            '👤 User properties set: $userId, $userType, $preferredLanguage, $readingLevel');
      }
    } catch (e) {
      await _recordError(e, 'setUserProperties');
    }
  }

  /// Track screen views
  Future<void> trackScreen(String screenName,
      {Map<String, dynamic>? parameters}) async {
    if (!_isEnabled) return;

    try {
      // Custom screen tracking implementation
      if (kDebugMode) {
        print('📱 Screen tracked: $screenName ${parameters ?? ''}');
      }
    } catch (e) {
      await _recordError(e, 'trackScreen');
    }
  }

  /// Track user events
  Future<void> trackEvent(String eventName,
      {Map<String, dynamic>? parameters}) async {
    if (!_isEnabled) return;

    try {
      // Custom event tracking implementation
      if (kDebugMode) {
        print('📊 Event tracked: $eventName ${parameters ?? ''}');
      }
    } catch (e) {
      await _recordError(e, 'trackEvent');
    }
  }

  /// Track book-related events
  Future<void> trackBookEvent(
    String action, {
    required String bookId,
    required String bookTitle,
    String? author,
    String? category,
    double? progress,
    int? timeSpent,
  }) async {
    final parameters = <String, dynamic>{
      'book_id': bookId,
      'book_title': bookTitle,
      if (author != null) 'author': author,
      if (category != null) 'category': category,
      if (progress != null) 'progress': progress,
      if (timeSpent != null) 'time_spent': timeSpent,
    };

    await trackEvent('book_$action', parameters: parameters);
  }

  /// Track reading session with enhanced time analytics
  Future<void> trackReadingSession({
    required String bookId,
    required String sessionId,
    required int durationMinutes,
    required int pagesRead,
    double? startProgress,
    double? endProgress,
    DateTime? sessionStart,
  }) async {
    final now = DateTime.now();
    final timeCategory = now.getReadingTimeCategory(locale: 'tr_TR');
    final isReadingHours = now.isReadingHours;

    await trackEvent('reading_session_complete', parameters: {
      'book_id': bookId,
      'session_id': sessionId,
      'duration_minutes': durationMinutes,
      'pages_read': pagesRead,
      'start_progress': startProgress,
      'end_progress': endProgress,
      'progress_delta': (endProgress ?? 0) - (startProgress ?? 0),
      'reading_time_category': timeCategory,
      'is_prime_reading_hours': isReadingHours,
      'session_date': now.toFormattedDate(locale: 'tr_TR'),
      'day_of_week': now.weekday,
      'hour_of_day': now.hour,
    });
  }

  /// Track user engagement
  Future<void> trackEngagement(String action,
      {Map<String, dynamic>? parameters}) async {
    await trackEvent('user_engagement', parameters: {
      'action': action,
      ...?parameters,
    });
  }

  /// Track app performance metrics
  Future<void> trackPerformance(String operation, Duration duration) async {
    if (!_isEnabled) return;

    try {
      // Custom performance tracking implementation
      await trackEvent('performance_metric', parameters: {
        'operation': operation,
        'duration_ms': duration.inMilliseconds,
      });

      if (kDebugMode) {
        print(
            '⚡ Performance tracked: $operation took ${duration.inMilliseconds}ms');
      }
    } catch (e) {
      await _recordError(e, 'trackPerformance');
    }
  }

  /// Record errors and exceptions
  Future<void> recordError(
    dynamic exception,
    StackTrace? stackTrace, {
    String? reason,
    Map<String, dynamic>? customKeys,
    bool fatal = false,
  }) async {
    await _recordError(exception, reason,
        stackTrace: stackTrace, customKeys: customKeys, fatal: fatal);
  }

  Future<void> _recordError(
    dynamic exception,
    String? reason, {
    StackTrace? stackTrace,
    Map<String, dynamic>? customKeys,
    bool fatal = false,
  }) async {
    try {
      // Custom error recording implementation
      // This can be replaced with your preferred error tracking solution
      // (Sentry, Bugsnag, etc.)

      if (kDebugMode) {
        print('🚨 Error recorded: $exception');
        if (reason != null) print('Reason: $reason');
        if (stackTrace != null) print('Stack trace: $stackTrace');
      }
    } catch (e) {
      // Fallback error logging
      if (kDebugMode) {
        print('❌ Failed to record error: $e');
        print('Original error: $exception');
      }
    }
  }

  /// Record custom traces for performance monitoring
  Future<T> traceOperation<T>(
      String operationName, Future<T> Function() operation) async {
    final stopwatch = Stopwatch()..start();

    try {
      final result = await operation();
      stopwatch.stop();

      await trackPerformance(operationName, stopwatch.elapsed);
      return result;
    } catch (e) {
      stopwatch.stop();
      await _recordError(e, 'Operation failed: $operationName');
      rethrow;
    }
  }

  /// Log breadcrumb for error context
  Future<void> logBreadcrumb(String message,
      {Map<String, dynamic>? data}) async {
    if (!_isEnabled) return;

    try {
      // Custom breadcrumb logging implementation
      await trackEvent('breadcrumb', parameters: {
        'message': message,
        ...?data,
      });

      if (kDebugMode) {
        print('🍞 Breadcrumb: $message');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Failed to log breadcrumb: $e');
      }
    }
  }

  /// Test crash functionality (for testing error tracking)
  Future<void> testCrash() async {
    if (kDebugMode) {
      throw Exception('Test crash from AnalyticsService');
    }
  }
}
