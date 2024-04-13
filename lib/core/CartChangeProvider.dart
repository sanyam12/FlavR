import 'package:flutter/material.dart';
import '../features/cart/data/models/Cart.dart';

class CartChangeProvider extends ChangeNotifier{
  Cart _cart = Cart();
  Cart get cart => _cart;
  void updateCart(Cart newCart){
    _cart = newCart;
    notifyListeners();
  }
}