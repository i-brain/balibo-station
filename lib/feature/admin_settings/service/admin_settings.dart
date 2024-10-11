import 'package:balibo_station/feature/admin_settings/model/admin_settings.dart';
import 'package:balibo_station/feature/app/service/admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminSettingsService {
  final AdminService _adminService;

  AdminSettingsService({required AdminService adminService})
      : _adminService = adminService;

  Future<DocumentReference> get _adminSettingsDoc async =>
      (await _adminService.adminDoc)
          .collection('admin_settings')
          .doc('settings');

  Stream<AdminSettingsModel?> getAdminSettings() async* {
    final adminSettingsDoc = await _adminSettingsDoc;

    yield* adminSettingsDoc.snapshots().map((snapshot) {
      if (snapshot.exists) {
        return AdminSettingsModel.fromMap(
          snapshot.data() as Map<String, dynamic>,
        );
      }
      return null;
    });
  }

  Future<void> setAdminSettings(AdminSettingsModel settings) async {
    try {
      final adminSettingsDoc = await _adminSettingsDoc;

      await adminSettingsDoc.set(settings.toMap());
    } catch (e) {
      throw Exception('Error setting admin settings: $e');
    }
  }

  Future<void> updateAdminSettings(AdminSettingsModel settings) async {
    try {
      final adminSettingsDoc = await _adminSettingsDoc;

      await adminSettingsDoc.update(settings.toMap());
    } catch (e) {
      throw Exception('Error updating admin settings: $e');
    }
  }

  Future<void> deleteAdminSettings() async {
    try {
      final adminSettingsDoc = await _adminSettingsDoc;

      await adminSettingsDoc.delete();
    } catch (e) {
      throw Exception('Error deleting admin settings: $e');
    }
  }
}
