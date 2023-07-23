import 'dart:async';
import 'dart:convert';
import 'dart:developer' as logger;
import 'dart:math';
import 'package:flavr/pages/signup/SignUp.dart';
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
            Uri.https(
              "flavr.tech",
              "/user/signup",
            ),
            body: body,
          );
          var json = jsonDecode(response.body);
          logger.log(response.statusCode.toString());
          if (response.statusCode == 201) {
            _login(event.email, event.password);
            emit(const SignupSuccessful(true));
          }else if (response.statusCode == 409) {
            logger.log(json["message"]);
            if(json["message"]=="User already exits, try logging in.") {
                emit(UserAlreadyExists(json["message"], Random().nextInt(10000)));
            }else{
              emit(VerificationPending(json["message"], Random().nextInt(10000)));
            }
          } else {
            logger.log("this");
            emit(SignupFailed(
                json["message"].toString(), Random().nextInt(10000)));
          }
        }
      },
    );
  }

  _login(String email, String password) async {
    var body = {"email": email, "password": password};

    final loginResponse =
        await http.post(Uri.https("flavr.tech", "/user/login"), body: body);

    var json = jsonDecode(loginResponse.body);
    if (loginResponse.statusCode == 200) {
      const service = FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true));
      service.write(key: "token", value: json["token"]);
    }
  }
}
