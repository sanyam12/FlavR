import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../services/auth_service.dart';

part 'sign_in_with_google_event.dart';

part 'sign_in_with_google_state.dart';

class SignInWithGoogleBloc
    extends Bloc<SignInWithGoogleEvent, SignInWithGoogleState> {
  SignInWithGoogleBloc() : super(SignInWithGoogleInitial()) {
    on<SignInWithGoogleEvent>((event, emit) async {
      if (event is OnGoogleButtonClick) {
        final temp = await AuthService().signInWithGoogle();
        if (temp != null) {
          log("clicked");
          if (temp.user?.uid != null) {

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
