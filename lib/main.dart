import 'package:balibo_station/core/di.dart';
import 'package:balibo_station/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'feature/app/app.dart';

Future<void> main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const StationApp());
}
