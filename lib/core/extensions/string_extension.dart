import 'package:balibo_station/core/extensions/double_extension.dart';

extension ToDouble on String {
  double toDoubleAsFixed(int fractionDigit) {
    return toDouble().toDoubleAsFixed(fractionDigit);
  }

  double toDouble() {
    return double.tryParse(this) ?? 0.0;
  }

  int toInt() {
    return int.tryParse(this) ?? 0;
  }
}
