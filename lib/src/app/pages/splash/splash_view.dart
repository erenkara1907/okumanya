import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../shared/hive/hive_constants.dart';
import '../../navigation/routes/app_router.gr.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    bool isLogged = Hive.box(HiveBoxConstants.isLogged).get("isLogged", defaultValue: false);
    initialize(context).whenComplete(
      () {
        Future.delayed(
          const Duration(seconds: 2),
          () {
            context.router.replace(const MainRoute());
            // isLogged
            //     ? context.router.popAndPush(const MainRoute())
            //     : context.router.popAndPush(const LoginRoute());
          },
        );
      },
    );
    super.initState();
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
