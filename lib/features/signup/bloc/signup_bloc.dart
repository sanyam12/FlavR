import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/data_provider/signup_api_provider.dart';

part 'signup_event.dart';

part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupApiProvider _signupApiProvider;

  SignupBloc(this._signupApiProvider) : super(SignupInitial()) {
    on<SignupButtonPressed>(
      (event, emit) async {
        emit(SignupLoading());
        try {
          final response = await _signupApiProvider.attemptSignup(
            event.name,
            event.email,
            event.password,
          );
          var json = jsonDecode(response.body);
          if (response.statusCode == 201) {
            emit(const SignupSuccessful());
            emit(SignupInitial());
          } else if (response.statusCode == 409) {
            if (json["message"] == "User already exits, try logging in.") {
              emit(UserAlreadyExists(json["message"]));
              emit(SignupInitial());
            } else {
              emit(VerificationPending(json["message"]));
              emit(SignupInitial());
            }
          } else {
            emit(SignupFailed(json["message"].toString()));
            emit(SignupInitial());
          }
        } catch (e) {
          emit(SignupFailed(e.toString()));
          emit(SignupInitial());
        }
      },
    );
  }
}
