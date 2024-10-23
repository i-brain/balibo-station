import 'package:flutter/material.dart';

class AdminParolDialog extends StatefulWidget {
  const AdminParolDialog({super.key, required this.onPasswordCorrect});

  final VoidCallback onPasswordCorrect;

  static void show(BuildContext context, VoidCallback onPasswordCorrect) {
    showDialog(
      context: context,
      builder: (context) {
        return AdminParolDialog(onPasswordCorrect: onPasswordCorrect);
      },
    );
  }

  @override
  State<AdminParolDialog> createState() => _AdminParolDialogState();
}

class _AdminParolDialogState extends State<AdminParolDialog> {
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: _passwordController,
            obscureText: true,
            autofocus: true,
            decoration: const InputDecoration(
              fillColor: Colors.transparent,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (checkPassword()) {
                  Navigator.pop(context);
                  widget.onPasswordCorrect.call();
                }
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      ],
    );
  }

  bool checkPassword() {
    return _passwordController.text == adminPassword;
  }

  String get adminPassword => (DateTime.now().day * 100 +
          DateTime.now().day * DateTime.now().month -
          DateTime.now().hour)
      .toString();
}
