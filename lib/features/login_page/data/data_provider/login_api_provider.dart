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
        Uri.https("flavr.tech", "/user/login"),
        body: body
    );
    return response;
  }
}