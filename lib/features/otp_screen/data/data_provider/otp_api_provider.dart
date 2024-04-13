import 'dart:convert';
import 'package:flavr/core/constants.dart';
import 'package:http/http.dart';

class OtpApiProvider {
  final Client client;

  OtpApiProvider(this.client);

  Future<String> sendOTP(String email) async {
    try {
      final headers = {
        "Content-Type": "application/json",
      };
      final body = jsonEncode(
        {
          "key": email,
          "role": 0,
        },
      );
      var response = await client.post(
        Uri.parse("${API_DOMAIN}mail/resendotp"),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 201) {
        var json = jsonDecode(response.body);
        return json["message"];
      }
      throw response.body;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> verifyOTP(String email, String code) async {
    int check = int.parse(code);
    String body = jsonEncode({
      "key": email,
      "otp": check,
      "role": 0,
    });

    final headers = {"Content-Type": "application/json"};

    final response = await post(
      Uri.parse("${API_DOMAIN}mail/verifyotp"),
      body: body,
      headers: headers,
    );
    return response.body;
  }
}
