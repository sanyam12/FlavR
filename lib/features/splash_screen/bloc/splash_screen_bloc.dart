import 'package:equatable/equatable.dart';
import 'package:flavr/core/data_provider/core_storage_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

part 'splash_screen_event.dart';

part 'splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  final CoreStorageProvider _coreStorageProvider;
  final Client client;
  SplashScreenBloc(this._coreStorageProvider, this.client) : super(SplashScreenInitial()) {
    on<TimerTriggered>((event, emit) async {
      try {
        await Future.delayed(
          const Duration(milliseconds:500,),
          ()async {
            try{
              final token = await _coreStorageProvider.getToken();
              if(JwtDecoder.isExpired(token)){
                throw Exception("not signed in");
              }
              return emit(SplashScreenSignedIn());
            }catch (e){
              return emit(SplashScreenNotSignedIn());
            }
          },
        );
      } catch (e) {
        emit(SplashScreenErrorOccurred(e.toString()));
      }
    });
  }
}
