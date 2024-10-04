import 'package:balibo_station/feature/app/service/admin.dart';
import 'package:balibo_station/feature/login/service/user.dart';
import 'package:balibo_station/feature/order/core/enum/order_status.dart';
import 'package:balibo_station/feature/order/model/order_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderService {
  final AdminService _adminService;
  final UserService _userService;

  OrderService(
      {required AdminService adminService, required UserService userService})
      : _adminService = adminService,
        _userService = userService;

  Future<CollectionReference> get _orderItemsCollection async {
    return (await _adminService.adminDoc).collection('order_items');
  }

  Stream<List<OrderItem>> getActiveOrders() {
    return _getOrdersByStatus(OrderStatusEnum.active.value);
  }

  Stream<List<OrderItem>> getReadyOrders() {
    return _getOrdersByStatus(OrderStatusEnum.ready.value);
  }

  Stream<List<OrderItem>> _getOrdersByStatus(int status) async* {
    final orderItemsCollection = await _orderItemsCollection;
    final stationId = await _userService.stationId;

    yield* orderItemsCollection
        .where('status', isEqualTo: status)
        .where('stationId', isEqualTo: stationId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return OrderItem.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<void> makeOrderItemReady(String id) async {
    final orderItemsCollection = await _orderItemsCollection;

    await orderItemsCollection.doc(id).update({
      'status': OrderStatusEnum.ready.value,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
