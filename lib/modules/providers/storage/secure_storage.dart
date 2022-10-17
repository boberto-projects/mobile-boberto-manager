import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  late FlutterSecureStorage storage;

  SecureStorage() {
    storage = const FlutterSecureStorage();
  }

  String? obterValor(String chave) {
    storage.read(key: chave).then((value) {
      return value;
    });
    return null;
  }

  bool chaveExiste(String chave) {
    storage.containsKey(key: chave).then((data) {
      return data;
    });
    return false;
  }

  bool deletarValor(String chave) {
    storage.delete(key: chave);
    return true;
  }

  bool deletarTudo() {
    storage.deleteAll();
    return true;
  }

  bool escreverValor(String chave, String valor) {
    storage.write(key: chave, value: valor);
    return true;
  }
}
