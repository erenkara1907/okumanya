import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'dart:developer' as developer;
import '../analytics/analytics_service.dart';

/// Performance monitoring service for tracking app performance,
/// memory usage, and identifying bottlenecks
@lazySingleton
class PerformanceService {
  final AnalyticsService _analytics;
  final Map<String, DateTime> _startTimes = {};
  final Map<String, List<double>> _metrics = {};

  PerformanceService(this._analytics);

  /// Start measuring performance for an operation
  void startMeasurement(String operationName) {
    _startTimes[operationName] = DateTime.now();
    
    if (kDebugMode) {
      developer.Timeline.startSync(operationName);
      print('⏱️ Started measuring: $operationName');
    }
  }

  /// End measurement and record performance
  Future<Duration?> endMeasurement(String operationName) async {
    final endTime = DateTime.now();
    final startTime = _startTimes.remove(operationName);
    
    if (startTime == null) {
      if (kDebugMode) {
        print('⚠️ No start time found for operation: $operationName');
      }
      return null;
    }

    final duration = endTime.difference(startTime);
    
    if (kDebugMode) {
      developer.Timeline.finishSync();
      print('✅ Completed $operationName in ${duration.inMilliseconds}ms');
    }

    // Track performance with analytics
    await _analytics.trackPerformance(operationName, duration);
    
    // Store metric for analysis
    _addMetric(operationName, duration.inMilliseconds.toDouble());
    
    return duration;
  }

  /// Measure a function execution time
  Future<T> measureOperation<T>(
    String operationName,
    Future<T> Function() operation,
  ) async {
    startMeasurement(operationName);
    
    try {
      final result = await operation();
      await endMeasurement(operationName);
      return result;
    } catch (e) {
      await endMeasurement(operationName);
      rethrow;
    }
  }

  /// Measure a synchronous function execution time
  T measureSyncOperation<T>(
    String operationName,
    T Function() operation,
  ) {
    final startTime = DateTime.now();
    
    if (kDebugMode) {
      developer.Timeline.startSync(operationName);
    }
    
    try {
      final result = operation();
      
      final endTime = DateTime.now();
      final duration = endTime.difference(startTime);
      
      if (kDebugMode) {
        developer.Timeline.finishSync();
        print('⚡ Sync operation $operationName: ${duration.inMilliseconds}ms');
      }
      
      // Fire and forget analytics tracking
      _analytics.trackPerformance(operationName, duration);
      _addMetric(operationName, duration.inMilliseconds.toDouble());
      
      return result;
    } catch (e) {
      if (kDebugMode) {
        developer.Timeline.finishSync();
      }
      rethrow;
    }
  }

  /// Track widget build performance
  void trackWidgetBuild(String widgetName, Duration buildTime) {
    if (kDebugMode) {
      print('🎨 Widget $widgetName built in ${buildTime.inMicroseconds}μs');
    }
    
    _analytics.trackEvent('widget_build_performance', parameters: {
      'widget_name': widgetName,
      'build_time_microseconds': buildTime.inMicroseconds,
    });
    
    _addMetric('widget_build_$widgetName', buildTime.inMicroseconds.toDouble());
  }

  /// Track memory usage
  Future<void> trackMemoryUsage(String context) async {
    if (kDebugMode) {
      print('🧠 Memory tracking: $context');
      
      await _analytics.trackEvent('memory_usage', parameters: {
        'context': context,
      });
    }
  }

  /// Track network performance
  Future<void> trackNetworkRequest({
    required String url,
    required String method,
    required Duration duration,
    required int statusCode,
    int? requestSize,
    int? responseSize,
  }) async {
    await _analytics.trackEvent('network_performance', parameters: {
      'url': url,
      'method': method,
      'duration_ms': duration.inMilliseconds,
      'status_code': statusCode,
      'request_size': requestSize,
      'response_size': responseSize,
    });

    _addMetric('network_${method.toLowerCase()}', duration.inMilliseconds.toDouble());
    
    if (kDebugMode) {
      print('🌐 $method $url: ${duration.inMilliseconds}ms ($statusCode)');
    }
  }

  /// Track app startup time
  Future<void> trackAppStartup(Duration startupTime) async {
    await _analytics.trackEvent('app_startup', parameters: {
      'startup_time_ms': startupTime.inMilliseconds,
    });
    
    _addMetric('app_startup', startupTime.inMilliseconds.toDouble());
    
    if (kDebugMode) {
      print('🚀 App started in ${startupTime.inMilliseconds}ms');
    }
  }

  /// Track frame rendering performance
  void trackFrameTime(Duration frameTime) {
    if (frameTime.inMilliseconds > 16) { // > 16ms indicates dropped frame
      _analytics.trackEvent('frame_performance', parameters: {
        'frame_time_ms': frameTime.inMilliseconds,
        'dropped_frame': true,
      });
      
      if (kDebugMode) {
        print('🖼️ Dropped frame: ${frameTime.inMilliseconds}ms');
      }
    }
    
    _addMetric('frame_time', frameTime.inMilliseconds.toDouble());
  }

  /// Get performance statistics for an operation
  Map<String, dynamic> getPerformanceStats(String operationName) {
    final metrics = _metrics[operationName];
    if (metrics == null || metrics.isEmpty) {
      return {};
    }

    metrics.sort();
    final count = metrics.length;
    final sum = metrics.reduce((a, b) => a + b);
    final average = sum / count;
    final median = count.isOdd 
        ? metrics[count ~/ 2]
        : (metrics[count ~/ 2 - 1] + metrics[count ~/ 2]) / 2;
    final min = metrics.first;
    final max = metrics.last;

    return {
      'operation': operationName,
      'count': count,
      'average_ms': average,
      'median_ms': median,
      'min_ms': min,
      'max_ms': max,
      'total_ms': sum,
    };
  }

  /// Get all performance statistics
  Map<String, Map<String, dynamic>> getAllStats() {
    final stats = <String, Map<String, dynamic>>{};
    for (final operationName in _metrics.keys) {
      stats[operationName] = getPerformanceStats(operationName);
    }
    return stats;
  }

  /// Reset all metrics (useful for testing or periodic cleanup)
  void resetMetrics() {
    _metrics.clear();
    _startTimes.clear();
    
    if (kDebugMode) {
      print('📊 Performance metrics reset');
    }
  }

  /// Log performance summary to analytics
  Future<void> logPerformanceSummary() async {
    final stats = getAllStats();
    
    for (final entry in stats.entries) {
      await _analytics.trackEvent('performance_summary', parameters: {
        'operation': entry.key,
        ...entry.value,
      });
    }
    
    if (kDebugMode) {
      print('📈 Performance summary logged: ${stats.length} operations');
    }
  }

  void _addMetric(String operationName, double value) {
    _metrics.putIfAbsent(operationName, () => <double>[]).add(value);
    
    // Keep only last 100 measurements to prevent memory leaks
    final list = _metrics[operationName]!;
    if (list.length > 100) {
      list.removeRange(0, list.length - 100);
    }
  }
}