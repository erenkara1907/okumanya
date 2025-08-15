import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

/// Abstract interface for network connectivity checking
abstract class NetworkInfo {
  /// Checks if the device is currently connected to the internet
  Future<bool> get isConnected;

  /// Stream of connectivity changes
  Stream<bool> get onConnectivityChanged;
}

/// Implementation of NetworkInfo using connectivity_plus package
@LazySingleton(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl() : _connectivity = Connectivity();

  final Connectivity _connectivity;

  @override
  Future<bool> get isConnected async {
    try {
      final List<ConnectivityResult> connectivityResults =
          await _connectivity.checkConnectivity();

      return connectivityResults.any((result) =>
          result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi ||
          result == ConnectivityResult.ethernet);
    } catch (e) {
      return false;
    }
  }

  @override
  Stream<bool> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged.map((connectivityResults) {
      return connectivityResults.any((result) =>
          result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi ||
          result == ConnectivityResult.ethernet);
    });
  }
}
