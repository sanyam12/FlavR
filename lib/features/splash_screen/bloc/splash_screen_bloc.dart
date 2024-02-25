import 'package:equatable/equatable.dart';
import 'package:flavr/core/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/repository/splash_screen_repository.dart';

part 'splash_screen_event.dart';

part 'splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  final SplashScreenRepository _splashScreenRepository;
  final Client client;
  SplashScreenBloc(this._splashScreenRepository, this.client) : super(SplashScreenInitial()) {
    on<TimerTriggered>((event, emit) async {
      try {
        await Future.delayed(
          const Duration(seconds: 2),
          ()async {
            // final SharedPreferences prefs = await SharedPreferences.getInstance();
            // await prefs.remove("savedOutlets");
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
