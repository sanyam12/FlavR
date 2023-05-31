import 'dart:async';
import 'dart:convert';
import 'dart:developer';
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
            emit(const SignupSuccessful(true));
          } else {
            emit(SignupFailed(json["message"].toString()));
          }
        }
      },
    );
  }
}
