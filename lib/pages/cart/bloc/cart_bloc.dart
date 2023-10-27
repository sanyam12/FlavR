import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:developer' as logger;
import 'package:flavr/pages/outlet_menu/Categories.dart';
import 'package:flavr/pages/outlet_menu/Product.dart';
import 'package:flavr/pages/outlet_menu/bloc/outlet_menu_bloc.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfdropcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/api/cftheme/cftheme.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Cart.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartEvent>((event, emit) async {
      if (event is GetCart) {
        // const secureStorage = FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));
        // final token =await secureStorage.read(key: "token");
        // final response = await http.get(
        //   Uri.parse("https://flavr.tech/user/getCartItems"),
        //   headers: {
        //     "Authorization": "Bearer $token"
        //   }
        // );
        // final json = jsonDecode(response.body);
        // final itemsList = json["cart"]["products"];
        for (var i in event.cart.items.entries) {
          final id = i.key;

          final productData = await http.get(Uri.https(
              "flavr.tech", "/products/getSingleProduct", {"productid": id}));

          event.list.add(
              Product.fromJson(jsonDecode(productData.body)["product"][0]),
          );

        }

        int grandTotal = 0;
        for (var i in event.list) {
          if(event.cart.items[i.id]!=null){
            for(var j in event.cart.items[i.id]!.entries){
              int price = 0;
              for(var itr in i.variantList){
                if(itr.variantName==j.value.variantName){
                  price = itr.price;
                  break;
                }
              }
              // final check = i.variantList.where((element) => element.variantName==j.value.variantName).toList();
              grandTotal += price * j.value.quantity;
            }
          }

          // if (event.cart.items[i.id] != null) {
          //
          //   grandTotal += (event.cart.items[i.id]!) * i.price;
          // }
        }

        emit(RefreshUI(grandTotal, Random().nextInt(10000)));
      }
      else if (event is UpdateCartEvent) {
        try {
          final pref = await SharedPreferences.getInstance();
          final outletId = pref.getString("selectedOutlet");
          if (outletId != null) {
            // event.cart.items[event.product.id] = event.newQuantity;

            List items = [];
            event.cart.items.forEach((productID, variantList) {
              variantList.forEach((variantName, variant) {
                if(variant.quantity!=0){
                  items.add(
                      {
                        "product":productID,
                        "variant":variantName,
                        "quantity":variant.quantity
                      }
                  );
                }
              });
            });
            event.cart.amount = grandTotalCounter(event.list, event.cart);

            const secureStorage = FlutterSecureStorage(
                aOptions: AndroidOptions(encryptedSharedPreferences: true));
            final token = await secureStorage.read(key: "token");
            final data = jsonEncode({
              "outletid": outletId,
              "items": items,
            });
            final response = await http.post(
              Uri.https(
                  "flavr.tech",
                  "/user/addProductsToCart",
              ),
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token'
              },
              body: data,
            );
          } else {
            emit(const ShowSnackbar("Outlet Not Selected"));
          }
        } on Exception catch (e) {
          emit(ShowSnackbar(e.toString()));
        }
      }
      else if (event is UpdateGrandTotal) {
        int grandTotal = 0;
        for (var i in event.list) {
          if (event.cart.items[i.id] != null) {
            for (var j in event.cart.items[i.id]!.entries) {
              int price = 0;
              if(j.value.variantName=="default"){
                price = i.price;
              }else{
                for (var itr in i.variantList) {
                  if (itr.variantName == j.value.variantName) {
                    price = itr.price;
                    break;
                  }
                }
              }
              // logger.log(price.toString());
              // final check = i.variantList.where((element) => element.variantName==j.value.variantName).toList();
              grandTotal += price * j.value.quantity;
            }
          }
        }
        emit(GrandTotalChanged(grandTotal));
      }
      else if (event is ProceedToPay) {
        const secure = FlutterSecureStorage(
            aOptions: AndroidOptions(encryptedSharedPreferences: true));
        final token = await secure.read(key: "token");
        final outletId = event.cart.outletId;

        final placeOrder = await http.post(
            //Uri.parse("https://"),]
            Uri.https("flavr.tech", "/orders/placeOrder"),
            headers: {
              "Authorization": "Bearer $token",
            },
            body: {
              "outletid": outletId
            });
        final orderId = jsonDecode(placeOrder.body)["order_id"].toString();
        final sessionID =
            jsonDecode(placeOrder.body)["payment_session_id"].toString();
        logger.log(orderId);
        try {
          var session = CFSessionBuilder()
              .setEnvironment(CFEnvironment.SANDBOX)
              .setOrderId(orderId)
              .setPaymentSessionId(sessionID)
              .build();

          var theme = CFThemeBuilder()
              .setNavigationBarBackgroundColorColor("#FF0000")
              .setPrimaryFont("Menlo")
              .setSecondaryFont("Futura")
              .build();
          var cfDropCheckoutPayment = CFDropCheckoutPaymentBuilder()
              .setSession(session)
              .setTheme(theme)
              .build();

          emit(StartCashFreeService(cfDropCheckoutPayment));
        } on CFException catch (e) {
          emit(ShowSnackbar(e.message));
        }

        // logger.log(orderDetails.body);
      }
      else if (event is VerifyPayment) {
        final orderDetails = await http.get(Uri.parse(
            "http://flavr.tech/orders/getOrder?orderid=${event.orderId}"));

        final json = jsonDecode(orderDetails.body);
        if (json["order"][0]["payment"] == true) {
          emit(NavigateToOrderNumber(Random().nextInt(10000), event.orderId));
        } else {
          emit(const ShowSnackbar("Payment Failed"));
        }
      }
    });
  }
  int grandTotalCounter(List<Categories> list, Cart cart){
    int grandTotal = 0;
    for(var i in list){
      for(var j in i.products){
        for(var k in j.variantList){
          if(cart.items[j.id]!=null && cart.items[j.id]![k.variantName]!= null){
            grandTotal += k.price * cart.items[j.id]![k.variantName]!.quantity;
          }
          // log("${j.name} ${k.variantName}");
        }
        if(cart.items[j.id]!=null && cart.items[j.id]!["default"]!= null){
          grandTotal += j.price * cart.items[j.id]!["default"]!.quantity;
        }
      }
    }

    logger.log("grand total $grandTotal");
    return grandTotal;
  }
}
