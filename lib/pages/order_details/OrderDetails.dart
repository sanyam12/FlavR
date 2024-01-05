
import 'dart:developer';

import 'package:flavr/pages/order_details/order_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetails extends StatefulWidget {
  final String orderId;

  const OrderDetails({super.key, required this.orderId});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {

  final bloc = OrderDetailsBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        bloc.add(GetOrderData(widget.orderId));
        return bloc;
      },
      child: BlocListener<OrderDetailsBloc, OrderDetailsState>(
        listener: (context, state) {
          if(state is ShowSnackbar){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message))
            );
          }else if(state is OrderData){
            log(state.outletName);
            log(state.outletAddress);
            log(state.imageUrl);
          }
        },
        child: const Scaffold(
          body: Center(
            child: Text("Order Details"),
          ),
        ),
      ),
    );
  }
}
