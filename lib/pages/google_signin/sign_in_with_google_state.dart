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