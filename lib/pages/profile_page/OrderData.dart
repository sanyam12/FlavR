import 'package:cloud_firestore/cloud_firestore.dart';

import 'OrderProductData.dart';

class OrderData{
  final String id;
  final String outlet;
  final int totalPrice;
  final int totalQuantity;
  final String status;
  final List<OrderProductData> products;
  final int? orderNumber;

  List<OrderProductData>_getProductList(List<dynamic> list)
  {
    final List<OrderProductData> ans = [];
    for(var i in list){
      ans.add(OrderProductData.fromJson(i));
    }
    return ans;
  }

  OrderData(this.id, this.outlet, this.totalPrice, this.totalQuantity, this.status, this.products, this.orderNumber);

  OrderData.fromJson(Map<String, dynamic> json)
    : id = json["_id"],
      outlet = json["outlet"],
      totalPrice = json["totalPrice"],
      totalQuantity = json["totalQuantity"],
      status = json["status"],
      products = (json["products"] as List).map((e) => OrderProductData.fromJson(e)).toList(),
      orderNumber = json["orderNumber"];

}