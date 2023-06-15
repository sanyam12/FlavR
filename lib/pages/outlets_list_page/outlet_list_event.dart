part of 'outlet_list_bloc.dart';

abstract class OutletListEvent extends Equatable {
  const OutletListEvent();
}

class OnSearchEvent extends OutletListEvent {
  final String query;
  final List<Outlet> savedOutlets;
  final List<Outlet> allOutlets;

  const OnSearchEvent(
      {required this.query,
      required this.savedOutlets,
      required this.allOutlets});

  @override
  List<Object?> get props => [query, savedOutlets, allOutlets];
}

class OnProfileButtonClicked extends OutletListEvent {
  const OnProfileButtonClicked();

  @override
  List<Object?> get props => [];
}

class GetAllOutletsList extends OutletListEvent {
  @override
  List<Object?> get props => [];
}

class GetSavedOutletList extends OutletListEvent {
  @override
  List<Object?> get props => [];
}

class OnOutletSelection extends OutletListEvent {
  final String id;

  const OnOutletSelection(this.id);

  @override
  List<Object?> get props => [id];
}

class OnAddToFav extends OutletListEvent {
  final Outlet id;
  final List<Outlet> savedList;
  final List<Outlet> allList;

  const OnAddToFav(this.id, this.savedList, this.allList);

  @override
  List<Object?> get props => [id, savedList, allList];
}
