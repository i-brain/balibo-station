extension ToDouble on double {
  double toDoubleAsFixed(int fractionDigit) {
    return double.parse(toStringAsFixed(fractionDigit));
  }
}
