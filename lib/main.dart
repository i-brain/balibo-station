import 'package:balibo_station/common/hive_service.dart';
import 'package:balibo_station/core/di.dart';
import 'package:balibo_station/core/util/util.dart';
import 'package:balibo_station/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'feature/app/presentation/page/app.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  setupLocator();
  await Hive.initFlutter();

  await getIt<HiveService>().init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // await AppUtil.requestPermission(Permission.storage);
  await AppUtil.requestPermission(Permission.bluetoothConnect);
  await AppUtil.requestPermission(Permission.bluetoothScan);
  await AppUtil.requestPermission(Permission.bluetooth);
  runApp(const StationApp());
}
