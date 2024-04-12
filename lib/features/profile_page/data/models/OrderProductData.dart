class OrderProductData{
  final String imageUrl;
  final String id;
  final String category;
  final String productName;
  final String description;
  final int price;
  final bool veg;
  final String variant;
  final int quantity;
  bool readyToDeliver;

  OrderProductData.fromJson(Map<String, dynamic> json)
  : imageUrl = json["item"]["productImage"]["url"],
    id = json["item"]["_id"],
    category = json["item"]["category"],
    productName = json["item"]["productName"],
    description = json["item"]["description"],
    price = json["item"]["price"],
    veg = json["item"]["veg"],
    variant = json["variant"],
    quantity = json["quantity"],
    readyToDeliver = json["readyToDeliver"];
}