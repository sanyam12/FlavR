part of 'sign_in_with_google_bloc.dart';

abstract class SignInWithGoogleState extends Equatable {
  const SignInWithGoogleState();
}

class SignInWithGoogleInitial extends SignInWithGoogleState {
  @override
  List<Object> get props => [];
}

class GoogleButtonClicked extends SignInWithGoogleState{
  @override
  List<Object?> get props => [];
}

class SignUpClicked extends SignInWithGoogleState{
  @override
  List<Object?> get props => [];
}

class LoginClicked extends SignInWithGoogleState{
  @override
  List<Object?> get props => [];
}

class ShowSnackbar extends SignInWithGoogleState{
  final String message;
  final int seed = Random().nextInt(10000);
  ShowSnackbar(this.message);

  @override
  List<Object?> get props => [message, seed];

}

class GoogleLoginSuccess extends SignInWithGoogleState{
  @override
  List<Object?> get props => [];

}