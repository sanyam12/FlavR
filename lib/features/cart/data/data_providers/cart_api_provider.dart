import 'dart:convert';
import 'dart:developer';

import 'package:flavr/core/constants.dart';
import 'package:http/http.dart';

class CartApiProvider {
  final Client client;

  CartApiProvider(this.client);

  Future<String> placeOrder({
    required String token,
    required String outletID,
  }) async {
    final response = await client.post(
        Uri.parse("${API_DOMAIN}orders/placeOrder"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: json.encode({"outletid": outletID}));
    log(response.body.toString());
    return response.body;
  }
}
