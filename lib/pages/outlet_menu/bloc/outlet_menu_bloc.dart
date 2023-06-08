import 'dart:async';
import 'dart:convert';
import 'package:flavr/pages/outlet_menu/OutletMenu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Categories.dart';
import '../Outlet.dart';
import '../Product.dart';

part 'outlet_menu_event.dart';
part 'outlet_menu_state.dart';

class OutletMenuBloc extends Bloc<OutletMenuEvent, OutletMenuState> {

  List<Categories> categoriesList = [];

  OutletMenuBloc() : super(OutletMenuInitial()) {
    on<OutletMenuEvent>((event, emit)async {
      if(event is RefreshMenuEvent){
        String outletName = "Outlet";
        final selectedOutlet = await _fetchSelectedOutlet();
        if(selectedOutlet!=null){
          outletName = selectedOutlet.outletName;
          final List<Product> productList = await _fetchProducts(selectedOutlet.id);
          categoriesList = await _fetchMenuItems(selectedOutlet.id);

          emit(RefreshedOutletData(outletName, productList, categoriesList));

        }else{
          emit(NavigateToOutletList());
        }

      }
      else if(event is SearchQueryEvent){
        final list = _searchResult(event.query);
        emit(SearchResultState(list));
      }
    });
  }


  Future<Outlet?> _fetchSelectedOutlet() async{
    final pref = await SharedPreferences.getInstance();
    final id = pref.getString("selectedOutlet");
    const secureService = FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: false));
    final token = await secureService.read(key: "token");
    if(id==null){
      return null;
    }else{
      final query = {
        "outletid": id
      };
      var response = await http.get(
          Uri.https(
              "flavrapi.onrender.com",
              "outlet/getOutlet",
              query
          ),
          headers: {
            "Authorization": "Bearer $token"
          }
      );
      final json = jsonDecode(response.body);
      return Outlet.fromJson(json["result"][0]);
    }
  }

  Future<List<Categories>> _fetchMenuItems(String id) async {
    List<String> categoryList = [];
    List<Categories> ans = [];

    var queryParameters = {"outletid": id};
    var response = await http.get(Uri.https(
        "flavrapi.onrender.com", "products/getAllCategories", queryParameters));

    var json = jsonDecode(response.body);
    for (var i in json["categories"]) {
      categoryList.add(i["category"].toString());
    }

    for(var category in categoryList){
      queryParameters = {
        "categoryName": category,
        "outletid":id
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
        ),
      );
    }
    ans.insert(0,Categories("All", []));
    return ans;
  }

  Future<List<Product>> _fetchProducts(String id) async {
    List<Product> list = [];

    var query = {"outletid": id};

    var a = await http.get(Uri.https(
        "flavrapi.onrender.com", "/products/getProductsOfOutlet", query));

    var json = jsonDecode(a.body);
    for (var i in json["products"]) {
      list.add(Product.fromJson(i));
    }

    //log(a.body);
    return list;
  }

  List<Categories> _searchResult(String query){
    List<Categories> list=[];
    for(var i in categoriesList){
      var temp = Categories(i.category, i.products.where((element) => element.name.toLowerCase().contains(query.toLowerCase())).toList());
      if(temp.products.isNotEmpty){
        list.add(temp);
      }
    }
    return list;
  }
}
