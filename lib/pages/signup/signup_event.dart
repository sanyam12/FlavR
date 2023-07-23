part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();
}

class SignupButtonPressed extends SignupEvent {
  final String name;
  final String email;
  final String password;

  const SignupButtonPressed(
      {required this.name, required this.email, required this.password});

  @override
  List<Object?> get props => [name, email, password];
}


