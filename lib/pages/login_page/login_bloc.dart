import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flavr/models/StorageItem.dart';
import 'package:flavr/services/storage_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginButtonPressed) {
        var body = {
          "email": event.email,
          "password": event.password
        };
        var response = await http.post(
          Uri.https("flavrapi.onrender.com", "/user/login"),
            body: body
        );
        var json = jsonDecode(response.body);
        if(response.statusCode==200){
          StorageService service = StorageService();
          // log(json["token"]);
          service.writeSecureData(StorageItem("token", json["token"]));
          emit(const LoginSuccessful(true));
        }else{
          emit(LoginFailed(json["message"].toString()));
        }

      }
    });
  }
}
