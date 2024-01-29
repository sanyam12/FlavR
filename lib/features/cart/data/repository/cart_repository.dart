import 'dart:convert';

import 'package:flavr/core/repository/core_cart_repository.dart';
import 'package:flavr/features/cart/data/data_providers/cart_api_provider.dart';

class CartRepository {
  final CoreCartRepository _coreCartRepository;
  final CartApiProvider _cartApiProvider;

  CartRepository(this._coreCartRepository, this._cartApiProvider);

  Future<String> placeOrder(String outletID) async {
    final token = await _coreCartRepository.getToken();
    return await _cartApiProvider.placeOrder(
      token: token,
      outletID: outletID,
    );
  }

  Future<bool> verifyPayment(String orderId)async{
    final response = await _cartApiProvider.verifyPayment(orderId);
    return jsonDecode(response)["order"][0]["payment"]==true;
  }
}
