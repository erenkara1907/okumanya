import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'dart:developer' as developer;
import '../analytics/analytics_service.dart';
import '../performance/performance_service.dart';

/// Comprehensive app monitoring service that combines analytics,
/// performance monitoring, error tracking, and health checks
@lazySingleton
class AppMonitor {
  final AnalyticsService _analytics;
  final PerformanceService _performance;

  // System health metrics
  final Map<String, dynamic> _healthMetrics = {};
  final List<String> _recentErrors = [];
  DateTime? _lastHealthCheck;

  AppMonitor(this._analytics, this._performance);

  /// Initialize monitoring system
  Future<void> initialize() async {
    await _analytics.initialize();

    _logSystemInfo();
    await _performInitialHealthCheck();

    if (kDebugMode) {
      print('📊 AppMonitor initialized successfully');
    }
  }

  /// Monitor app lifecycle events
  void trackAppLifecycle(String event, {Map<String, dynamic>? data}) {
    _analytics.trackEvent('app_lifecycle', parameters: {
      'event': event,
      'timestamp': DateTime.now().toIso8601String(),
      ...?data,
    });

    if (kDebugMode) {
      print('🔄 App lifecycle: $event');
    }
  }

  /// Monitor memory usage and performance
  Future<void> performHealthCheck() async {
    final startTime = DateTime.now();
    _performance.startMeasurement('health_check');

    try {
      // Collect system metrics
      _healthMetrics['timestamp'] = startTime.toIso8601String();
      _healthMetrics['memory_pressure'] = _checkMemoryPressure();
      _healthMetrics['error_rate'] = _calculateErrorRate();
      _healthMetrics['performance_issues'] = _checkPerformanceIssues();

      // Check critical app components
      final componentHealth = await _checkComponentHealth();
      _healthMetrics['components'] = componentHealth;

      _lastHealthCheck = startTime;

      await _performance.endMeasurement('health_check');

      // Report health status
      await _analytics.trackEvent('system_health_check',
          parameters: _healthMetrics);

      // Log warnings for critical issues
      _reportCriticalIssues();

      if (kDebugMode) {
        print('🏥 Health check completed: ${_getHealthSummary()}');
      }
    } catch (e) {
      await _analytics.recordError(e, null, reason: 'health_check_failed');
      if (kDebugMode) {
        print('❌ Health check failed: $e');
      }
    }
  }

  /// Track user interaction and engagement
  void trackUserInteraction(
    String interaction, {
    String? screen,
    String? element,
    Map<String, dynamic>? additionalData,
  }) {
    _analytics.trackEngagement(interaction, parameters: {
      if (screen != null) 'screen': screen,
      if (element != null) 'element': element,
      'timestamp': DateTime.now().toIso8601String(),
      ...?additionalData,
    });

    if (kDebugMode) {
      print('👆 User interaction: $interaction on $screen');
    }
  }

  /// Monitor network requests and API performance
  Future<void> trackNetworkRequest({
    required String endpoint,
    required String method,
    required Duration duration,
    required int statusCode,
    String? errorMessage,
    int? requestSize,
    int? responseSize,
  }) async {
    await _performance.trackNetworkRequest(
      url: endpoint,
      method: method,
      duration: duration,
      statusCode: statusCode,
      requestSize: requestSize,
      responseSize: responseSize,
    );

    // Track API reliability
    final isSuccess = statusCode >= 200 && statusCode < 300;
    await _analytics.trackEvent('api_request', parameters: {
      'endpoint': endpoint,
      'method': method,
      'status_code': statusCode,
      'duration_ms': duration.inMilliseconds,
      'success': isSuccess,
      'error_message': errorMessage,
    });

    if (!isSuccess && errorMessage != null) {
      _recentErrors.add('API $method $endpoint: $errorMessage');
      _trimRecentErrors();
    }
  }

  /// Monitor feature usage and adoption
  void trackFeatureUsage(
    String feature, {
    String? action,
    Map<String, dynamic>? parameters,
  }) {
    _analytics.trackEvent('feature_usage', parameters: {
      'feature': feature,
      if (action != null) 'action': action,
      'session_id': _getSessionId(),
      ...?parameters,
    });

    if (kDebugMode) {
      print('🎯 Feature used: $feature${action != null ? ' ($action)' : ''}');
    }
  }

  /// Track app crashes and exceptions with context
  Future<void> trackException(
    dynamic exception,
    StackTrace? stackTrace, {
    String? context,
    Map<String, dynamic>? additionalData,
    bool fatal = false,
  }) async {
    final errorDetails = {
      'exception': exception.toString(),
      'stack_trace': stackTrace.toString(),
      'context': context,
      'fatal': fatal,
      'timestamp': DateTime.now().toIso8601String(),
      'app_state': _getCurrentAppState(),
      ...?additionalData,
    };

    await _analytics.recordError(
      exception,
      stackTrace,
      reason: context,
      customKeys: errorDetails,
      fatal: fatal,
    );

    _recentErrors.add('${fatal ? "FATAL" : "ERROR"}: $exception');
    _trimRecentErrors();

    if (kDebugMode) {
      print('💥 Exception tracked: $exception');
      if (context != null) print('Context: $context');
    }
  }

