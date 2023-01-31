import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();

  static Future<String?> get(String chave) async {
    return await _storage.read(key: chave);
  }

  static Future<bool> exists(String chave) async {
    return await _storage.containsKey(key: chave);
  }

  static Future<bool> delete(String chave) async {
    await _storage.delete(key: chave);
    return true;
  }

  static Future<bool> deleteAll() async {
    await _storage.deleteAll();
    return true;
  }

  static Future<bool> write(String chave, String valor) async {
    await _storage.write(key: chave, value: valor);
    return true;
  }
}
