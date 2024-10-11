// ignore_for_file: public_member_api_docs, sort_constructors_first
class TableHistoryItem {
  String? id;
  String productId;
  String tableHistoryId;
  String name;
  double price;
  int quantity;
  DateTime createdAt;

  TableHistoryItem({
    this.id,
    required this.productId,
    required this.tableHistoryId,
    required this.name,
    required this.price,
    required this.quantity,
    DateTime? createdAt,
  }) : createdAt = (createdAt ?? DateTime.now());

  Map<String, dynamic> toMap() {
    return {
      'table_history_id': tableHistoryId,
      'name': name,
      'price': price,
      'quantity': quantity,
      'product_id': productId,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory TableHistoryItem.fromMap(String id, Map<String, dynamic> map) {
    return TableHistoryItem(
      id: id,
      productId: map['product_id'] as String,
      tableHistoryId: map['table_history_id'] as String,
      name: map['name'] as String,
      price: map['price'] as double,
      quantity: map['quantity'] as int,
    );
  }

  TableHistoryItem copyWith({
    String? id,
    String? productId,
    String? tableHistoryId,
    String? name,
    double? price,
    int? quantity,
    DateTime? createdAt,
  }) {
    return TableHistoryItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      tableHistoryId: tableHistoryId ?? this.tableHistoryId,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
