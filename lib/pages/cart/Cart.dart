import 'dart:collection';
import '../outlet_menu/Product.dart';
import 'CartItems.dart';

class Cart{
  String outletId="null";
  HashMap<String, int> items = HashMap<String, int>();
  Cart();
}