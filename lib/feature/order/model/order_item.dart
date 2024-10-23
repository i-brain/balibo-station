class OrderItem {
  String? id;
  String orderId;
  String productId;
  String name;
  double price;
  int quantity;
  int status;
  String stationId;
  String username;
  int tableNumber;
  DateTime createdAt;

  OrderItem({
    this.id,
    required this.orderId,
    required this.productId,
    required this.name,
    required this.price,
    required this.username,
    required this.quantity,
    required this.status,
    required this.stationId,
    required this.tableNumber,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'productId': productId,
      'name': name,
      'username': username,
      'price': price,
      'quantity': quantity,
      'status': status,
      'stationId': stationId,
      'tableNumber': tableNumber,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory OrderItem.fromMap(String id, Map<String, dynamic> map) {
    return OrderItem(
      id: id,
      orderId: map['orderId'] as String,
      username: map['username'] as String,
      productId: map['productId'] as String,
      name: map['name'] as String,
      price: map['price'] as double,
      quantity: map['quantity'] as int,
      status: map['status'] as int,
      stationId: map['stationId'] as String,
      tableNumber: map['tableNumber'] as int,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }
}
