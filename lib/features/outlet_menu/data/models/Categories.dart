import 'Product.dart';

class Categories{
  String category;
  String iconUrl;
  List<Product> products;

  Categories(this.category, this.products, this.iconUrl);

  Categories.fromJson(Map<String, dynamic> json)
    : category = json["category"],
      iconUrl = json["iconurl"],
      products = (json["products"] as List).map((e) => Product.fromJson(e)).toList();
}