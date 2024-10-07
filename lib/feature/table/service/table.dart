import 'package:balibo_station/feature/app/service/admin.dart';
import 'package:balibo_station/feature/table/core/enum/table_history_status.dart';
import 'package:balibo_station/feature/table/model/table.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TableService {
  final AdminService _adminService;

  TableService({required AdminService adminService})
      : _adminService = adminService;

  Future<CollectionReference> get _tableCollection async =>
      (await _adminService.adminDoc).collection('tables');

  Future<void> addTable(TableModel table) async {
    final tableCollection = await _tableCollection;

    await tableCollection.add(table.toMap());
  }

  Future<void> updateTableCount(int previousCount, int newCount) async {
    final tableCollection = await _tableCollection;

    WriteBatch batch = FirebaseFirestore.instance.batch();
    if (previousCount < newCount) {
      for (int i = previousCount + 1; i <= newCount; i++) {
        DocumentReference tableDoc = tableCollection.doc(i.toString());
        batch.set(
            tableDoc,
            TableModel(
              number: i,
              status: TableStatusEnum.deactive.value,
            ).toMap());
      }
    } else if (newCount < previousCount) {
      for (int i = newCount + 1; i <= previousCount; i++) {
        DocumentReference tableDoc = tableCollection.doc(i.toString());
        batch.delete(tableDoc);
      }
    }

    await batch.commit();
  }

  Future<void> updateTable(TableModel table) async {
    final tableCollection = await _tableCollection;

    await tableCollection.doc(table.id).update(table.toMap());
  }

  Future<void> updateTableStatusByTableNumber(
    int tableNumber,
    int newStatus,
  ) async {
    final tableCollection = await _tableCollection;

    try {
      QuerySnapshot querySnapshot = await tableCollection
          .where('number', isEqualTo: tableNumber)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot tableDoc = querySnapshot.docs.first;
        await tableCollection.doc(tableDoc.id).update({'status': newStatus});
      } else {
        throw Exception('Table with number $tableNumber not found.');
      }
    } catch (e) {
      throw Exception('Failed to update table status: $e');
    }
  }

  Future<void> updateTables(int count) async {
    final tableCollection = await _tableCollection;

    WriteBatch batch = FirebaseFirestore.instance.batch();

    QuerySnapshot querySnapshot = await tableCollection.get();
    for (var doc in querySnapshot.docs) {
      batch.delete(doc.reference);
    }

    for (int i = 1; i <= count; i++) {
      DocumentReference tableDoc = tableCollection.doc();
      batch.set(tableDoc, {'number': i});
    }

    await batch.commit();
  }

  Future<void> deleteTable(String id) async {
    final tableCollection = await _tableCollection;

    await tableCollection.doc(id).delete();
  }

  Stream<List<TableModel>> getTables() async* {
    final tableCollection = await _tableCollection;

    yield* tableCollection.orderBy('number').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return TableModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Stream<TableModel?> getTableByNumber(int number) async* {
    final tableCollection = await _tableCollection;

    yield* tableCollection
        .where('number', isEqualTo: number)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        var doc = snapshot.docs.first;
        return TableModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }
      return null;
    });
  }
}
