import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../data/repository/splash_screen_repository.dart';

part 'splash_screen_event.dart';

part 'splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  final SplashScreenRepository _splashScreenRepository;
  SplashScreenBloc(this._splashScreenRepository) : super(SplashScreenInitial()) {
    on<TimerTriggered>((event, emit) async {
      try {
        await Future.delayed(
          const Duration(seconds: 2),
          ()async {
            final token = await _splashScreenRepository.getToken();
            if(token==null || JwtDecoder.isExpired(token)){
              return emit(SplashScreenNotSignedIn());
            }
            return emit(SplashScreenSignedIn());
          },
        );
      } catch (e) {
        emit(SplashScreenErrorOccurred(e.toString()));
      }
    });
  }
}
