import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserService {
  final FlutterSecureStorage _storage;

  final String _usernameField = 'username';
  final String _passwordField = 'password';
  final String _stationIdField = 'stationId';

  String? _stationId;

  UserService({required FlutterSecureStorage storage}) : _storage = storage;

  Future<void> save({
    required String? username,
    required String? password,
    required String? stationId,
  }) async {
    await _storage.write(key: _usernameField, value: username);
    await _storage.write(key: _passwordField, value: password);
    await _storage.write(key: _stationIdField, value: stationId);
    _stationId = stationId;
  }

  Future<String?> get username async =>
      await _storage.read(key: _usernameField);

  Future<String?> get password async =>
      await _storage.read(key: _passwordField);

  Future<String?> get stationId async {
    _stationId ??= await _storage.read(key: _stationIdField);
    return _stationId;
  }
}
