import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'order_details_event.dart';
part 'order_details_state.dart';

class OrderDetailsBloc extends Bloc<OrderDetailsEvent, OrderDetailsState> {
  OrderDetailsBloc() : super(OrderDetailsInitial()) {
    on<OrderDetailsEvent>((event, emit) async{
      if(event is GetOrderData){
        const secure = FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));
        final token = (await secure.read(key: "token")).toString();
        final orderResponse = await http.get(
          Uri.parse("https://flavr.tech/orders/getOrder?orderid=${event.orderId}"),
        );

        if(orderResponse.statusCode==200){
          final orderDataJson = jsonDecode(orderResponse.body);
          // log(orderDataJson.toString());
          final outletID = orderDataJson["order"][0]["outlet"];
          // log(outletID.toString());
          final outletResponse = await http.get(
            Uri.parse("https://flavr.tech/outlet/getOutlet?outletid=$outletID"),
            headers: {
              "Authorization":"Bearer $token"
            }
          );
          if(outletResponse.statusCode==200){
            final outletDataJson = jsonDecode(outletResponse.body);

            emit(
                OrderData(
                    outletName: outletDataJson["result"][0]["outletName"],
                    outletAddress: outletDataJson["result"][0]["address"]["addressLine1"],
                    imageUrl: outletDataJson["result"][0]["outletImage"]["url"],
                )
            );
          }
          // log(outletResponse.body);
        }else{
          emit(const ShowSnackbar("Something went wrong"));
        }
      }
    });
  }
}
