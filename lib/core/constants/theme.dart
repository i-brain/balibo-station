import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get theme {
    const primaryColor = Colors.blueAccent;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xff737373)),
    );
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        onPrimary: Colors.white,
      ),
      useMaterial3: true,
      appBarTheme: const AppBarTheme(centerTitle: true),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        errorStyle: const TextStyle(height: 0),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16).r,
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        focusedErrorBorder: border,
        disabledBorder: border,
        errorBorder: border,
        hintStyle: const TextStyle(color: Color(0xff737373)),
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
        titleSmall: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(fontSize: 16.sp),
        bodyMedium: TextStyle(fontSize: 14.sp),
        bodySmall: TextStyle(fontSize: 12.sp),
      ),
    );
  }
}
