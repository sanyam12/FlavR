part of 'outlet_menu_bloc.dart';

abstract class OutletMenuEvent extends Equatable {
  const OutletMenuEvent();
}

class RefreshMenuEvent extends OutletMenuEvent{
  final Cart cart;
  const RefreshMenuEvent(this.cart);
  @override
  List<Object?> get props => [];
}

class SearchQueryEvent extends OutletMenuEvent{
  final String query;
  final List<Categories> categoriesList;
  const SearchQueryEvent(this.query, this.categoriesList);

  @override
  List<Object?> get props => [query, categoriesList];

}

class UpdateCartEvent extends OutletMenuEvent{
  final Product product;
  final Cart cart;
  final List<Product> list;
  const UpdateCartEvent(this.product, this.cart, this.list);

  @override
  List<Object?> get props => [product, cart, list];
}