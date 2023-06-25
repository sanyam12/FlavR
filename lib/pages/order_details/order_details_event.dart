part of 'order_details_bloc.dart';

abstract class OrderDetailsEvent extends Equatable {
  const OrderDetailsEvent();
}

class GetOrderData extends OrderDetailsEvent{
  final String orderId;
  const GetOrderData(this.orderId);

  @override
  List<Object?> get props => [];
}
