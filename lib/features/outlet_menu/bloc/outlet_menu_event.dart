part of 'outlet_menu_bloc.dart';

abstract class OutletMenuEvent extends Equatable {
  const OutletMenuEvent();
}

class RefreshMenuEvent extends OutletMenuEvent {
  const RefreshMenuEvent();

  @override
  List<Object?> get props => [];
}

class SearchQueryEvent extends OutletMenuEvent {
  final String query;
  final String vegSelection;
  final List<Categories> categoriesList;

  const SearchQueryEvent(
    this.categoriesList,
    this.vegSelection,
    this.query,
  );

  @override
  List<Object?> get props => [query, categoriesList];
}

class IncrementAmount extends OutletMenuEvent {
  final Product product;
  final Cart cart;
  final ProductVariantData variantData;

  const IncrementAmount(
    this.product,
    this.cart,
    this.variantData,
  );

  @override
  List<Object?> get props => [];
}

class DecrementAmount extends OutletMenuEvent {
  final Product product;
  final Cart cart;
  final ProductVariantData variantData;

  const DecrementAmount(this.product, this.cart, this.variantData);

  @override
  List<Object?> get props => [];
}

class OutletListClicked extends OutletMenuEvent {
  @override
  List<Object?> get props => [];
}

class UpdateCart extends OutletMenuEvent {
  @override
  List<Object?> get props => [];
}

class OnVegClicked extends OutletMenuEvent {
  final List<Categories> menuList;
  final String vegSelection;
  final String query;

  const OnVegClicked(
    this.menuList,
    this.vegSelection,
    this.query,
  );

  @override
  List<Object?> get props => [menuList, vegSelection];
}

class OnNonVegClicked extends OutletMenuEvent {
  final List<Categories> menuList;
  final String vegSelection;
  final String query;

  const OnNonVegClicked(
    this.menuList,
    this.vegSelection,
    this.query,
  );

  @override
  List<Object?> get props => [menuList, vegSelection, query];
}

// class UpdateCartEvent extends OutletMenuEvent{
//   final Product product;
//   final Cart cart;
//   final List<Product> list;
//   const UpdateCartEvent(this.product, this.cart, this.list);
//
//   @override
//   List<Object?> get props => [product, cart, list];
// }

class UpdateAmount extends OutletMenuEvent {
  final Product product;
  final Cart cart;
  final ProductVariantData variantData;
  final int newAmount;

  UpdateAmount(
    this.product,
    this.cart,
    this.variantData,
    this.newAmount,
  );

  @override
  List<Object?> get props => [];
}