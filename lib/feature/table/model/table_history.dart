import 'package:balibo_station/feature/table/model/table_history_item.dart';

class TableHistory {
  String? id;
  DateTime createdAt;
  DateTime updatedAt;
  double sum;
  int tableNumber;
  int status;
  List<TableHistoryItem> items;

  TableHistory({
    this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.tableNumber,
    required this.sum,
    required this.status,
    required this.items,
  });

  Map<String, dynamic> toMap() {
    return {
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'table_number': tableNumber,
      'sum': sum,
      'status': status,
    };
  }

  factory TableHistory.fromMap(
      String id, Map<String, dynamic> map, List<TableHistoryItem> items) {
    return TableHistory(
      id: id,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
      tableNumber: map['table_number'] as int,
      status: map['status'] as int,
      sum: map['sum'],
      items: items,
    );
  }
}
