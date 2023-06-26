import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:socket_io_client/socket_io_client.dart';

part 'order_number_event.dart';

part 'order_number_state.dart';

class OrderNumberBloc extends Bloc<OrderNumberEvent, OrderNumberState> {
  OrderNumberBloc() : super(OrderNumberInitial()) {
    on<OrderNumberEvent>((event, emit) {

    });
  }
}
