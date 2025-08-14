import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../../shared/hive/hive_constants.dart';
import '../../../../shared/navigation/routes/app_router.gr.dart';
import '../../../../core/auth/auth_service.dart';
import '../../../../shared/di/service_locator.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    _initializeAndNavigate();
    super.initState();
  }

  Future<void> _initializeAndNavigate() async {
    // Initialize device info
    await initialize(context);
    
    // Add minimum splash duration
    await Future.delayed(const Duration(seconds: 2));
    
    if (!mounted) return;
    
    // Check authentication status
    final authService = getIt<AuthService>();
    final isLoggedIn = await authService.validateToken();
    
    if (isLoggedIn) {
      // User has valid token, go to main page
      context.router.replace(const MainRoute());
    } else {
      // No valid token, go to login page
      context.router.replace(const LoginRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF12A4B8),
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          width: MediaQuery.of(context).size.width * 0.4,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

Future initialize(BuildContext context) async {
  await getId();
}

Future<String?> getId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    var iosDeviceInfo = await deviceInfo.iosInfo;
    iosDeviceInfo.identifierForVendor;
    await Hive.box(HiveBoxConstants.deviceId).put("deviceId", iosDeviceInfo.identifierForVendor);
  } else if (Platform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    androidDeviceInfo.id;
    await Hive.box(HiveBoxConstants.deviceId).put("deviceId", androidDeviceInfo.id);
  }
  return "";
}