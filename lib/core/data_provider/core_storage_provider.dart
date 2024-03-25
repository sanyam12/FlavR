import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CoreStorageProvider {
  var service = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  Future<String> getToken() async {
    final token = await service.read(key: "token");
    if (token != null) {
      return token;
    }
    throw Exception("token not found on device");
  }

  updateToken(token )async{
    try{
      await service.write(key: "token", value: token);
    } catch(e){
      rethrow;
    }
  }

  removeToken() async {
    try{
      await service.delete(key: "token");
    } catch(e){
      rethrow;
    }
  }
}
