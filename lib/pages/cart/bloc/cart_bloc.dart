import 'dart:async';
import 'dart:convert';
import 'dart:developer' as logger;
import 'dart:math';
import 'package:flavr/pages/outlet_menu/Product.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../Cart.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()){
    on<CartEvent>((event, emit) async{
      if(event is GetCart){
        const secureStorage = FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));
        final token =await secureStorage.read(key: "token");
        final response = await http.get(
          Uri.parse("https://flavr.tech/user/getCartItems"),
          headers: {
            "Authorization": "Bearer $token"
          }
        );
        final json = jsonDecode(response.body);
        final itemsList = json["cart"];
        for(var i in itemsList){
          final id = i["product"]["_id"];
          event.cart.items[id] = i["quantity"];

          final productData = await http.get(
            Uri.https(
              "flavr.tech",
              "/products/getSingleProduct",
              {
                "productid":id.toString()
              }
            )
          );

          event.list.add(
            Product.fromJson(jsonDecode(productData.body)["product"][0])
          );

        }

        int grandTotal = 0;
        for(var i in event.list){
          if(event.cart.items[i.id]!=null){
            grandTotal += (event.cart.items[i.id]!)*i.price;
          }
        }

        emit(RefreshUI(grandTotal,Random().nextInt(10000)));
      }
      else if (event is UpdateCartEvent){
        event.cart.items[event.product.id] = event.newQuantity;

        List items = [];
        event.cart.items.forEach((key, value) {
          if(value!=0){
            items.add(
                {
                  "product": key,
                  "quantity": value
                }
            );
            logger.log(value.toString());
          }
        });

        const secureStorage = FlutterSecureStorage(
            aOptions: AndroidOptions(encryptedSharedPreferences: true));
        final token = await secureStorage.read(key: "token");
        final data = jsonEncode({
          "items": items
        });
        final response = await http.post(
          Uri.https(
              "flavr.tech",
              "/user/addProductsToCart"
          ),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: data,
        );
      }
    });
  }
}
