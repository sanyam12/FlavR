part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class GetCart extends CartEvent{
  final Cart cart;
  final List<Product> list;
  const GetCart(this.cart, this.list);
  @override
  List<Object?> get props => [cart, list];
}

class UpdateCartEvent extends CartEvent{
  final Product product;
  final int newQuantity;
  final Cart cart;
  const UpdateCartEvent(this.product, this.newQuantity, this.cart);

  @override
  List<Object?> get props => [product, newQuantity, cart];
}

class UpdateGrandTotal extends CartEvent{
  final Cart cart;
  final List<Product> list;
  const UpdateGrandTotal(this.cart, this.list);

  @override
  List<Object?> get props => [cart, list];
}