import 'package:balibo_station/feature/app/service/admin.dart';
import 'package:balibo_station/feature/table/model/table_history_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TableHistoryItemService {
  final AdminService _adminService;

  TableHistoryItemService({required AdminService adminService})
      : _adminService = adminService;

  Future<CollectionReference> get _tableHistoryItemsCollection async =>
      (await _adminService.adminDoc).collection('table_history_items');

  Future<List<TableHistoryItem>> getTableHistoryItemsByTableHistoryId(
      String tableHistoryId) async {
    final tableHistoryItemsCollection = await _tableHistoryItemsCollection;

    final snapshot = await tableHistoryItemsCollection
        .where('table_history_id', isEqualTo: tableHistoryId)
        .get();

    final itemsMap = <String, TableHistoryItem>{};

    for (var element in snapshot.docs) {
      final item = TableHistoryItem.fromMap(
          element.id, element.data() as Map<String, dynamic>);
      if (itemsMap.containsKey(item.productId)) {
        itemsMap[item.productId] = itemsMap[item.productId]!.copyWith(
            quantity: itemsMap[item.productId]!.quantity + item.quantity);
      } else {
        itemsMap[item.productId] = item;
      }
    }

    return itemsMap.values.toList();

    // final historyItems = <TableHistoryItem>[];

    // for (var doc in snapshot.docs) {
    //   historyItems.add(
    //       TableHistoryItem.fromMap(doc.id, doc.data() as Map<String, dynamic>));
    // }

    // return historyItems;
  }

  Future<void> updateTableHistoryItems(List<TableHistoryItem> items) async {
    final tableHistoryItemsCollection = await _tableHistoryItemsCollection;

    WriteBatch batch = FirebaseFirestore.instance.batch();

    for (var item in items) {
      if (item.id != null) {
        final docRef = tableHistoryItemsCollection.doc(item.id);
        batch.update(docRef, item.toMap());
      }
    }

    await batch.commit();
  }

  Future<void> deleteTableHistoryItemById(String itemId) async {
    final tableHistoryItemsCollection = await _tableHistoryItemsCollection;

    await tableHistoryItemsCollection.doc(itemId).delete();
  }
}
