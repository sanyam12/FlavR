part of 'otp_screen_bloc.dart';

abstract class OtpScreenEvent extends Equatable {}

class ResetTimer extends OtpScreenEvent{
  @override
  List<Object?> get props => [];
}

class OtpRequested extends OtpScreenEvent{
  final String mail;
  OtpRequested(this.mail);

  @override
  List<Object?> get props => [mail];
}

class OtpSubmitted extends OtpScreenEvent{
  final String email;
  final String verificationCode;

  OtpSubmitted(this.email, this.verificationCode);

  @override
  List<Object?> get props => [email, verificationCode];

}