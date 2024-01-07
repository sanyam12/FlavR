part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class UpdateCartEvent extends CartEvent {
  final Product product;
  final Cart cart;
  final List<Categories> list;

  const UpdateCartEvent(this.product, this.cart, this.list);

  @override
  List<Object?> get props => [product, cart];
}

class UpdateGrandTotal extends CartEvent {
  final Cart cart;
  final List<Product> list;

  const UpdateGrandTotal(this.cart, this.list);

  @override
  List<Object?> get props => [cart, list];
}

class CartIncrementAmount extends CartEvent {
  final Product product;
  final Cart cart;
  final ProductVariantData variantData;

  const CartIncrementAmount(this.product, this.cart, this.variantData);

  @override
  List<Object?> get props => [product, cart, variantData];
}

class CartDecrementAmount extends CartEvent {
  final Product product;
  final Cart cart;
  final ProductVariantData variantData;

  const CartDecrementAmount(this.product, this.cart, this.variantData);

  @override
  List<Object?> get props => [product, cart, variantData];
}

// class GetCart extends CartEvent{
//   final Cart cart;
//   final List<Product> list;
//   const GetCart(this.cart, this.list);
//   @override
//   List<Object?> get props => [cart, list];
// }

// class ProceedToPay extends CartEvent{
//   final Cart cart;
//   const ProceedToPay(this.cart);
//   @override
//   List<Object?> get props => [];
//
// }

// class VerifyPayment extends CartEvent{
//   final String orderId;
//
//   const VerifyPayment(this.orderId);
//
//   @override
//   List<Object?> get props => [];
//
// }
