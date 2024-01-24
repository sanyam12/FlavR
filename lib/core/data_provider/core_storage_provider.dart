import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CoreStorageProvider{

  Future<String> getToken()async{
    var service = const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));
    final token =  await service.read(key: "token");
    if(token!=null){
      return token;
    }
    throw Exception("token not found on device");
  }



}