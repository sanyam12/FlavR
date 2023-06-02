import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../outlet_menu/Outlet.dart';

part 'outlet_list_event.dart';
part 'outlet_list_state.dart';

class OutletListBloc extends Bloc<OutletListEvent, OutletListState> {
  OutletListBloc() : super(OutletListInitial()) {
    on<OutletListEvent>((event, emit) {
      if(event is OnSearchButtonClicked){
        emit(GetSearchResultState(list: [], query: event.query));
      }else if(event is OnProfileButtonClicked){
        emit(const NavigateToProfile());
      }
    });
  }
}
