class ActiveTableHistoryNotFoundException implements Exception {
  final int tableNumber;

  ActiveTableHistoryNotFoundException({required this.tableNumber});

  @override
  String toString() {
    return 'Masa aktiv deyil!';
  }
}
