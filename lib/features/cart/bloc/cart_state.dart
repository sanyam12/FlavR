part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartInitial extends CartState {
  @override
  List<Object> get props => [];
}

class RefreshUI extends CartState{
  final Cart cart;
  final int grandTotal;
  const RefreshUI(this.cart, this.grandTotal);
  @override
  List<Object?> get props => [grandTotal];
}

class ShowSnackbar extends CartState{
  final String message;
  const ShowSnackbar(this.message);

  @override
  List<Object?> get props => [message];

}

class GrandTotalChanged extends CartState{
  final int grandTotal;
  const GrandTotalChanged(this.grandTotal);

  @override
  List<Object?> get props => [grandTotal];

}

class NavigateToPaymentState extends CartState{
  @override
  List<Object?> get props => [];

}

class NavigateToOrderNumber extends CartState{
  final int seed;
  final String orderNumber;
  const NavigateToOrderNumber(this.seed, this.orderNumber);
  @override
  List<Object?> get props => [seed, orderNumber];

}

class CartLoading extends CartState{
  @override
  List<Object?> get props => [];
}