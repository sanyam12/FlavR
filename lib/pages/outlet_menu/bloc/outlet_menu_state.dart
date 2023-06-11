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

  const RefreshedOutletData(this.outletName, this.productList, this.menuList, this.cart);

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
  const UpdatedCartState(this.cart);

  @override
  List<Object?> get props => [cart];

}

class CartDataState extends OutletMenuState{
  final Cart cart;
  const CartDataState(this.cart);

  @override
  List<Object?> get props => [];
}

class AmountUpdatedState extends OutletMenuState{
  final int amount;

  const AmountUpdatedState(this.amount);

  @override
  List<Object?> get props => [amount];

}