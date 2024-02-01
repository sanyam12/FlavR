import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashScreenRepository{
  Future<String?> getToken()async{
    var service = const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));
    return await service.read(key: "token");
  }
}