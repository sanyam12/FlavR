import 'dart:collection';
import 'dart:developer';
import 'package:flavr/features/outlet_menu/data/models/Categories.dart';
import 'package:flavr/features/outlet_menu/data/models/Product.dart';
import 'CartVariantData.dart';


class Cart{
  String outletId="null";

  //product id -> list of variants
  Map<Product, List<CartVariantData>> items = <Product, List<CartVariantData>>{};
  // int amount = 0;
  // int cartTotalItems = 0;

  Cart();
  Cart.fromParams(String id, Map<Product, List<CartVariantData>> list){
    outletId = id;
    items = list;
    // amount = amt;
    // cartTotalItems = totalItems;
  }

  factory Cart.fromJson(Map<String, dynamic> json, List<Categories> list, String outletID){
    final String jsonOutletID = json["outlet"] ?? "" ;
    if(jsonOutletID.isEmpty || jsonOutletID!=outletID){
      return Cart.fromParams(outletID, {});
    }
    final tempList = <String, List<CartVariantData>>{};
    for(var i in (json["products"] as List)){
      // log(i["price"].toString());
      final item = CartVariantData(i["variant"], i["quantity"], i["product"]["price"]);
      if(tempList[i["product"]["_id"]]!=null){
        tempList[i["product"]["_id"]]!.add(item);
      }else{
        tempList[i["product"]["_id"]] = [item];
      }
    }

    final map = <Product, List<CartVariantData>>{};
    for(var i in list){
      for(var j in i.products){
        map[j] = tempList[j.id]??[];
      }
    }
    //TODO: Add outlet id
    return Cart.fromParams(json["outlet"].toString(), map);
  }

}