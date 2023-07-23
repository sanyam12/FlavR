import 'dart:collection';
import 'package:flavr/pages/cart/CartVariantData.dart';

import '../outlet_menu/Product.dart';
import 'CartItems.dart';

class Cart{
  String outletId="null";
  HashMap<String, HashMap<String, CartVariantData>> items = HashMap<String, HashMap<String, CartVariantData>>();
  int amount = 0;
  Cart();
}