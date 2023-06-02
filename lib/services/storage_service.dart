import 'package:flavr/models/StorageItem.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class StorageService{
  final _secureStorage = const FlutterSecureStorage();

  Future<void> writeSecureData(StorageItem newItem) async{
    await _secureStorage.write(
        key: newItem.key,
        value: newItem.value,
        aOptions: _getAndroidOptions(),
      iOptions: _getIosOptions()
    );
  }

  Future<String?> readSecureData(String key) async {
    var readData =
    await _secureStorage.read(key: key, aOptions: _getAndroidOptions());
    return readData;
  }

  Future<void> deleteSecureData(StorageItem item) async {
    await _secureStorage.delete(key: item.key, aOptions: _getAndroidOptions());
  }

  Future<bool> containsKeyInSecureData(String key) async {
    var containsKey = await _secureStorage.containsKey(key: key, aOptions: _getAndroidOptions());
    return containsKey;
  }

  Future<List<StorageItem>> readAllSecureData() async {
    var allData = await _secureStorage.readAll(aOptions: _getAndroidOptions());
    List<StorageItem> list =
    allData.entries.map((e) => StorageItem(e.key, e.value)).toList();
    return list;
  }

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );

  IOSOptions _getIosOptions() => const IOSOptions(
    accessibility: KeychainAccessibility.first_unlock_this_device
  );
}