part of 'splash_screen_bloc.dart';

abstract class SplashScreenEvent extends Equatable {
  const SplashScreenEvent();
}

class TimerTriggered extends SplashScreenEvent{
  @override
  List<Object?> get props => [];
}