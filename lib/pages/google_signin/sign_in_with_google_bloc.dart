import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'sign_in_with_google_event.dart';
part 'sign_in_with_google_state.dart';

class SignInWithGoogleBloc extends Bloc<SignInWithGoogleEvent, SignInWithGoogleState> {
  SignInWithGoogleBloc() : super(SignInWithGoogleInitial()) {
    on<SignInWithGoogleEvent>((event, emit) {
      if(event is OnGoogleButtonClick){
        emit(GoogleButtonClicked());
        emit(SignInWithGoogleInitial());
      }
      else if (event is OnSignUpClick){
        emit(SignUpClicked());
        emit(SignInWithGoogleInitial());
      }
      else if(event is OnLoginClick){
        emit(LoginClicked());
        emit(SignInWithGoogleInitial());
      }
    });
  }
}
