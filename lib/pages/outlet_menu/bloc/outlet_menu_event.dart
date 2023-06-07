part of 'outlet_menu_bloc.dart';

abstract class OutletMenuEvent extends Equatable {
  const OutletMenuEvent();
}

class RefreshMenuEvent extends OutletMenuEvent{
  @override
  List<Object?> get props => [];
}

class SearchQueryEvent extends OutletMenuEvent{
  final String query;
  const SearchQueryEvent(this.query);

  @override
  List<Object?> get props => [query];

}