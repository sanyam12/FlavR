import 'dart:convert';
import 'dart:developer' as logger;
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../outlet_menu/Outlet.dart';

part 'outlet_list_event.dart';

part 'outlet_list_state.dart';

class OutletListBloc extends Bloc<OutletListEvent, OutletListState> {
  OutletListBloc() : super(OutletListInitial()) {
    on<OutletListEvent>((event, emit) async {
      if (event is OnProfileButtonClicked) {
        emit(const NavigateToProfile());
        emit(OutletListInitial());
      }
      else if (event is GetSavedOutletList) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        const secureService = FlutterSecureStorage(
            aOptions: AndroidOptions(encryptedSharedPreferences: true));
        final token = await secureService.read(key: "token");

        final list = prefs.getStringList("savedOutlets");
        final List<Outlet> outletLists = [];
        if (list != null) {
          for (var id in list) {
            final query = {"outletid": id};
            var response = await http.get(
              Uri.https(
                "flavr.tech",
                "outlet/getOutlet",
                query,
              ),
              headers: {"Authorization": "Bearer $token"},
            );
            final json = jsonDecode(response.body);
            if (json["result"] != null && (json["result"] as List).isNotEmpty) {
              outletLists.add(Outlet.fromJson(json["result"][0]));
            }
          }
          for (var i in outletLists) {
            i.isFavourite = true;
          }
        }
        emit(GetSavedOutletListState(list: outletLists));
      }
      else if (event is OnOutletSelection) {
        final pref = await SharedPreferences.getInstance();
        await pref.setString("selectedOutlet", event.id);
        emit(OutletSelected(event.id));
      }
      else if (event is GetAllOutletsList) {
        final List<Outlet> list = [];
        final response =
            await http.get(Uri.https("flavr.tech", "/outlet/getAllOutlets"));
        logger.log(response.body);
        final json = jsonDecode(response.body);
        for (var i in json["outlets"]) {
          list.add(Outlet.fromJson(i));
        }
        emit(GetAllOutletsListState(list: list));
      }
      else if (event is OnAddToFav) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        List<String> list = [];
        if(prefs.getStringList("savedOutlets")!=null){
          list = prefs.getStringList("savedOutlets")!;
        }
        if (event.savedList.contains(event.id)) {
          event.allList.add(event.id);
          event.savedList.remove(event.id);
          list.remove(event.id.id);
        } else {
          event.savedList.add(event.id);
          event.allList.remove(event.id);
          list.add(event.id.id);
        }

        prefs.setStringList("savedOutlets", list);
        event.id.isFavourite = !event.id.isFavourite;
        emit(RefreshWidget(Random().nextInt(10000)));
      }
      else if (event is OnSearchEvent) {
        final savedOutlets = event.savedOutlets.where((element) => element.outletName
            .toLowerCase()
            .contains(event.query.toLowerCase())).toList();

        final allOutlets = event.allOutlets.where((element) => element.outletName
            .toLowerCase()
            .contains(event.query.toLowerCase())).toList();

        logger.log(savedOutlets.toString());

        emit(GetSearchResultState(
            allOutletList: allOutlets,
            savedOutletList: savedOutlets,
            query: event.query));
      }
    });
  }
}
