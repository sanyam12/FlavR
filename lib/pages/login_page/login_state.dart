part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccessful extends LoginState{
  final bool isSuccessful;
  const LoginSuccessful(this.isSuccessful);

  @override
  List<Object?> get props => [isSuccessful];
}

class LoginFailed extends LoginState{
  final String message;
  final int seed;
  const LoginFailed(this.message, this.seed);

  @override
  List<Object?> get props => [message, seed];
}

class VerificationPending extends LoginState {
  final int seed;
  const VerificationPending(this.seed);

  @override
  List<Object?> get props => [seed];

}