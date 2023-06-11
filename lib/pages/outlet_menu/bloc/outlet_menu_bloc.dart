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
    // List<Categories> categoriesList = [];
    on<OutletMenuEvent>((event, emit) async {
      if (event is RefreshMenuEvent) {
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
          emit(NavigateToOutletList());
        }
      }
      else if (event is SearchQueryEvent) {
        logger.log("search bloc check");
        final List<Categories> newList = [];
        for (var element in event.categoriesList) {
          newList.add(element);
        }
        final list = _searchResult(event.query, newList);
        final state = SearchResultState(list);
        emit(state);
      }
      else if (event is UpdateCartEvent) {
        event.cart.items[event.product.id] = event.newQuantity;

        List items = [];
        event.cart.items.forEach((key, value) {
          items.add(
            {
              "product": key,
              "quantity": value
            }
          );
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
      else if (event is GetCartEvent) {
        logger.log("sending cart details back");
        emit(CartDataState(event.cart));
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
        aOptions: AndroidOptions(encryptedSharedPreferences: false));
    final token = await secureService.read(key: "token");
    if (id == null) {
      return null;
    } else {
      final query = {"outletid": id};
      var response = await http.get(
          Uri.https("flavr.tech", "outlet/getOutlet", query),
          headers: {"Authorization": "Bearer $token"});
      final json = jsonDecode(response.body);
      return Outlet.fromJson(json["result"][0]);
    }
  }

  Future<List<Categories>> _fetchMenuItems(String id) async {
    List<String> categoryList = [];
    List<Categories> ans = [];

    var queryParameters = {"outletid": id};
    var response = await http.get(
        Uri.https("flavr.tech", "products/getAllCategories", queryParameters));

    var json = jsonDecode(response.body);
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
      final HashMap<String, int> temp= HashMap<String, int>();
      final list = json["cart"] as List;
      for(var i in list){
        temp[i["product"]["_id"]] = i["quantity"];
      }
      cart.items = temp;
    }

    return cart;
  }
}
