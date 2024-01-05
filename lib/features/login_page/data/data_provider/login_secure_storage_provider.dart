import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginSecureStorageProvider {
  Future<void> storeToken(String token)async{
    const service = FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));
    await service.write(key: "token", value:token);
  }
}