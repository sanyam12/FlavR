part of 'splash_screen_bloc.dart';

abstract class SplashScreenState extends Equatable {
  const SplashScreenState();
}

class SplashScreenInitial extends SplashScreenState {
  @override
  List<Object> get props => [];
}

class SplashScreenNotSignedIn extends SplashScreenState {
  @override
  List<Object?> get props => [];
}

class SplashScreenSignedIn extends SplashScreenState {
  @override
  List<Object?> get props => [];
}

class SplashScreenErrorOccurred extends SplashScreenState {
  final String error;

  const SplashScreenErrorOccurred(this.error);

  @override
  List<Object?> get props => [error];

}
