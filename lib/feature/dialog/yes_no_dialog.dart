import 'package:balibo_station/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widget/custom_dialog.dart';

Future<bool?> showYesNoDialog(
  BuildContext context, {
  required String title,
  required void Function()? onYesPressed,
}) async {
  return showDialog<bool>(
    context: context,
    builder: (context) => CustomDialog(
      children: [
        Icon(Icons.error_outline_sharp, size: 60.r),
        SizedBox(height: 24.h),
        Text(
          title,
          style: context.style.titleMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 27.h),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text(
                  'Xeyr',
                  style:
                      context.style.titleMedium?.copyWith(color: Colors.white),
                ),
              ),
            ),
            SizedBox(width: 16.r),
            Expanded(
              child: ElevatedButton(
                onPressed: onYesPressed,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text(
                  'Bəli',
                  style:
                      context.style.titleMedium?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
