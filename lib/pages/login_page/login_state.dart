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
  const LoginFailed(this.message);

  @override
  List<Object?> get props => [message];


}

class ShowSnackbar extends LoginState{
  final String message;
  const ShowSnackbar(this.message);

  @override
  List<Object?> get props => [message];


}