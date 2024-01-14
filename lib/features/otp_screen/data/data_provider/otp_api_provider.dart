import 'dart:convert';
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
        {"key": email, "role": 0,},
      );
      var response = await client.post(
        Uri.parse("https://flavr.tech/mail/resendotp"),
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
}