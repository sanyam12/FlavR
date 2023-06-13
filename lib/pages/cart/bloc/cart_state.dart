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
