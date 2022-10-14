import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  late FlutterSecureStorage storage;

  SecureStorage() {
    storage = const FlutterSecureStorage();
  }

  Future<String?> obterValor(String chave) {
    return storage.read(key: chave).then((value) => value);
  }

  Future<bool> chaveExiste(String chave) {
    return storage.containsKey(key: chave);
  }

  Future<bool> deletarValor(String chave) {
    storage.delete(key: chave);
    return Future.value(true);
  }

  Future<bool> deletarTudo(String chave) {
    storage.deleteAll();
    return Future.value(true);
  }

  Future<bool> escreverValor(String chave, String valor) {
    storage.write(key: chave, value: valor);
    return Future.value(true);
  }
}
