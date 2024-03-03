import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flavr/core/constants.dart';
import 'package:flavr/pages/profile_page/OrderData.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

part 'orders_list_event.dart';

part 'orders_list_state.dart';

class OrdersListBloc extends Bloc<OrdersListEvent, OrdersListState> {
  OrdersListBloc() : super(OrdersListInitial()) {
    on<OrdersListEvent>((event, emit) async {
      if (event is GetProfileData) {
        const secure = FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true),
        );
        final token = await secure.read(key: "token");
        List<OrderData> stream = await getOrders(token.toString());
        emit(ProfileDataState(stream));
      }
    });
  }

  Future<List<OrderData>> getOrders(String token) async {
    final List<OrderData> orderList = [];
    final response = await http.get(Uri.parse("${API_DOMAIN}orders/getorders"),
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      final list = jsonDecode(response.body)["result"];
      for (var i in list) {
        final temp = OrderData.fromJson(i);
        orderList.add(temp);
        log("instruction test: ${temp.instruction}");
      }
    }
    return orderList;
  }
}
