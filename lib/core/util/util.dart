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
}
