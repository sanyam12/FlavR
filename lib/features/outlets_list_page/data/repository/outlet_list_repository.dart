import 'dart:convert';

import 'package:http/http.dart';

import '../../../outlet_menu/Outlet.dart';
import '../data_provider/outlet_list_api_provider.dart';
import '../data_provider/outlet_list_storage_provider.dart';

class OutletListRepository{
  final OutletListStorageProvider _storageProvider;
  final OutletListApiProvider _apiProvider;

  OutletListRepository(this._storageProvider, this._apiProvider);

  Future<Response> getUsername()async{
    return await _storageProvider.getUsername();
  }

  Future<List<Outlet>> getAllOutlets()async{
    final List<Outlet> list = [];
    final json = await _apiProvider.getAllOutlets();

    for (var i in json["outlets"]) {
      list.add(Outlet.fromJson(i));
    }
    return list;
  }

  Future<void> setSelectedOutlet(String id)async{
    await _storageProvider.setSelectedOutlet(id);
  }

  Future<String> getToken()async{
    return await _storageProvider.getToken();
  }

  Future<List<String>> getSavedOutletsID()async{
    return await _storageProvider.getSavedOutletsList();
  }

  Future<List<String>> getSavedOutletList(String token, List<String>list)async{
    final data = await _apiProvider.getSavedOutletList(token, list);
    return data;
  }
}