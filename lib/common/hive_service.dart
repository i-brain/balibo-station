import 'package:balibo_station/core/constants/hive_keys.dart';
import 'package:balibo_station/core/extensions/string_extension.dart';
import 'package:hive/hive.dart';

part '../core/constants/hive_box_names.dart';

class HiveService {
  late final Box<String> _printerSettings;

  Future<void> init() async {
    _printerSettings = await Hive.openBox<String>(_printerSettingsBox);
  }

  bool get printReceipt =>
      _printerSettings.get(HiveKeys.printReceipt)?.toBool() ?? false;

  Future<void> savePrintReceipt(bool value) async {
    await _printerSettings.put(HiveKeys.printReceipt, value.toString());
  }

  Future<void> save(bool key, Object value) async {}

  String get printerUrl => _printerSettings.get(HiveKeys.printerUrl) ?? '';

  Future<void> savePrinterUrl(String value) async {
    await _printerSettings.put(HiveKeys.printerUrl, value);
  }
}
