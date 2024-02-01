part of 'sign_in_with_google_bloc.dart';

abstract class SignInWithGoogleEvent extends Equatable {
  const SignInWithGoogleEvent();
}

class OnGoogleButtonClick extends SignInWithGoogleEvent{
  @override
  List<Object?> get props => [];
}

class OnSignUpClick extends SignInWithGoogleEvent{
  @override
  List<Object?> get props => [];
}

class OnLoginClick extends SignInWithGoogleEvent{
  @override
  List<Object?> get props => [];
}