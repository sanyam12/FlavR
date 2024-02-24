part of 'orders_list_bloc.dart';

abstract class OrdersListState extends Equatable {
  const OrdersListState();
}

class OrdersListInitial extends OrdersListState {
  @override
  List<Object> get props => [];
}

class ProfileDataState extends OrdersListState {
  final String userName;
  final String email;
  final String profilePicUrl;
  final List<OrderData> list;

  const ProfileDataState(
      this.userName,
      this.list,
      this.email,
      this.profilePicUrl,
      );

  @override
  List<Object?> get props => [
    userName,
    list,
    email,
  ];
}

class ShowSnackbar extends OrdersListState {
  final String messsage;

  const ShowSnackbar(this.messsage);

  @override
  List<Object?> get props => [messsage];
}

