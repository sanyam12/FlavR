part of 'orders_list_bloc.dart';

abstract class OrdersListEvent extends Equatable {
  const OrdersListEvent();
}

class GetProfileData extends OrdersListEvent{
  @override
  List<Object?> get props => [];
}