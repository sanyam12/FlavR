part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  const SignupState();
}

class SignupInitial extends SignupState {
  @override
  List<Object> get props => [];
}

class SignupSuccessful extends SignupState{
  final bool isSuccessful;
  const SignupSuccessful(this.isSuccessful);

  @override
  List<Object?> get props => [isSuccessful];
}

class SignupFailed extends SignupState{
  final String message;
  const SignupFailed(this.message);

  @override
  List<Object?> get props => [message];


}