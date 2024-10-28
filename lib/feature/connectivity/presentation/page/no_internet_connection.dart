import 'package:balibo_station/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoInternetConnectionPage extends StatefulWidget {
  const NoInternetConnectionPage({super.key});

  @override
  State<NoInternetConnectionPage> createState() =>
      _NoInternetConnectionPageState();
}

class _NoInternetConnectionPageState extends State<NoInternetConnectionPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Internet bağlantısı\nyoxdur',
              textAlign: TextAlign.center,
              style: context.style.titleMedium?.copyWith(fontSize: 32.sp),
            ),
            Text(
              'Davam etmək üçün sabit WiFi şəbəkəsinə və ya mobil dataya qoşulmağınızdan əmin olun',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
