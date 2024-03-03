part of 'outlet_menu_bloc.dart';

abstract class OutletMenuState extends Equatable {
  const OutletMenuState();
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

//update variables
class RefreshedOutletData extends OutletMenuState {
  //TODO: Incomplete orders list
  final String outletName;
  final List<Categories> menuList;
  final Cart cart;
  final List<OrderData> incompleteOrders;

  // final List<Product> productList;
  // final List<OrderDataClass.OrderData> incompleteOrders;

  const RefreshedOutletData(
    this.outletName,
    this.menuList,
    this.cart,
    this.incompleteOrders,
  );

  @override
  List<Object?> get props => [outletName];
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

  FilterResultState({required this.menuList, required this.vegSelection});

  @override
  List<Object?> get props => [menuList, vegSelection];

}

// class CartDataState extends OutletMenuState{
//   final Cart cart;
//   const CartDataState(this.cart);
//
//   @override
//   List<Object?> get props => [cart];
// }

// class AmountUpdatedState extends OutletMenuState{
//   final int amount;
//   final int seed;
//   const AmountUpdatedState(this.amount, this.seed);
//
//   @override
//   List<Object?> get props => [amount, seed];
//
// }

// class CartState extends OutletMenuState{
//   final Cart cart;
//   const CartState(this.cart);
//
//   @override
//   List<Object?> get props => [cart];
// }
//
// class IncompleteOrdersState extends OutletMenuState{
//   final List<OrderDataClass.OrderData> list;
//   const IncompleteOrdersState(this.list);
//
//   @override
//   List<Object?> get props => [list];
// }
