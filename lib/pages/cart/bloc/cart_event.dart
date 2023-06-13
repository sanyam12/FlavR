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
