import 'package:flavr/core/constants.dart';
import 'package:flavr/core/data_provider/core_storage_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OutletListStorageProvider{
  final CoreStorageProvider _coreStorageProvider;

  OutletListStorageProvider(this._coreStorageProvider);

  Future<String> getToken()async{
    try{
      final token = await _coreStorageProvider.getToken();
      return token;
    }catch (e){
      rethrow;
    }

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