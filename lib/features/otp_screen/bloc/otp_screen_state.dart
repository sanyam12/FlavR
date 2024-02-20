part of 'otp_screen_bloc.dart';

@immutable
abstract class OtpScreenState extends Equatable{}

class OtpScreenInitial extends OtpScreenState {
  @override
  List<Object?> get props => [];
}

class OtpShowSnackBar extends OtpScreenState{
  final String message;

  OtpShowSnackBar(this.message);

  @override
  List<Object?> get props => [message];
}

class OtpLoading extends OtpScreenState{
  @override
  List<Object?> get props => [];

}

class OTPSuccess extends OtpScreenState{
  @override
  List<Object?> get props => [];
}