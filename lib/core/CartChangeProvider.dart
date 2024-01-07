import 'package:flutter/cupertino.dart';

import '../features/cart/Cart.dart';

class CartChangeProvider extends ChangeNotifier{
  Cart _cart = Cart();
  Cart get cart => _cart;
  void updateCart(Cart newCart){
    _cart = newCart;
    notifyListeners();
  }
}