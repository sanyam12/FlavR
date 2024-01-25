import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flavr/core/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import '../data/repository/otp_repository.dart';

part 'otp_screen_event.dart';
part 'otp_screen_state.dart';

class OtpScreenBloc extends Bloc<OtpScreenEvent, OtpScreenState> {
  final OtpRepository _otpRepository;

  OtpScreenBloc(this._otpRepository) : super(OtpScreenInitial()) {
    on<OtpRequested>((event, emit) async{
      emit(OtpLoading());
      try {
        final message = await _otpRepository.sendOTP(event.mail);
        emit(OtpShowSnackBar(message));
      } catch (e) {
        emit(OtpShowSnackBar(e.toString()));
      }
    });
    on<OtpSubmitted>((event, emit)async{
      int check = int.parse(event.verificationCode);
      String body = jsonEncode({
        "key": event.email,
        "otp": check,
        "role": 0
      });
      final headers = {
        "Content-Type": "application/json"
      };

      final response = await post(
          Uri.parse(
              "${API_DOMAIN}mail/verifyotp"),
          body: body,
          headers: headers);
      final json = jsonDecode(response.body);
      if (json["message"] ==
          "OTP Verified, you can log in now.") {
        // if (context.mounted) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //       SnackBar(
        //           content: Text(
        //               json["message"].toString())));
        //   Navigator.popAndPushNamed(context, "/login");
        // }
      } else {
        // if (context.mounted) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //       content: Text(json["message"].toString()),
        //     ),
        //   );
        // }
      }
    });
  }
}
