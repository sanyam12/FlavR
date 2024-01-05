import 'dart:collection';
import 'package:flavr/pages/cart/CartVariantData.dart';


class Cart{
  String outletId="null";
  HashMap<String, HashMap<String, CartVariantData>> items = HashMap<String, HashMap<String, CartVariantData>>();
  int amount = 0;
  Cart();
}