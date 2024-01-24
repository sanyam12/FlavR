import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OutletMenuStorageProvider{
  Future<String?> getOutletName()async{
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString("selectedOutlet");
    return data;
  }
}