class OrderData{
  final String id;
  final String outlet;
  final int totalPrice;
  final int totalQuantity;
  final String status;

  OrderData(this.id, this.outlet, this.totalPrice, this.totalQuantity, this.status);

  OrderData.fromJson(Map<String, dynamic> json)
    : id = json["_id"],
      outlet = json["outlet"],
      totalPrice = json["totalPrice"],
      totalQuantity = json["totalQuantity"],
      status = json["status"];
}