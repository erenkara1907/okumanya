import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

/// Abstract interface for cache operations
abstract class CacheManager {
  /// Stores data with a key
  Future<void> store<T>(String key, T data, {Duration? expiry});

  /// Retrieves data by key
  Future<T?> retrieve<T>(String key);

  /// Checks if data exists and is not expired
  Future<bool> exists(String key);

  /// Removes data by key
  Future<void> remove(String key);

  /// Clears all cached data
  Future<void> clear();

  /// Clears expired data
  Future<void> clearExpired();
}

/// Implementation of CacheManager using Hive
@LazySingleton(as: CacheManager)
class HiveCacheManager implements CacheManager {
  static const String _boxName = 'app_cache';
  static const String _metaBoxName = 'cache_metadata';

  Box<String>? _cacheBox;
  Box<Map>? _metaBox;

  /// Initializes the cache manager
  Future<void> init() async {
    _cacheBox ??= await Hive.openBox<String>(_boxName);
    _metaBox ??= await Hive.openBox<Map>(_metaBoxName);
  }

  @override
  Future<void> store<T>(String key, T data, {Duration? expiry}) async {
    await _ensureInitialized();

    // Store the actual data
    final jsonString = json.encode(data);
    await _cacheBox!.put(key, jsonString);

    // Store metadata if expiry is provided
    if (expiry != null) {
      final expiryTime = DateTime.now().add(expiry).millisecondsSinceEpoch;
      await _metaBox!.put(key, {
        'expiry': expiryTime,
        'created': DateTime.now().millisecondsSinceEpoch,
      });
    }
  }

  @override
  Future<T?> retrieve<T>(String key) async {
    await _ensureInitialized();

    // Check if data is expired
    if (!await exists(key)) {
      return null;
    }

    final jsonString = _cacheBox!.get(key);
    if (jsonString == null) return null;

    try {
      return json.decode(jsonString) as T;
    } catch (e) {
      // If decoding fails, remove the corrupted data
      await remove(key);
      return null;
    }
  }

  @override
  Future<bool> exists(String key) async {
    await _ensureInitialized();

    if (!_cacheBox!.containsKey(key)) {
      return false;
    }

    // Check expiry
    final metadata = _metaBox!.get(key);
    if (metadata != null && metadata['expiry'] != null) {
      final expiryTime = metadata['expiry'] as int;
      final now = DateTime.now().millisecondsSinceEpoch;

      if (now > expiryTime) {
        // Data is expired, remove it
        await remove(key);
        return false;
      }
    }

    return true;
  }

  @override
  Future<void> remove(String key) async {
    await _ensureInitialized();

    await _cacheBox!.delete(key);
    await _metaBox!.delete(key);
  }

  @override
  Future<void> clear() async {
    await _ensureInitialized();

    await _cacheBox!.clear();
    await _metaBox!.clear();
  }

  @override
  Future<void> clearExpired() async {
    await _ensureInitialized();

    final now = DateTime.now().millisecondsSinceEpoch;
    final expiredKeys = <String>[];

    for (final key in _metaBox!.keys) {
      final metadata = _metaBox!.get(key);
      if (metadata != null && metadata['expiry'] != null) {
        final expiryTime = metadata['expiry'] as int;
        if (now > expiryTime) {
          expiredKeys.add(key.toString());
        }
      }
    }

    for (final key in expiredKeys) {
      await remove(key);
    }
  }

  /// Gets cache statistics
  Future<CacheStats> getStats() async {
    await _ensureInitialized();

    final totalItems = _cacheBox!.length;
    var expiredItems = 0;
    var totalSize = 0;

    final now = DateTime.now().millisecondsSinceEpoch;

    for (final key in _cacheBox!.keys) {
      final value = _cacheBox!.get(key);
      if (value != null) {
        totalSize += value.length;
      }

      final metadata = _metaBox!.get(key);
      if (metadata != null && metadata['expiry'] != null) {
        final expiryTime = metadata['expiry'] as int;
        if (now > expiryTime) {
          expiredItems++;
        }
      }
    }

    return CacheStats(
      totalItems: totalItems,
      expiredItems: expiredItems,
      approximateSizeBytes: totalSize,
    );
  }

  Future<void> _ensureInitialized() async {
    if (_cacheBox == null || _metaBox == null) {
      await init();
    }
  }
}

/// Cache statistics model
class CacheStats {
  const CacheStats({
    required this.totalItems,
    required this.expiredItems,
    required this.approximateSizeBytes,
  });

  final int totalItems;
  final int expiredItems;
  final int approximateSizeBytes;

  int get activeItems => totalItems - expiredItems;

  double get approximateSizeMB => approximateSizeBytes / (1024 * 1024);
}
