import 'package:http/http.dart' as http;

class LoginApiProvider{
  Future<http.Response> attemptLogin(String email, String password)async{
    var body = {
      "email": email,
      "password": password
    };
    var response = await http.post(
        Uri.https("flavr.tech", "/user/login"),
        body: body
    );
    return response;
  }
}