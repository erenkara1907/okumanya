import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'hive_constants.dart';

Future hiveInit(Directory appDocumentDirectory) async {
  await Hive.initFlutter(appDocumentDirectory.path);

  await Hive.openBox(HiveBoxConstants.user);
  await Hive.openBox(HiveBoxConstants.profile);
  await Hive.openBox(HiveBoxConstants.locale);
  await Hive.openBox(HiveBoxConstants.isLogged);
  await Hive.openBox(HiveBoxConstants.deviceId);
  await Hive.openBox(HiveBoxConstants.fcmToken);
  await Hive.openBox(HiveBoxConstants.username);
  await Hive.openBox(HiveBoxConstants.password);
  await Hive.openBox(HiveBoxConstants.rememberMe);
}