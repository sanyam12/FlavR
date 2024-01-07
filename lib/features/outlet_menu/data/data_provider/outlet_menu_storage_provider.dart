import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OutletMenuStorageProvider{
  Future<String?> getOutletName()async{
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString("selectedOutlet");
    return data;
  }

  Future<String> getToken()async{
    var service = const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));
    final token =  await service.read(key: "token");
    if(token!=null){
      return token;
    }
    throw Exception("token not found on device");
  }
}