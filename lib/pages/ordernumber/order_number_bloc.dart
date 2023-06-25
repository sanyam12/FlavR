import 'dart:async';
import 'dart:developer';
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
      if(event is SocketEvent){
        log("socket event");
        IO.Socket socket = IO.io("ws://flavr.tech/",
            OptionBuilder()
                .setTransports(['websocket'])
                .disableAutoConnect()
                .build()
        );
        socket.connect();
        socket.onConnect((data) => log("connected"));
      }
    });
  }
}
