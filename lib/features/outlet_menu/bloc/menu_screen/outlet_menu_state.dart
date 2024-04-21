part of 'outlet_menu_bloc.dart';

abstract class OutletMenuState extends Equatable {
  const OutletMenuState();
}

//loading
class OutletMenuInitial extends OutletMenuState {
  @override
  List<Object> get props => [];
}

//loading
class OutletMenuLoading extends OutletMenuState {
  @override
  List<Object?> get props => [];
}

//listener
class ShowSnackBar extends OutletMenuState {
  final String message;

  const ShowSnackBar(this.message);

  @override
  List<Object?> get props => [message];
}

//listener
class NavigateToOutletList extends OutletMenuState {
  @override
  List<Object?> get props => [];
}

//update variables
class RefreshedOutletData extends OutletMenuState {
  //TODO: Incomplete orders list
  final String outletName;
  final List<Categories> menuList;

  // final List<Product> productList;
  // final List<OrderDataClass.OrderData> incompleteOrders;

  const RefreshedOutletData(
    this.outletName,
    this.menuList,
  );

  @override
  List<Object?> get props => [outletName, menuList];
}

//update variables
class UpdatedCartState extends OutletMenuState {
  final Cart cart;

  const UpdatedCartState(this.cart);

  @override
  List<Object?> get props => [cart];
}

class SearchResultState extends OutletMenuState {
  final List<Categories> menuList;

  const SearchResultState(this.menuList);

  @override
  List<Object?> get props => [menuList];
}

class FetchCart extends OutletMenuState {
  @override
  List<Object?> get props => [];
}

class VegFilterTriggered extends OutletMenuState{
  final List<Categories> menuList;
  final String vegSelection;

  const VegFilterTriggered(this.menuList, this.vegSelection);

  @override
  List<Object?> get props => [menuList, vegSelection];

}
class NonVegFilterTriggered extends OutletMenuState{
  final List<Categories> menuList;
  final String vegSelection;

  const NonVegFilterTriggered(this.menuList, this.vegSelection);

  @override
  List<Object?> get props => [menuList, vegSelection];

}

class FilterResultState extends OutletMenuState{
  final List<Categories> menuList;
  final String vegSelection;

  const FilterResultState({required this.menuList, required this.vegSelection});

  @override
  List<Object?> get props => [menuList, vegSelection];

}

class NeutralOutletMenu extends OutletMenuState{
  @override
  List<Object?> get props => [];
}

class ShowAllVariantsList extends OutletMenuState{
  final Product product;

  const ShowAllVariantsList(this.product);
  @override
  List<Object?> get props => [product];
}

class ShowCustomizationList extends OutletMenuState{
  final bool allowNewVariant;
  final Product product;
  final Cart cart;

  const ShowCustomizationList(this.product, this.cart, this.allowNewVariant);

  @override
  List<Object?> get props => [];
}