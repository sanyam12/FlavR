part of 'order_number_bloc.dart';

abstract class OrderNumberEvent extends Equatable {
  const OrderNumberEvent();
}

class GetOrderData extends OrderNumberEvent{
  final String orderId;
  const GetOrderData(this.orderId);

  @override
  List<Object?> get props => [orderId];

}
