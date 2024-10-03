import 'dart:io';
import 'package:balibo_station/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.onTap,
    this.isLoading = false,
    this.backgroundColor,
  });
  final String title;
  final bool isLoading;
  final void Function() onTap;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? context.colors.primary,
          foregroundColor: context.colors.onPrimary,
        ),
        child: Padding(
          padding: padding,
          child: isLoading
              ? const CircularProgressIndicator.adaptive()
              : Text(
                  title,
                  style: context.style.titleLarge?.copyWith(
                    color: context.colors.onPrimary,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }

  EdgeInsetsGeometry get padding {
    if (Platform.isIOS) {
      return EdgeInsets.all(isLoading ? 14.0 : 10.0).r;
    }
    return EdgeInsets.all(isLoading ? 6.0 : 10.0).r;
  }
}
