import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'signup_event.dart';

part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupEvent>(
          (event, emit) async {
        if (event is SignupButtonPressed) {
          var body = {
            "userName": event.name,
            "email": event.email,
            "password": event.password
          };
          var response = await http.post(
              Uri.https("flavrapi.onrender.com", "/user/signup"),
              body: body);
          var json = jsonDecode(response.body);
          if (response.statusCode == 201) {
            _login(event.email, event.password);
            emit(const SignupSuccessful(true));
          } else {
            emit(SignupFailed(json["message"].toString()));
          }
        }
      },
    );
  }

  _login(String email, String password)async{
    var body = {
      "email": email,
      "password": password
    };

    final loginResponse = await http.post(
        Uri.https("flavrapi.onrender.com", "/user/login"),
        body: body
    );

    var json = jsonDecode(loginResponse.body);
    if(loginResponse.statusCode==200){
      const service =FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));
      service.write(key: "token", value: json["token"]);
    }
  }
}
