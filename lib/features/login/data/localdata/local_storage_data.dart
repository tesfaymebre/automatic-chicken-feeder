import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  final FlutterSecureStorage storage;
  LocalStorage({required this.storage});
  Future<String> readFromStorage(String key) async {
    final readData = await storage.read(key: key) ?? '';
    return readData;
  }

  Future<String> readUserData() async {
    final readData = await storage.read(key: "User") ?? '';
    return readData;
  }

  Future<void> writeUserData(String userData) async {
    await storage.write(key: "User", value: userData);
  }

  Future<void> writeToStorage(String key, String token) async {
    await storage.write(key: key, value: token);
  }

  Future<void> deleteToken(String key) async {
    await storage.delete(key: key);
  }
}
