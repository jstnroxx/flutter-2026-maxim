import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStore {
  const SecureStore();

  static const String _key = 'authToken';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _storage.write(key: _key, value: token);
  }

  Future<String?> readToken() async {
    return _storage.read(key: _key);
  }

  Future<void> clear() async {
    await _storage.delete(key: _key);
  }
}