part of 'orders_list_bloc.dart';

abstract class OrdersListState extends Equatable {
  const OrdersListState();
}

class OrdersListInitial extends OrdersListState {
  @override
  List<Object> get props => [];
}

class ProfileDataState extends OrdersListState {
  final List<OrderData> list;

  const ProfileDataState(
    this.list,
  );

  @override
  List<Object?> get props => [list];
}

class ShowSnackbar extends OrdersListState {
  final String messsage;

  const ShowSnackbar(this.messsage);

  @override
  List<Object?> get props => [messsage];
}
