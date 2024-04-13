part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  const SignupState();
}

class SignupInitial extends SignupState {
  @override
  List<Object> get props => [];
}

class SignupSuccessful extends SignupState{
  const SignupSuccessful();

  @override
  List<Object?> get props => [];
}

class SignupFailed extends SignupState{
  final String message;
  const SignupFailed(this.message);

  @override
  List<Object?> get props => [message];


}

class VerificationPending extends SignupState{
  final String message;
  const VerificationPending(this.message);

  @override
  List<Object?> get props => [message];

}

class UserAlreadyExists extends SignupState{
  final String message;
  const UserAlreadyExists(this.message);

  @override
  List<Object?> get props => [message];
}

class ShowSnackBar extends SignupState{
  final String message;
  const ShowSnackBar(this.message);

  @override
  List<Object?> get props => [message];
}

class SignupLoading extends SignupState{
  @override
  List<Object?> get props => [];

}