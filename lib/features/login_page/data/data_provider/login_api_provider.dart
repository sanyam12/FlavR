import 'package:flavr/core/constants.dart';
import 'package:http/http.dart' as http;

class LoginApiProvider{
  final http.Client client;

  LoginApiProvider(this.client);
  Future<http.Response> attemptLogin(String email, String password)async{
    var body = {
      "email": email,
      "password": password
    };
    var response = await client.post(
        Uri.parse("${API_DOMAIN}user/login"),
        body: body
    );
    return response;
  }
}