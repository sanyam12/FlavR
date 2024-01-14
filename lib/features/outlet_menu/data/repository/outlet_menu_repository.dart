import 'dart:convert';
import 'package:flavr/features/outlet_menu/data/data_provider/outlet_menu_storage_provider.dart';
import 'package:flavr/features/outlet_menu/data/models/Categories.dart';
import 'package:flavr/features/outlet_menu/data/models/Outlet.dart';
import '../../../../features/cart/Cart.dart';
import '../data_provider/outlet_menu_api_provider.dart';

class OutletMenuRepository{
  final OutletMenuStorageProvider _storageProvider;
  final OutletMenuApiProvider _apiProvider;

  OutletMenuRepository(this._apiProvider, this._storageProvider);

  Future<String> getToken()async{
    return await _storageProvider.getToken();
  }

  Future<String?> getOutletId()async{
      final name = await _storageProvider.getOutletName();
      return name;
  }
  
  Future<Outlet> getOutlet(String token)async{
    final id = await getOutletId();
    if(id==null){
      throw Exception("No Saved Outlet Found");
    }
    final outletData = await _apiProvider.getOutlet(id, token);
    return Outlet.fromJson(jsonDecode(outletData)["result"][0]);
  }

  Future<List<Categories>> getOutletMenu(String id) async{
    final data = await _apiProvider.getOutletMenu(id);
    final json = jsonDecode(data);
    final list =  (json["categoryArray"] as List).map((e) => Categories.fromJson(e)).toList();
    list.insert(0, Categories("All", [], ""));
    return list;
  }

  Future<Cart> getCart(String token)async{
    final data =  await _apiProvider.getCart(token);
    //TODO: Pending decode data to get saved cart data
    return Cart();
  }
  
}