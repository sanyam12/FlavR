import 'package:http/http.dart';

class SignupApiProvider {

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
    return await post(
      Uri.https(
        "flavr.tech",
        "/user/signup",
      ),
      body: body,
    );
  }
}
