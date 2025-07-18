import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  SecureStorage(this.storage);
  FlutterSecureStorage storage;

  void initStorage() {
    storage = FlutterSecureStorage();
  }

  void writeCode(String value) async {
    await storage.write(key: 'code', value: value);
  }

  Future<String?> readCode() async {
    return storage.read(key: 'code');
  }

  void deleteCode() async {
    await storage.delete(key: 'code');
  }
}
