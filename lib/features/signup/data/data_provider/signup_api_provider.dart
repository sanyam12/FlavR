import 'package:flavr/core/constants.dart';
import 'package:http/http.dart';

class SignupApiProvider {
  final Client client;

  SignupApiProvider(this.client);

  Future<Response> attemptSignup(
    String name,
    String email,
    String password,
  ) async {
    var body = {
      "userName": name,
      "email": email,
      "password": password,
    };
    return await client.post(
      Uri.parse(
        "${API_DOMAIN}user/signup",
      ),
      body: body,
    );
  }
}
