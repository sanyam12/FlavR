import 'dart:developer';

import 'package:flavr/core/constants.dart';
import 'package:http/http.dart';

import '../../../../features/cart/Cart.dart';

class OutletMenuApiProvider{
  Future<String> getOutlet(String id, String token,)async{
    try{
      final response = await get(Uri.parse("${API_DOMAIN}outlet/getOutlet?outletid=$id"),
      headers: {
        "Authorization":"Bearer $token"
      });
      return response.body;
    } catch (e){
      throw Exception(e.toString());
    }
  }

  Future<String> getOutletMenu(String id)async{
    final response = await get(
        Uri.parse("${API_DOMAIN}products/getProductsByCategory?categoryName=All&outletid=$id"),
    );
    if(response.statusCode==200){
      return response.body;
    }
    throw Exception("Something Went Wrong While Fetching Outlet Menu");
  }

  Future<Cart> getCart(String token)async{
    return Cart();

    //TODO: Implement this properly
    final response = await get(Uri.parse("${API_DOMAIN}user/getCartItems"), headers: {
      "Authorization": "Bearer $token"
    });
    if(response.statusCode==200){
      // return
    }
    throw Exception("Something went wrong while fetching cart");
  }

}