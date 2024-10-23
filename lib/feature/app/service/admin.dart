import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AdminService {
  final FlutterSecureStorage _storage;
  String? _adminId;

  final _adminIdField = 'adminId';

  AdminService({required FlutterSecureStorage storage}) : _storage = storage;

  Future<DocumentReference<Map<String, dynamic>>> get adminDoc async {
    _adminId ??= await _storage.read(key: _adminIdField);
    return FirebaseFirestore.instance.collection('admins').doc(_adminId);
  }

  Future<String?> get admin async => _storage.read(key: _adminIdField);

  Future<void> saveAdminId(String adminId) async {
    _adminId = adminId;
    await _storage.write(key: _adminIdField, value: adminId);
  }
}
