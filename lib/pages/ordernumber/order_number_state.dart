part of 'order_number_bloc.dart';

abstract class OrderNumberState extends Equatable {
  const OrderNumberState();
}

class OrderNumberInitial extends OrderNumberState {
  @override
  List<Object> get props => [];
}

class OrderDataState extends OrderNumberState{
  final OrderData orderData;
  const OrderDataState(this.orderData);

  @override
  List<Object?> get props => [orderData];


}
