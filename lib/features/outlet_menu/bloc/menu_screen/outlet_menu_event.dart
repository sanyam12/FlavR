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

class UpdateAmount extends OutletMenuEvent {
  final Product product;
  final Cart cart;
  final ProductVariantData variantData;
  final int newAmount;

  const UpdateAmount(
    this.product,
    this.cart,
    this.variantData,
    this.newAmount,
  );

  @override
  List<Object?> get props => [product, cart, variantData, newAmount];
}

class AddClicked extends OutletMenuEvent {
  final Product product;
  final Cart cart;

  const AddClicked(this.product, this.cart);

  @override
  List<Object?> get props => [product, cart];

}

class RemoveClicked extends OutletMenuEvent {
  final Product product;
  final Cart cart;

  const RemoveClicked(this.product, this.cart);

  @override
  List<Object?> get props => [product, cart];

}

class AddToExistingCart extends OutletMenuEvent {
  final Product product;
  final Cart cart;
  final ProductVariantData variantData;
  final int newAmount;

  const AddToExistingCart(
      this.product,
      this.cart,
      this.variantData,
      this.newAmount,
      );

  @override
  List<Object?> get props => [product, variantData, cart, newAmount];
}