import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flavr/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../services/auth_service.dart';


part 'sign_in_with_google_event.dart';

part 'sign_in_with_google_state.dart';

class SignInWithGoogleBloc
    extends Bloc<SignInWithGoogleEvent, SignInWithGoogleState> {
  SignInWithGoogleBloc() : super(SignInWithGoogleInitial()) {
    on<SignInWithGoogleEvent>((event, emit) async {
      if (event is OnGoogleButtonClick) {
        final temp = await AuthService().signInWithGoogle();
        if (temp != null) {
          if (temp.user?.email != null && temp.user?.displayName != null) {
            final body = jsonEncode(
              {
                "userName": temp.user?.displayName.toString(),
                "email": temp.user?.email.toString()
              },
            );
            final response = await http.post(
              Uri.parse("${API_DOMAIN}user/googleAuth"),
              body: body,
              headers: {"Content-Type": "application/json"},
            );
            final json = jsonDecode(response.body);
            if (response.statusCode.toString()=="200") {

              const secure = FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));
              await secure.write(key: "token", value: json["token"].toString());
              // emit(ShowSnackbar(json["message"]));
              emit(GoogleLoginSuccess());
              emit(SignInWithGoogleInitial());
            } else {
              emit(ShowSnackbar(json["message"]));
              emit(SignInWithGoogleInitial());
            }
          }
        }
        emit(SignInWithGoogleInitial());
      }
      else if (event is OnSignUpClick) {
        emit(SignUpClicked());
        emit(SignInWithGoogleInitial());
      }
      else if (event is OnLoginClick) {
        emit(LoginClicked());
        emit(SignInWithGoogleInitial());
      }
    });
  }
}
