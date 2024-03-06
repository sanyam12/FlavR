import 'package:flavr/core/data_provider/core_storage_provider.dart';
import 'package:http/http.dart' as http;

import '../data_provider/login_api_provider.dart';

class LoginRepository{
  final LoginApiProvider _loginApiProvider;
  final CoreStorageProvider coreStorageProvider;

  LoginRepository(this._loginApiProvider, this.coreStorageProvider);

  Future<http.Response> attemptLogin(String email, String password)async{
    final data = await _loginApiProvider.attemptLogin(email, password);
    return data;
  }
  Future<void> saveToken(String token)async{
    await coreStorageProvider.updateToken(token);
  }
}