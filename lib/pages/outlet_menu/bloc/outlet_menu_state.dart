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
  final Cart cart;
  final List<OrderDataClass.OrderData> incompleteOrders;

  const RefreshedOutletData(this.outletName, this.productList, this.menuList, this.cart, this.incompleteOrders);

  @override
  List<Object?> get props => [outletName, productList, menuList, cart];

}

class SearchResultState extends OutletMenuState{
  final List<Categories> menuList;

  const SearchResultState(this.menuList);

  @override
  List<Object?> get props => [menuList, Random().nextInt(10000)];

}

class UpdatedCartState extends OutletMenuState{
  final Cart cart;
  final int seed;
  const UpdatedCartState(this.cart, this.seed);

  @override
  List<Object?> get props => [cart, seed];

}

class CartDataState extends OutletMenuState{
  final Cart cart;
  const CartDataState(this.cart);

  @override
  List<Object?> get props => [cart];
}

class AmountUpdatedState extends OutletMenuState{
  final int amount;
  final int seed;
  const AmountUpdatedState(this.amount, this.seed);

  @override
  List<Object?> get props => [amount, seed];

}

class ShowSnackbar extends OutletMenuState{
  final String message;
  const ShowSnackbar(this.message);

  @override
  List<Object?> get props => [message];

}