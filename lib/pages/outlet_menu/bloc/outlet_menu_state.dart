part of 'outlet_menu_bloc.dart';

abstract class OutletMenuState extends Equatable {
  const OutletMenuState();
}

class OutletMenuInitial extends OutletMenuState {
  @override
  List<Object> get props => [];
}

class NavigateToOutletList extends OutletMenuState{
  @override
  List<Object?> get props => [];
}

class RefreshedOutletData extends OutletMenuState{
  final String outletName;
  final List<Product> productList;
  final List<Categories> menuList;

  const RefreshedOutletData(this.outletName, this.productList, this.menuList);

  @override
  List<Object?> get props => [outletName, productList, menuList];

}

class SearchResultState extends OutletMenuState{
  final List<Categories> menuList;

  const SearchResultState(this.menuList);

  @override
  List<Object?> get props => [menuList];

}