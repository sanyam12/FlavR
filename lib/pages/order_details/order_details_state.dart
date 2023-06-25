part of 'order_details_bloc.dart';

abstract class OrderDetailsState extends Equatable {
  const OrderDetailsState();
}

class OrderDetailsInitial extends OrderDetailsState {
  @override
  List<Object> get props => [];
}

class ShowSnackbar extends OrderDetailsState{
  final String message;

  const ShowSnackbar(this.message);

  @override
  List<Object?> get props => [message];

}

class OrderData extends OrderDetailsState{
  final String outletName;
  final String outletAddress;
  final String imageUrl;
  const OrderData({required this.outletName,required this.outletAddress,required this.imageUrl});

  @override
  List<Object?> get props => [outletName, outletAddress, imageUrl];

}