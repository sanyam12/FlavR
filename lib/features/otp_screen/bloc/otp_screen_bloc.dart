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
    on<OtpRequested>((event, emit) async {
      emit(OtpLoading());
      try {
        final message = await _otpRepository.sendOTP(event.mail);
        emit(OtpShowSnackBar(message));
      } catch (e) {
        emit(OtpShowSnackBar(e.toString()));
      }
    });
    on<OtpSubmitted>((event, emit) async {
      final json = jsonDecode(
        await _otpRepository.verifyOtp(event.email, event.verificationCode),
      );
      emit(OtpShowSnackBar(json["message"].toString()));
      if (json["message"] == "OTP Verified, you can log in now.") {
        emit(OTPSuccess());
      }
      emit(OtpScreenInitial());
    });
  }
}
