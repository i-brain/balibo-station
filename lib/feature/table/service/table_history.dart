import 'package:balibo_station/core/exceptions/active_table_history_not_found.dart';
import 'package:balibo_station/feature/app/service/admin.dart';
import 'package:balibo_station/feature/table/core/enum/table_history_status.dart';
import 'package:balibo_station/feature/table/model/table_history.dart';
import 'package:balibo_station/feature/table/service/table.dart';
import 'package:balibo_station/feature/table/service/table_history_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TableHistoryService {
  final TableHistoryItemService _tableHistoryItemService;
  final TableService _tableService;
  final AdminService _adminService;

  TableHistoryService(
    this._tableHistoryItemService,
    this._tableService,
    this._adminService,
  );

  Future<CollectionReference> get _tableHistoryCollection async =>
      (await _adminService.adminDoc).collection('table_history');

  Future<void> actiavteTable(int tableNumber) async {
    await _tableService.updateTableStatusByTableNumber(
      tableNumber,
      TableStatusEnum.active.value,
    );

    final tableHistory = await _getTableHistoryByTableNumberAndStatus(
      tableNumber,
      TableStatusEnum.active.value,
    );
    if (tableHistory == null) {
      await _addTableHistory(tableNumber);
    }
  }

  Future<TableHistory> getTableHistory(int tableNumber) async {
    final tableHistory = await _getTableHistoryByTableNumberAndStatus(
      tableNumber,
      TableStatusEnum.active.value,
    );
    if (tableHistory == null) {
      throw ActiveTableHistoryNotFoundException(tableNumber: tableNumber);
    }

    final historyItems = await _tableHistoryItemService
        .getTableHistoryItemsByTableHistoryId(tableHistory.id!);

    tableHistory.items = historyItems;

    return tableHistory;
  }

  Future<void> _addTableHistory(int tableNumber) async {
    final tableHistoryCollection = await _tableHistoryCollection;

    final TableHistory tableHistory = TableHistory(
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      tableNumber: tableNumber,
      status: TableStatusEnum.active.value,
      sum: 0,
      items: [],
    );

    await tableHistoryCollection.add(tableHistory.toMap());
  }

  Future<void> updateTableHistory(TableHistory tableHistory) async {
    final tableHistoryCollection = await _tableHistoryCollection;

    tableHistory.updatedAt = DateTime.now();

    await tableHistoryCollection.doc(tableHistory.id).update({
      'updated_at': tableHistory.updatedAt.toIso8601String(),
      'table_number': tableHistory.tableNumber,
      'status': tableHistory.status,
    });

    await _tableHistoryItemService.updateTableHistoryItems(tableHistory.items);
  }

  Future<TableHistory?> _getTableHistoryByTableNumberAndStatus(
    int tableNumber,
    int status,
  ) async {
    final tableHistoryCollection = await _tableHistoryCollection;

    QuerySnapshot querySnapshot = await tableHistoryCollection
        .where('table_number', isEqualTo: tableNumber)
        .where('status', isEqualTo: status)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final queryDocumentSnapshot = querySnapshot.docs.first;
      return TableHistory.fromMap(
        queryDocumentSnapshot.id,
        queryDocumentSnapshot.data() as Map<String, dynamic>,
        [],
      );
    }

    return null;
  }
}
