import 'dart:convert';

import 'package:http/http.dart';

import '../constants.dart';

class CoreApiProvider {
  final Client client;

  const CoreApiProvider(this.client);

  Future<void> updateQuantity(
    String productId,
    String variant,
    int quantity,
    String token,
  ) async {
    final body = jsonEncode({
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
  }
}
