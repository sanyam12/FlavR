class ProductVariantData{
  final String variantName;
  final int price;

  ProductVariantData(this.variantName, this.price);

  ProductVariantData.fromJson(Map<String, dynamic> json)
    : variantName = json["variantName"],
      price = json["price"];

}