import 'dart:developer';
import 'package:http/http.dart' as http;

import '../data_provider/login_api_provider.dart';
import '../data_provider/login_secure_storage_provider.dart';

class LoginRepository{
  final LoginApiProvider _loginDataProvider;
  final LoginSecureStorageProvider _loginSecureStorageProvider;

  LoginRepository(this._loginDataProvider, this._loginSecureStorageProvider);

  Future<http.Response> attemptLogin(String email, String password)async{
    final data = await _loginDataProvider.attemptLogin(email, password);
    return data;
  }
  Future<void> saveToken(String token)async{
    await _loginSecureStorageProvider.storeToken(token);
  }
}