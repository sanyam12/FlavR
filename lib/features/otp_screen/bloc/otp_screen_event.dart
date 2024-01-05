part of 'otp_screen_bloc.dart';

@immutable
abstract class OtpScreenEvent {}

class ResetTimer extends OtpScreenEvent{}

class OtpRequested extends OtpScreenEvent{
  final String mail;
  OtpRequested(this.mail);
}

class OtpSubmitted extends OtpScreenEvent{
  final String email;
  final String verificationCode;

  OtpSubmitted(this.email, this.verificationCode);

}