import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'OrderData.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      if(event is GetProfileData){
        const secure = FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));
        final token = await secure.read(key: "token");
        http.Response response = await http.get(
          Uri.parse("https://flavr.tech/user/userprofile"),
          headers: {
            "Authorization":"Bearer $token"
          }
        );
        if(response.statusCode==201){
          final json = jsonDecode(response.body);
          final userName = json["user"][0]["userName"];

          Stream<List<OrderData>> stream = check(token.toString());

          emit(ProfileDataState(userName, stream));
        }else{
          emit(ShowSnackbar(response.body));
        }

      }
    });
  }

  Stream<List<OrderData>> check(String token)async*{
    final List<OrderData> orderList = [];
    final response = await http.get(
      Uri.parse("https://flavr.tech/orders/getorders"),
      headers: {
        "Authorization":"Bearer $token"
      }
    );
    if(response.statusCode==200){
      final list = jsonDecode(response.body)["result"];
      for(var i in list){
        orderList.add(OrderData.fromJson(i));
      }
      yield orderList;
    }
  }

  // Stream<List<OrderData>> check(List<dynamic> orderIdList)async*{
  //   final List<OrderData> orderList = [];
  //   for(var orderId in orderIdList){
  //     final response = await http.get(
  //         Uri.parse("https://flavr.tech/orders/getOrder?orderid=$orderId")
  //     );
  //     log(response.body);
  //     orderList.add(OrderData.fromJson(jsonDecode(response.body)["order"][0]));
  //     yield orderList;
  //   }
  // }
}
