import 'package:flavr/core/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OutletListStorageProvider{
  Future<String> getToken()async{
    const secure = FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true));
    final token = await secure.read(key: "token");
    if(token!=null){
      return token;
    }
    throw Exception("Auth Token Not Found");
  }

  Future<Response> getUsername()async{
    final token = await getToken();
    Response response = await get(
        Uri.parse("${API_DOMAIN}user/userprofile"),
        headers: {"Authorization": "Bearer $token"});
    return response;
  }

  Future<void> setSelectedOutlet(String id) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString("selectedOutlet", id);
  }

  Future<List<String>> getSavedOutletsList()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList("savedOutlets");
    if(list!=null){
      return list;
    }
    return [];
  }

}