  /// Track reading-specific metrics
  Future<void> trackReadingSession({
    required String bookId,
    required String bookTitle,
    required Duration sessionDuration,
    required int pagesRead,
    double? startProgress,
    double? endProgress,
  }) async {
    await _analytics.trackReadingSession(
      bookId: bookId,
      sessionId: _generateSessionId(),
      durationMinutes: sessionDuration.inMinutes,
      pagesRead: pagesRead,
      startProgress: startProgress,
      endProgress: endProgress,
    );

    await _analytics.trackBookEvent(
      'reading_session',
      bookId: bookId,
      bookTitle: bookTitle,
      progress: endProgress,
      timeSpent: sessionDuration.inMinutes,
    );
  }

  /// Get current system health status
  Map<String, dynamic> getHealthStatus() {
    return {
      'last_check': _lastHealthCheck?.toIso8601String(),
      'overall_health': _calculateOverallHealth(),
      'metrics': Map<String, dynamic>.from(_healthMetrics),
      'recent_errors_count': _recentErrors.length,
      'uptime': _calculateUptime(),
    };
  }

  /// Get performance statistics
  Map<String, dynamic> getPerformanceStats() {
    return _performance.getAllStats();
  }

  void _logSystemInfo() {
    final systemInfo = {
      'platform': defaultTargetPlatform.name,
      'is_debug': kDebugMode,
      'is_profile': kProfileMode,
      'is_release': kReleaseMode,
    };

    _analytics.trackEvent('system_info', parameters: systemInfo);
  }

  Future<void> _performInitialHealthCheck() async {
    await performHealthCheck();
  }

  String _checkMemoryPressure() {
    // Simplified memory pressure check
    // In a real implementation, you'd check actual memory usage
    return 'normal'; // 'low', 'normal', 'high', 'critical'
  }

  double _calculateErrorRate() {
    // Calculate error rate based on recent errors
    final recentErrorsCount = _recentErrors.length;
    final hoursUptime = _calculateUptimeHours();

    if (hoursUptime == 0) return 0.0;
    return recentErrorsCount / hoursUptime;
  }

  List<String> _checkPerformanceIssues() {
    final issues = <String>[];

    // Check for common performance issues
    final stats = _performance.getAllStats();

    for (final entry in stats.entries) {
      final operationStats = entry.value;
      final avgTime = operationStats['average_ms'] as double?;

      if (avgTime != null && avgTime > 1000) {
        issues.add('Slow operation: ${entry.key} (${avgTime.toInt()}ms avg)');
      }
    }

    return issues;
  }

  Future<Map<String, bool>> _checkComponentHealth() async {
    return {
      'analytics': true, // Simplified - would check actual service health
      'performance_monitor': true,
      'error_tracking': true,
      'network': true, // Could check network connectivity
    };
  }

  void _reportCriticalIssues() {
    final memoryPressure = _healthMetrics['memory_pressure'] as String?;
    final performanceIssues =
        _healthMetrics['performance_issues'] as List<String>?;

    if (memoryPressure == 'critical') {
      developer.log('🚨 CRITICAL: High memory pressure detected',
          name: 'AppMonitor');
    }

    if (performanceIssues != null && performanceIssues.isNotEmpty) {
      developer.log(
          '⚠️ Performance issues detected: ${performanceIssues.join(", ")}',
          name: 'AppMonitor');
    }
  }

  String _getHealthSummary() {
    final health = _calculateOverallHealth();
    final errorCount = _recentErrors.length;
    return '$health (${errorCount} recent errors)';
  }

  String _calculateOverallHealth() {
    final errorRate = _healthMetrics['error_rate'] as double? ?? 0.0;
    final performanceIssues =
        _healthMetrics['performance_issues'] as List<String>? ?? [];

    if (errorRate > 10 || performanceIssues.length > 5) {
      return 'critical';
    } else if (errorRate > 5 || performanceIssues.length > 2) {
      return 'warning';
    } else {
      return 'healthy';
    }
  }

  Duration _calculateUptime() {
    // Simplified uptime calculation
    // In a real implementation, you'd track app start time
    return const Duration(hours: 1);
  }

  double _calculateUptimeHours() {
    return _calculateUptime().inMilliseconds / (1000 * 60 * 60);
  }

  String _getSessionId() {
    // Generate or retrieve current session ID
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  String _generateSessionId() {
    return '${DateTime.now().millisecondsSinceEpoch}_${DateTime.now().microsecond}';
  }

  Map<String, dynamic> _getCurrentAppState() {
    return {
      'timestamp': DateTime.now().toIso8601String(),
      'recent_errors': _recentErrors.length,
      'health_status': _calculateOverallHealth(),
    };
  }

  void _trimRecentErrors() {
    // Keep only last 50 errors to prevent memory issues
    if (_recentErrors.length > 50) {
      _recentErrors.removeRange(0, _recentErrors.length - 50);
    }
  }
}
