import 'package:flutter/material.dart';
import 'feature/app/app.dart';

Future<void> main() async {
  // setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const StationApp());
}
