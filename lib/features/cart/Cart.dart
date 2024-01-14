import 'dart:collection';
import 'package:flavr/features/outlet_menu/data/models/Product.dart';
import 'package:flavr/features/cart/CartVariantData.dart';


class Cart{
  String outletId="null";

  //product id -> list of variants
  HashMap<Product, List<CartVariantData>> items = HashMap<Product, List<CartVariantData>>();
  // int amount = 0;
  // int cartTotalItems = 0;

  Cart();
  Cart.fromParams(String id, HashMap<Product, List<CartVariantData>> list){
    outletId = id;
    items = list;
    // amount = amt;
    // cartTotalItems = totalItems;
  }

}