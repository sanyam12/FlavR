import 'package:shared_preferences/shared_preferences.dart';

class OutletMenuStorageProvider{
  Future<String?> getOutletName()async{
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString("selectedOutlet");
    return data;
  }
}