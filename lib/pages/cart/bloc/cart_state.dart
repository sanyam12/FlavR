part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartInitial extends CartState {
  @override
  List<Object> get props => [];
}

class RefreshUI extends CartState{
  final int seed;
  final int grandTotal;
  const RefreshUI(this.grandTotal, this.seed);
  @override
  List<Object?> get props => [grandTotal, seed];

}

// class GetCartFromArguments()

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