import 'ProductVariantData.dart';

class Product {
  String _id;
  String _category;
  String _name;
  String _description;
  int _price;
  String _outletID;
  bool _veg;
  String _productImage;
  List<ProductVariantData> variantList;

  Product(
    this._id,
    this._category,
    this._name,
    this._description,
    this._price,
    this._outletID,
    this._veg,
    this._productImage,
    this.variantList,
  );

  set id(String id) {
    _id = id;
  }

  set category(String category) {
    _category = category;
  }

  set name(String name) {
    _name = name;
  }

  set description(String desc) {
    _description = desc;
  }

  set price(int price) {
    _price = price;
  }

  set outlet(String outlet) {
    _outletID = outlet;
  }

  set veg(bool veg) {
    _veg = veg;
  }

  set productImage(String img) {
    _productImage = img;
  }

  //getters
  String get id => _id;

  String get category => _category;

  String get name => _name;

  String get description => _description;

  int get price => _price;

  String get outlet => _outletID;

  bool get veg => _veg;

  String get productImage => _productImage;

  Product.fromJson(Map<String, dynamic> json)
      : _id = json["_id"].toString(),
        _category = json["category"]["name"],
        _name = json["productName"].toString(),
        _description = json["description"],
        _price = json["price"],
        _outletID = json["outlet"].toString(),
        _veg = json["veg"],
        _productImage = json["productImage"]["url"],
        variantList = (json["variants"] as List)
            .map((e) => ProductVariantData.fromJson(e))
            .toList();

  Map<String, dynamic> toJson() => {
        "id": _id,
        "category": _category,
        "name": _name,
        "description": _description,
        "price": _price,
        "outlet": _outletID,
        "veg": _veg,
        "productImage": _productImage
      };
}
