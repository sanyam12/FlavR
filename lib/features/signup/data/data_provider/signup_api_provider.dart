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
      Uri.https(
        "flavr.tech",
        "/user/signup",
      ),
      body: body,
    );
  }
}
