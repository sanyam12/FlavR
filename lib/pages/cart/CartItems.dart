import 'package:flavr/pages/outlet_menu/Product.dart';

class CartItems{
  final String product;
  // final String variant;
  final int quantity;

  CartItems(this.product, this.quantity);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['product'] = product;
    data['quantity'] = quantity;

    return data;
  }
}