import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flavr/features/outlet_menu/data/models/ProductVariantData.dart';
import 'package:flavr/features/cart/CartVariantData.dart';
import 'package:flavr/features/cart/cart_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../features/cart/Cart.dart';
import '../../../pages/profile_page/OrderData.dart' as OrderDataClass;
import '../../cart/Cart.dart';
import '../data/models/Categories.dart';
import '../data/models/Outlet.dart';
import '../data/models/Product.dart';
import '../data/repository/outlet_menu_repository.dart';

part 'outlet_menu_event.dart';

part 'outlet_menu_state.dart';

class OutletMenuBloc extends Bloc<OutletMenuEvent, OutletMenuState> {
  final OutletMenuRepository _repository;

  OutletMenuBloc(this._repository) : super(OutletMenuInitial()) {
    on<RefreshMenuEvent>(_refreshMenu);
    on<IncrementAmount>(_incrementAmount);
    on<DecrementAmount>(_decrementAmount);
  }

  _incrementAmount(
    IncrementAmount event,
    Emitter<OutletMenuState> emit,
  ) async {
    try {
      final newCart = Cart.fromParams(
        event.cart.outletId,
        event.cart.items,
        // event.cart.amount + event.variantData.price,
        // event.cart.cartTotalItems+1
      );
      if (newCart.items[event.product] != null) {
        final cartVariant = newCart.items[event.product]?.firstWhere((element) =>
                element.variantName == event.variantData.variantName);
        if (cartVariant == null) {
          newCart.items[event.product]?.add(
            CartVariantData(
              event.variantData.variantName,
              1,
              event.variantData.price,
            ),
          );
        } else {
          cartVariant.quantity++;
        }
      }
      else {
        final items = [CartVariantData(
          event.variantData.variantName,
          1,
          event.variantData.price,
        )];
        newCart.items[event.product] = items;
      }
      // newCart.items[event.product.id]?.totalItems++;

      emit(UpdatedCartState(newCart));
    } catch (e) {
      emit(ShowSnackBar(e.toString()));
    }
  }

  _decrementAmount(
    DecrementAmount event,
    Emitter<OutletMenuState> emit,
  ) {
    try {
      if (event.cart.items[event.product] != null) {
        final newCart = Cart.fromParams(
          event.cart.outletId,
          event.cart.items,
          // event.cart.amount - event.variantData.price,
          // event.cart.cartTotalItems-1,
        );
        final cartVariant = newCart.items[event.product]?.firstWhere((element) =>
                element.variantName == event.variantData.variantName);
        if (cartVariant?.quantity == null || cartVariant!.quantity <= 0) {
          throw Exception("This Item is not added");
        }
        cartVariant.quantity--;
        // newCart.items[event.product.id]?.totalItems--;

        emit(UpdatedCartState(newCart));
      } else {
        throw Exception("This Item is not added");
      }
    } catch (e) {
      emit(ShowSnackBar(e.toString()));
    }
  }

  _refreshMenu(
    RefreshMenuEvent event,
    Emitter<OutletMenuState> emit,
  ) async {
    try {
      final outlet = await _repository.getOutlet();
      final menu = await _repository.getOutletMenu(outlet.id);
      final cart = await _repository.getCart();
      emit(RefreshedOutletData(outlet.outletName, menu, cart));
    } catch (e) {
      emit(ShowSnackBar(e.toString()));
    }
  }

  Future<List<OrderDataClass.OrderData>> fetchIncompleteOrders() async {
    final List<OrderDataClass.OrderData> list = [];
    const secure = FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    );
    final token = await secure.read(key: "token");
    final response = await http.get(
        Uri.parse("https://flavr.tech/orders/getincomporder"),
        headers: {"Authorization": "Bearer $token"});
    final json = jsonDecode(response.body);
    for (var i in json["orders"] as List) {
      var temp = OrderDataClass.OrderData.fromJson(i);
      list.add(temp);
    }
    return list;
  }

  List<Categories> _searchResult(
    String query,
    List<Categories> categoriesList,
  ) {
    List<Categories> list = [];
    for (var i in categoriesList) {
      var temp = Categories(
          i.category,
          i.products
              .where((element) =>
                  element.name.toLowerCase().contains(query.toLowerCase()))
              .toList(),
          i.iconUrl);
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
      if (json["result"] != null && (json["result"] as List).isNotEmpty) {
        return Outlet.fromJson(json["result"][0]);
      } else {
        return null;
      }
    }
  }

  Future<List<Categories>> _fetchMenuItems(String id) async {
    final List<Categories> list = [];
    list.add(Categories("All", [], ""));
    final response = await http.get(
      Uri.parse(
          "https://flavr.tech/products/getProductsByCategory?categoryName=All&outletid=$id"),
    );
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (var i in (json["categoryArray"] as List)) {
        list.add(Categories.fromJson(i));
      }
      return list;
    } else {
      throw Exception("Something Went Wrong!!");
    }
    // List<String> categoryList = [];
    // List<Categories> ans = [];
    //
    // var queryParameters = {"outletid": id};
    // var response = await http.get(
    //     Uri.https("flavr.tech", "products/getAllCategories", queryParameters));
    //
    // var json = jsonDecode(response.body);
    // if(response.statusCode==200){
    //   for (var i in json["categories"]) {
    //     categoryList.add(i["category"].toString());
    //   }
    //
    //   for (var category in categoryList) {
    //     queryParameters = {"categoryName": category, "outletid": id};
    //     response = await http.get(Uri.https(
    //         "flavr.tech", "/products/getProductsByCategory", queryParameters));
    //     json = jsonDecode(response.body);
    //     final List<Product> productsList = [];
    //     for (var product in json["categoryArray"][0]["products"]) {
    //       productsList.add(Product.fromJson(product));
    //     }
    //     ans.add(
    //       Categories(category, productsList),
    //     );
    //   }
    //   ans.insert(0, Categories("All", []));
    //   return ans;
    // }else{
    //   throw Exception("something went wrong: ${response.body}");
    // }
  }

  Future<List<Product>> _fetchProducts(String id) async {
    List<Product> list = [];

    var query = {"outletid": id};

    var a =
        await http.get(Uri.https("flavr.tech", "/products/recommended", query));

    var json = jsonDecode(a.body);
    for (var i in json["products"]) {
      list.add(Product.fromJson(i));
    }

    //log(a.body);
    return list;
  }
}
