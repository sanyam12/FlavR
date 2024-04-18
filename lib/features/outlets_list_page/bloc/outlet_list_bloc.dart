import 'dart:convert';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../outlet_menu/data/models/Outlet.dart';
import '../data/repository/outlet_list_repository.dart';

part 'outlet_list_event.dart';

part 'outlet_list_state.dart';

class OutletListBloc extends Bloc<OutletListEvent, OutletListState> {
  final OutletListRepository _repository;

  OutletListBloc(this._repository) : super(OutletListInitial()) {
    on<OnProfileButtonClicked>(_onProfileButtonClicked);
    on<GetSavedOutletList>(_getSavedOutletList);
    on<GetAllOutletsList>(_getAllOutletsList);
    on<OnAddToFav>(_onAddToFav);
    on<OnOutletSelection>(_onOutletSelection);
    on<OnSearchEvent>(_onSearchEvent);
  }

  void _onProfileButtonClicked(
    OutletListEvent event,
    Emitter<OutletListState> emit,
  ) {
    emit(const NavigateToProfile());
    emit(OutletListInitial());
  }

  void _getAllOutletsList(
    OutletListEvent event,
    Emitter<OutletListState> emit,
  ) async {
    final list = await _repository.getAllOutlets();
    emit(GetAllOutletsListState(list: list));
  }

  void _onOutletSelection(
    OnOutletSelection event,
    Emitter<OutletListState> emit,
  ) async {
    try {
      await _repository.setSelectedOutlet(event.id);
      emit(OutletSelected(event.id));
      emit(OutletListInitial());
    } catch (e) {
      emit(ErrorOccurred(e.toString()));
      emit(OutletListInitial());
    }
  }

  void _getSavedOutletList(
    OutletListEvent event,
    Emitter<OutletListState> emit,
  ) async {
    try {
      final token = await _repository.getToken();
      final idList = await _repository.getSavedOutletsID();
      final responseList = await _repository.getSavedOutletList(token, idList);
      final List<Outlet> outletLists = [];
      for (var i in responseList) {
        final json = jsonDecode(i);
        if (json["result"] != null && (json["result"] as List).isNotEmpty) {
          outletLists.add(Outlet.fromJson(json["result"][0]));
        }
      }
      for (var i in outletLists) {
        i.isFavourite = true;
      }
      emit(GetSavedOutletListState(list: outletLists));
    } catch (e) {
      emit(ErrorOccurred(e.toString()));
      emit(OutletListInitial());
    }
  }

  void _onAddToFav(
    OnAddToFav event,
    Emitter<OutletListState> emit,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> list = [];
    if (prefs.getStringList("savedOutlets") != null) {
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

  void _onSearchEvent(
    OnSearchEvent event,
    Emitter<OutletListState> emit,
  ) {
    final savedOutlets = event.savedOutlets
        .where((element) => element.outletName
            .toLowerCase()
            .contains(event.query.toLowerCase()))
        .toList();

    final allOutlets = event.allOutlets
        .where((element) => element.outletName
            .toLowerCase()
            .contains(event.query.toLowerCase()))
        .toList();

    emit(GetSearchResultState(
      allOutletList: allOutlets,
      savedOutletList: savedOutlets,
      query: event.query,
    ));
    emit(OutletListInitial());
  }
}
