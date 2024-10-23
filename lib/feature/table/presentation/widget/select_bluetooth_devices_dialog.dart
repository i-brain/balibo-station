import 'package:balibo_station/common/hive_service.dart';
import 'package:balibo_station/core/di.dart';
import 'package:balibo_station/core/util/app_util.dart';
import 'package:flutter/material.dart';

class SelectBlutoothDevicesDialog extends StatefulWidget {
  const SelectBlutoothDevicesDialog({super.key});
  static Future<dynamic> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return const SelectBlutoothDevicesDialog();
      },
    );
  }

  @override
  State<SelectBlutoothDevicesDialog> createState() =>
      _SelectBlutoothDevicesDialogState();
}

class _SelectBlutoothDevicesDialogState
    extends State<SelectBlutoothDevicesDialog> {
  List _devices = [];

  final _isLoading = ValueNotifier(false);

  void _fetchDevices() async {
    final result = await AppUtil.getBluetooth();
    setState(() {
      _devices = result;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchDevices();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: AlertDialog(
        content: ValueListenableBuilder(
          valueListenable: _isLoading,
          builder: (_, isLoading, child) {
            return SizedBox(
              height: 200,
              width: 200,
              child: _devices.isEmpty || isLoading
                  ? const SizedBox(
                      height: 100,
                      child: Center(child: CircularProgressIndicator()))
                  : child,
            );
          },
          child: ListView.builder(
            itemCount: _devices.isNotEmpty ? _devices.length : 0,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () async {
                  String select = _devices[index];
                  List list = select.split("#");
                  // String name = list[0];
                  String mac = list[1];
                  _isLoading.value = true;
                  Future.delayed(const Duration(seconds: 4), () {
                    _isLoading.value = false;
                  });
                  await AppUtil.setConnect(mac);
                  _isLoading.value = false;
                  getIt<HiveService>().savePrinterUrl(mac);
                },
                title: Text('${_devices[index]}'),
                subtitle: const Text("Click to connect"),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Ok'),
          )
        ],
      ),
    );
  }
}
