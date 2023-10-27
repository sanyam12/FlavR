import 'dart:async';
import 'dart:convert';
import 'dart:developer' as logger;
import 'dart:math';
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
          Uri.https("flavr.tech", "/user/login"),
            body: body
        );
        var json = jsonDecode(response.body);
        if(response.statusCode==200){
          const service = FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));
          await service.write(key: "token", value: json["token"]);
          logger.log("wtf");
          emit(const LoginSuccessful(true));
        }
        else if(json["message"]=="Email is not verified, please complete verification"){
          // logger.log("${json["message"]} hello");
          emit(VerificationPending(Random().nextInt(10000)));
        }
        else{
          logger.log(json["message"].toString());
          emit(LoginFailed(json["message"].toString(), Random().nextInt(10000)));
        }
      }
    });
  }
}
