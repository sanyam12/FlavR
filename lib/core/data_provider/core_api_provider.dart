import 'dart:convert';

import 'package:http/http.dart';

import '../constants.dart';

class CoreApiProvider {
  final Client client;

  const CoreApiProvider(this.client);

  Future<String> updateQuantity(
    String productId,
    String variant,
    int quantity,
    String token,
    String outletID,
  ) async {
    final body = jsonEncode({
      "outletid": outletID,
      "productid": productId,
      "variant": variant,
      "quantity": quantity,
    });
    final headers = {
      "Content-Type": 'application/json',
      "Authorization": "Bearer $token",
    };
    final data = await client.patch(
      Uri.parse("${API_DOMAIN}user/updateQuantity"),
      body: body,
      headers: headers,
    );
    return (data.body);
  }

  Future<String> clearCart(String token)async{
    final response = await client.patch(
        Uri.parse("${API_DOMAIN}user/clearCart"),
      headers: {
          "Authorization":"Bearer $token"
      }
    );
    return response.body;
  }
}
