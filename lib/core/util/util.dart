import 'dart:io';

import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

abstract class AppUtil {
  static void showSuccessSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Success'),
        backgroundColor: Colors.green,
      ),
    );
  }

  static void showErrorSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Error'),
        backgroundColor: Colors.red,
      ),
    );
  }

  static Future<bool> requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      late final PermissionStatus result;
      if (permission == Permission.storage) {
        result = await _checkStoragePermissionStatus();
      } else {
        result = await permission.request();
      }
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  static Future<PermissionStatus> _checkStoragePermissionStatus() async {
    PermissionStatus status;

    if (Platform.isAndroid) {
      final deviceInfoPlugin = DeviceInfoPlugin();
      final info = await deviceInfoPlugin.androidInfo;

      if ((info.version.sdkInt) >= 33) {
        status = await Permission.manageExternalStorage.request();
      } else {
        status = await Permission.storage.request();
      }
    } else {
      status = await Permission.storage.request();
    }

    return status;
  }
}
