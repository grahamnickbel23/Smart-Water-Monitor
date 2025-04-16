import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MyDatabase {
  // creating storage instance
  final FlutterSecureStorage storage = FlutterSecureStorage();

  // write data
  Future<void> writeData(String key, String val) async {
    await storage.write(key: key, value: val);
  }

  // read data
  Future<String?> readData(String key) async {
    return await storage.read(key: key);
  }
}
