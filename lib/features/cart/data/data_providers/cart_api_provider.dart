import 'dart:convert';
import 'package:flavr/core/constants.dart';
import 'package:http/http.dart';

class CartApiProvider {
  final Client client;

  CartApiProvider(this.client);

  Future<String> placeOrder({
    required String token,
    required String outletID,
    required String instruction,
  }) async {
    final response = await client.post(
        Uri.parse("${API_DOMAIN}orders/placeOrder"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: json.encode({
          "outletid": outletID,
          "instructions":{
            "message": instruction
          }
        }));
    return response.body;
  }

  Future<String> verifyPayment(String orderId)async{
    final response = await client.get(
        Uri.parse("${API_DOMAIN}orders/payments/verify/$orderId"),
    );
    return response.body;
  }
}
