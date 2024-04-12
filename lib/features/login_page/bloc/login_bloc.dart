import 'dart:convert';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/repository/login_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository;

  LoginBloc(this._loginRepository) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        final response = await _loginRepository.attemptLogin(
          event.email,
          event.password,
        );
        var json = jsonDecode(response.body);

        if (response.statusCode == 200) {
          log("bloc save token called");
          _loginRepository.saveToken(json["token"]);
          emit(LoginSuccessful());
        } else if (json["message"] ==
            "Email is not verified, please complete verification") {
          emit(VerificationPending());
        } else {
          emit(LoginFailed(json["message"].toString()));
        }
      } catch (e) {
        emit(LoginFailed(e.toString()));
      }
    });
  }
}
