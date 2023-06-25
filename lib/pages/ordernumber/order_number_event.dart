part of 'order_number_bloc.dart';

abstract class OrderNumberEvent extends Equatable {
  const OrderNumberEvent();
}

class SocketEvent extends OrderNumberEvent{
  final String orderNumber;
  const SocketEvent(this.orderNumber);
  @override
  List<Object?> get props => [orderNumber];
}
