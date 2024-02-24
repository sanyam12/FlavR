part of 'outlet_list_bloc.dart';

abstract class OutletListState extends Equatable {
  const OutletListState();
}

class OutletListInitial extends OutletListState {
  @override
  List<Object> get props => [];
}

class OutletListLoading extends OutletListState {
  @override
  List<Object> get props => [];
}

class GetAllOutletsListState extends OutletListState{
  final List<Outlet> list;
  const GetAllOutletsListState({required this.list});

  @override
  List<Object?> get props => [list];
}

class GetSavedOutletListState extends OutletListState{
  final List<Outlet> list;
  const GetSavedOutletListState({required this.list});

  @override
  List<Object?> get props => [list];
}

class GetSearchResultState extends OutletListState{
  final List<Outlet> allOutletList;
  final List<Outlet> savedOutletList;
  final String query;
  const GetSearchResultState({required this.allOutletList,required this.savedOutletList, required this.query});

  @override
  List<Object?> get props => [allOutletList,savedOutletList, query];
}

class NavigateToProfile extends OutletListState{
  const NavigateToProfile();

  @override
  List<Object?> get props => [];
}


class OutletSelected extends OutletListState{
  final String id;
  const OutletSelected(this.id);

  @override
  List<Object?> get props => [id];

}

class RefreshWidget extends OutletListState{
  final int seed;
  const RefreshWidget(this.seed);
  @override
  List<Object?> get props => [seed];

}

class UsernameFetchedState extends OutletListState{
  final String username;

  const UsernameFetchedState(this.username);

  @override
  List<Object?> get props => [username];
}

class ErrorOccurred extends OutletListState{
  final String message;

  const ErrorOccurred(this.message);

  @override
  List<Object?> get props => [message];

}