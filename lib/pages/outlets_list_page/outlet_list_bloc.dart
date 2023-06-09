import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../outlet_menu/Outlet.dart';

part 'outlet_list_event.dart';
part 'outlet_list_state.dart';

class OutletListBloc extends Bloc<OutletListEvent, OutletListState> {
  OutletListBloc() : super(OutletListInitial()){
    on<OutletListEvent>((event, emit) async{
      if(event is OnProfileButtonClicked){
        emit(const NavigateToProfile());
        emit(OutletListInitial());
      }
      else if(event is GetAllOutletsList){
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        const secureService = FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: false));
        final token = await secureService.read(key: "token");

        final list = prefs.getStringList("savedOutlets");
        final List<Outlet> outletLists = [];
        if(list!=null){
          for(var id in list){
            final query = {
              "outletid": id
            };
            var response = await http.get(
                Uri.https(
                    "flavr.tech",
                    "outlet/getOutlet",
                  query
                ),
              headers: {
                  "Authorization": "Bearer $token"
              }
            );
            final json = jsonDecode(response.body);
            outletLists.add(Outlet.fromJson(json["result"][0]));
          }
        }
        emit(GetAllOutletsListState(list: outletLists));
      }
      else if (event is OnScanQRCoreClick){
        emit(ScanButtonClicked());
        emit(OutletListInitial());
      }
      else if (event is OnOutletSelection){
        final pref = await SharedPreferences.getInstance();
        await pref.setString("selectedOutlet", event.id);
        emit(OutletSelected(event.id));
      }
    });
  }
}
