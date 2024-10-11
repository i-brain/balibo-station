import 'dart:async';

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

  AdminSettingsModel _adminSettings = AdminSettingsModel.initial();

  final StreamController<AdminSettingsModel> _settingsStreamController =
      StreamController<AdminSettingsModel>.broadcast();

  AdminSettingsModel get adminSettings => _adminSettings;

  Stream<AdminSettingsModel> get settingsStream =>
      _settingsStreamController.stream;

  Future<void> startListeningToAdminSettings() async {
    final adminSettingsDoc = await _adminSettingsDoc;
    adminSettingsDoc.snapshots().listen((snapshot) {
      if (snapshot.exists) {
        _adminSettings = AdminSettingsModel.fromMap(
          snapshot.data() as Map<String, dynamic>,
        );
        _settingsStreamController.add(_adminSettings);
      } else {
        _adminSettings = AdminSettingsModel.initial();
        _settingsStreamController.add(_adminSettings);
      }
    }, onError: (error) {
      _settingsStreamController
          .addError('Error loading admin settings: $error');
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

  void dispose() {
    _settingsStreamController.close();
  }
}
