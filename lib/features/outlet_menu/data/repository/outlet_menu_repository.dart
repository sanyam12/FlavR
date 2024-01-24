import 'dart:convert';
import 'dart:developer';
import 'package:flavr/features/outlet_menu/data/data_provider/outlet_menu_storage_provider.dart';
import 'package:flavr/features/outlet_menu/data/models/Categories.dart';
import 'package:flavr/features/outlet_menu/data/models/Outlet.dart';
import 'package:flavr/features/outlet_menu/data/models/Product.dart';
import '../../../cart/data/models/Cart.dart';
import '../data_provider/outlet_menu_api_provider.dart';

class OutletMenuRepository{
  final OutletMenuStorageProvider _storageProvider;
  final OutletMenuApiProvider _apiProvider;

  OutletMenuRepository(this._apiProvider, this._storageProvider);

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

  Future<Cart> getCart(String token, List<Categories> list)async{
    final data =  await _apiProvider.getCart(token);
    final json = jsonDecode(data);
    // log(data);

    //TODO: Pending decode data to get saved cart data
    return Cart.fromJson(json["cart"], list);
  }
  
}