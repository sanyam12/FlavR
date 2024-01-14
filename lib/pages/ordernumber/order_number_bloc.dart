import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../profile_page/OrderData.dart';


part 'order_number_event.dart';

part 'order_number_state.dart';

class OrderNumberBloc extends Bloc<OrderNumberEvent, OrderNumberState> {
  OrderNumberBloc() : super(OrderNumberInitial()) {
    on<OrderNumberEvent>((event, emit) async{
      if(event is GetOrderData){
        final response = await http.get(
          Uri.parse("http://flavr.tech/orders/getOrder?orderid=${event.orderId}"),
        );

        final orderData = OrderData.fromJson(jsonDecode(response.body)["order"][0]);
        emit(OrderDataState(orderData));
      }
    });
  }
}
