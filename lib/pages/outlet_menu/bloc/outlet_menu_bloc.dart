import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:developer' as logger;
import 'dart:math';
import 'package:flavr/pages/cart/Cart.dart';
import 'package:flavr/pages/outlet_menu/OutletMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../cart/CartItems.dart';
import '../Categories.dart';
import '../Outlet.dart';
import '../Product.dart';

part 'outlet_menu_event.dart';

part 'outlet_menu_state.dart';

class OutletMenuBloc extends Bloc<OutletMenuEvent, OutletMenuState> {
  OutletMenuBloc() : super(OutletMenuInitial()) {
    on<OutletMenuEvent>((event, emit) async {
      if (event is RefreshMenuEvent) {
        try {
          String outletName = "Outlet";
          final selectedOutlet = await _fetchSelectedOutlet();
          if (selectedOutlet != null) {
            outletName = selectedOutlet.outletName;
            final List<Product> productList =
                await _fetchProducts(selectedOutlet.id);
            final categoriesList = await _fetchMenuItems(selectedOutlet.id);
            final cart = await _fetchUserCart();

            emit(RefreshedOutletData(outletName, productList, categoriesList, cart));
            emit(const AmountUpdatedState(100));
          } else {
            logger.log("error in selected Outlet");
            emit(NavigateToOutletList());
          }
        } on Exception catch (e) {
          logger.log("error in refresh menu event of outlet menu $e");
          emit(ShowSnackbar(e.toString()));
          emit(NavigateToOutletList());
        }
      }
      else if (event is SearchQueryEvent) {
        final List<Categories> newList = [];
        for (var element in event.categoriesList) {
          newList.add(element);
        }
        final list = _searchResult(event.query, newList);
        final state = SearchResultState(list);
        emit(state);
      }
      else if (event is UpdateCartEvent) {
        try {
          final outletId = await _fetchSelectedOutlet();
          logger.log(event.cart.outletId);
          if(outletId!=null){
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
              "outletid": outletId.id,
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
            logger.log(response.body.toString());
          }
          else{
            emit(const ShowSnackbar("Outlet Not Selected"));
          }
        } on Exception catch (e) {
          logger.log(e.toString());
        }
      }
    });
  }

  List<Categories> _searchResult(
      String query, List<Categories> categoriesList) {
    List<Categories> list = [];
    for (var i in categoriesList) {
      var temp = Categories(
          i.category,
          i.products
              .where((element) =>
                  element.name.toLowerCase().contains(query.toLowerCase()))
              .toList());
      if (temp.products.isNotEmpty) {
        list.add(temp);
      }
    }
    return list;
  }

  Future<Outlet?> _fetchSelectedOutlet() async {
    final pref = await SharedPreferences.getInstance();
    final id = pref.getString("selectedOutlet");
    const secureService = FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true));
    final token = await secureService.read(key: "token");
    if (id == null) {
      return null;
    } else {
      final query = {"outletid": id};
      var response = await http.get(
          Uri.https(
            "flavr.tech",
            "outlet/getOutlet",
            query,
          ),
          headers: {"Authorization": "Bearer $token"},
      );
      final json = jsonDecode(response.body);
      if(json["result"]!=null && (json["result"] as List).isNotEmpty){
        return Outlet.fromJson(json["result"][0]);
      }else{
        return null;
      }
    }
  }

  Future<List<Categories>> _fetchMenuItems(String id) async {
    List<String> categoryList = [];
    List<Categories> ans = [];

    var queryParameters = {"outletid": id};
    var response = await http.get(
        Uri.https("flavr.tech", "products/getAllCategories", queryParameters));

    var json = jsonDecode(response.body);
    if(response.statusCode==200){
      for (var i in json["categories"]) {
        categoryList.add(i["category"].toString());
      }

      for (var category in categoryList) {
        queryParameters = {"categoryName": category, "outletid": id};
        response = await http.get(Uri.https(
            "flavr.tech", "/products/getProductsByCategory", queryParameters));
        json = jsonDecode(response.body);
        final List<Product> productsList = [];
        for (var product in json["products"]) {
          productsList.add(Product.fromJson(product));
        }
        ans.add(
          Categories(category, productsList),
        );
      }
      ans.insert(0, Categories("All", []));
      return ans;
    }else{
      throw Exception("something went wrong: ${response.body}");
    }
  }

  Future<List<Product>> _fetchProducts(String id) async {
    List<Product> list = [];

    var query = {"outletid": id};

    var a = await http
        .get(Uri.https("flavr.tech", "/products/getProductsOfOutlet", query));

    var json = jsonDecode(a.body);
    for (var i in json["products"]) {
      list.add(Product.fromJson(i));
    }

    //log(a.body);
    return list;
  }

  Future<Cart> _fetchUserCart()async{
    Cart cart = Cart();
    const secureStorage = FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true));
    final token = await secureStorage.read(key: "token");
    final response = await http.get(
      Uri.parse("https://flavr.tech/user/getCartItems"),
      headers: {
        "Authorization":"Bearer $token"
      }
    );

    if(response.statusCode==200){
      final json = jsonDecode(response.body);
      logger.log(token.toString());
      final HashMap<String, int> temp = HashMap<String, int>();
      final list = json["cart"] as List;
      for(var i in list){
        temp[i["product"]["_id"]] = i["quantity"];
      }
      cart.items = temp;
    }

    return cart;
  }
}