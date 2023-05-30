import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'Categories.dart';
import 'Product.dart';
import 'dart:developer';

class OutletMenuBloc {
  final List<Product> productsList = [];
  final List<Categories> categoriesList = [];
  final _productsListStreamController = StreamController<List<Product>>();
  final _menuItemsStreamController = StreamController<List<Categories>>();

  Stream<List<Product>> get productsListStream =>
      _productsListStreamController.stream;

  StreamSink<List<Product>> get productsListSink =>
      _productsListStreamController.sink;

  Stream<List<Categories>> get menuItemsStream =>
      _menuItemsStreamController.stream;

  StreamSink<List<Categories>> get productSink =>
      _menuItemsStreamController.sink;

  OutletMenuBloc() {
    _fetchProducts().then((value) {
      //log(value.toString());
      _productsListStreamController.sink.add(value);
    });

    _fetchMenuItems().then((value) {
      _menuItemsStreamController.sink.add(value);
    });
  }

  Future<List<Product>> _fetchProducts() async {
    List<Product> list = [];

    var query = {"outletid": "6470c99f6940badfa7047608"};

    var a = await http.get(Uri.https(
        "flavrapi.onrender.com", "/products/getProductsOfOutlet", query));

    var json = jsonDecode(a.body);
    for (var i in json["products"]) {
      list.add(Product.fromJson(i));
    }

    //log(a.body);
    return list;
  }

  Future<List<Categories>> _fetchMenuItems() async {
    List<String> categoryList = [];
    List<Categories> ans = [];

    var queryParameters = {"outletid": "6470c99f6940badfa7047608"};
    var response = await http.get(Uri.https(
        "flavrapi.onrender.com", "products/getAllCategories", queryParameters));

    var json = jsonDecode(response.body);
    for (var i in json["categories"]) {
      categoryList.add(i["category"].toString());
    }

    for(var category in categoryList){
      queryParameters = {
        "categoryName": category,
        "outletid":"6470c99f6940badfa7047608"
      };
      response = await http.get(
          Uri.https(
            "flavrapi.onrender.com",
            "/products/getProductsByCategory",
            queryParameters
          )
      );
      json = jsonDecode(response.body);
      final List<Product> productsList = [];
      for(var product in json["products"]){
        productsList.add(Product.fromJson(product));
      }
      ans.add(
          Categories(
            category,
            productsList
          )
      );
    }

    return ans;
  }

  void dispose() {
    _productsListStreamController.close();
    _menuItemsStreamController.close();
  }
}
