part of 'outlet_list_bloc.dart';

abstract class OutletListState extends Equatable {
  const OutletListState();
}

class OutletListInitial extends OutletListState {
  @override
  List<Object> get props => [];
}

class GetAllOutletsListState extends OutletListState{
  final List<Outlet> list;
  const GetAllOutletsListState({required this.list});

  @override
  List<Object?> get props => [list];
}

class GetSearchResultState extends OutletListState{
  final List<Outlet> list;
  final String query;
  const GetSearchResultState({required this.list, required this.query});

  @override
  List<Object?> get props => [list, query];
}

class NavigateToProfile extends OutletListState{
  const NavigateToProfile();

  @override
  List<Object?> get props => [];
}

