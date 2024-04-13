import 'package:flavr/features/cart/data/models/CartVariantData.dart';

class ProductVariantData{
  final String variantName;
  final int price;

  ProductVariantData(this.variantName, this.price);

  ProductVariantData.fromJson(Map<String, dynamic> json)
    : variantName = json["variantName"],
      price = json["price"];

  ProductVariantData.fromCartVariantData(CartVariantData variantData)
    : variantName = variantData.variantName,
      price = variantData.price;
}