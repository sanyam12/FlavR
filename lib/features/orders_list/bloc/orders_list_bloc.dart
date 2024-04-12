import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flavr/core/constants.dart';
import 'package:flavr/core/data_provider/core_storage_provider.dart';
import 'package:flavr/pages/profile_page/data/models/OrderData.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'orders_list_event.dart';

part 'orders_list_state.dart';

class OrdersListBloc extends Bloc<OrdersListEvent, OrdersListState> {
  final CoreStorageProvider _coreStorageProvider;
  OrdersListBloc(this._coreStorageProvider) : super(OrdersListInitial()) {
    on<OrdersListEvent>((event, emit) async {
      if (event is GetProfileData) {
        try{
          final token = await _coreStorageProvider.getToken();
          List<OrderData> stream = await getOrders(token.toString());
          throw Exception("message");
          emit(ProfileDataState(stream));
        }catch(e){
          emit(ShowSnackbar(e.toString()));
        }

      }
    });
  }

  Future<List<OrderData>> getOrders(String token) async {
    final List<OrderData> orderList = [];
    final response = await http.get(Uri.parse("${API_DOMAIN}orders/getorders"),
        headers: {"Authorization": "Bearer $token"});
    log(response.body);
    if (response.statusCode == 200) {
      final list = jsonDecode(response.body)["result"];
      for (var i in list) {
        final temp = OrderData.fromJson(i);
        orderList.add(temp);
      }
    }
    return orderList;
  }
}
