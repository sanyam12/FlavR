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
  final int seed;
  const SignupFailed(this.message, this.seed);

  @override
  List<Object?> get props => [message, seed];


}

class VerificationPending extends SignupState{
  final String message;
  final int seed;
  const VerificationPending(this.message, this.seed);

  @override
  List<Object?> get props => [message, seed];

}

class UserAlreadyExists extends SignupState{
  final String message;
  final int seed;
  const UserAlreadyExists(this.message, this.seed);

  @override
  List<Object?> get props => [message, seed];
}

class ShowSnackbar extends SignupState{
  final String message;
  final int seed;
  const ShowSnackbar(this.message, this.seed);

  @override
  List<Object?> get props => [message, seed];
}