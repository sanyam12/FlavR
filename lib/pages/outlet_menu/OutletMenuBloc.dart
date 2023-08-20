// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'Categories.dart';
// import 'Outlet.dart';
// import 'Product.dart';
//
// class OutletMenuBloc {
//   final List<Product> productsList = [];
//   List<Categories> categoriesList = [];
//   final _productsListStreamController = StreamController<List<Product>>();
//   final _menuItemsStreamController = StreamController<List<Categories>>();
//   final _searchQueryStreamController = StreamController<String>();
//   final _selectedOutletStreamController = StreamController<String>();
//   final _refreshStreamController = StreamController<String>();
//
//   Stream<List<Product>> get productsListStream =>
//       _productsListStreamController.stream;
//
//   StreamSink<List<Product>> get productsListSink =>
//       _productsListStreamController.sink;
//
//   Stream<List<Categories>> get menuItemsStream =>
//       _menuItemsStreamController.stream;
//
//   Stream<String> get selectedOutletStream =>
//     _selectedOutletStreamController.stream;
//
//   StreamSink<List<Categories>> get productSink =>
//       _menuItemsStreamController.sink;
//
//   StreamSink<String> get searchQuerySink =>
//     _searchQueryStreamController.sink;
//
//   StreamSink<String> get refreshSink =>
//     _refreshStreamController.sink;
//
//   OutletMenuBloc() {
//     _refreshOrLoadPage();
//
//     _refreshStreamController.stream.listen((event) {
//       _refreshOrLoadPage();
//     });
//
//     _searchQueryStreamController.stream.listen(_searchResult);
//   }
//
//   _refreshOrLoadPage(){
//     _fetchSelectedOutlet().then((value) {
//       if(value!=null){
//         _selectedOutletStreamController.sink.add(value.outletName);
//       }else{
//         _selectedOutletStreamController.sink.add("Outlet");
//       }
//       if(value is Outlet){
//         _fetchProducts(value.id).then((value) {
//           _productsListStreamController.sink.add(value);
//         });
//
//         _fetchMenuItems(value.id).then((value) {
//           _menuItemsStreamController.sink.add(value);
//         });
//       }
//     });
//   }
//
//   _searchResult(String query){
//     List<Categories> list=[];
//     for(var i in categoriesList){
//       var temp = Categories(i.category, i.products.where((element) => element.name.toLowerCase().contains(query.toLowerCase())).toList());
//       if(temp.products.isNotEmpty){
//         list.add(temp);
//       }
//     }
//     log(list.toString());
//     _menuItemsStreamController.add(list);
//     // _productsListStreamController.add(productsList.where((element) => element.name.contains(query)).toList());
//   }
//
//   Future<List<Product>> _fetchProducts(String id) async {
//     List<Product> list = [];
//
//     var query = {"outletid": id};
//
//     var a = await http.get(Uri.https(
//         "flavrapi.onrender.com", "/products/getProductsOfOutlet", query));
//
//     var json = jsonDecode(a.body);
//     for (var i in json["products"]) {
//       list.add(Product.fromJson(i));
//     }
//
//     //log(a.body);
//     return list;
//   }
//
//   Future<List<Categories>> _fetchMenuItems(String id) async {
//     List<String> categoryList = [];
//     List<Categories> ans = [];
//
//     var queryParameters = {"outletid": id};
//     var response = await http.get(Uri.https(
//         "flavrapi.onrender.com", "products/getAllCategories", queryParameters));
//
//     var json = jsonDecode(response.body);
//     for (var i in json["categories"]) {
//       categoryList.add(i["category"].toString());
//     }
//
//     for(var category in categoryList){
//       queryParameters = {
//         "categoryName": category,
//         "outletid":id
//       };
//       response = await http.get(
//           Uri.https(
//             "flavrapi.onrender.com",
//             "/products/getProductsByCategory",
//             queryParameters
//           )
//       );
//       json = jsonDecode(response.body);
//       final List<Product> productsList = [];
//       for(var product in json["products"]){
//         productsList.add(Product.fromJson(product));
//       }
//       ans.add(
//           Categories(
//             category,
//             productsList
//           ),
//       );
//     }
//     categoriesList = ans;
//
//     return ans;
//   }
//
//   Future<Outlet?> _fetchSelectedOutlet() async{
//     final pref = await SharedPreferences.getInstance();
//     final id = pref.getString("selectedOutlet");
//     const secureService = FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: false));
//     final token = await secureService.read(key: "token");
//     if(id==null){
//       return null;
//     }else{
//       final query = {
//         "outletid": id
//       };
//       var response = await http.get(
//           Uri.https(
//               "flavrapi.onrender.com",
//               "outlet/getOutlet",
//               query
//           ),
//           headers: {
//             "Authorization": "Bearer $token"
//           }
//       );
//       final json = jsonDecode(response.body);
//       return Outlet.fromJson(json["result"][0]);
//     }
//   }
//
//   void dispose() {
//     _productsListStreamController.close();
//     _menuItemsStreamController.close();
//     _searchQueryStreamController.close();
//     _selectedOutletStreamController.close();
//     _refreshStreamController.close();
//   }
// }
