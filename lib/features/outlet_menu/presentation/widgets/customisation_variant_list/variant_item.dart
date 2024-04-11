import 'package:flavr/features/cart/data/models/Cart.dart';
import 'package:flavr/features/cart/data/models/CartVariantData.dart';
import 'package:flavr/features/outlet_menu/bloc/menu_screen/outlet_menu_bloc.dart';
import 'package:flavr/features/outlet_menu/data/models/Product.dart';
import 'package:flavr/features/outlet_menu/data/models/ProductVariantData.dart';
import 'package:flavr/features/outlet_menu/presentation/widgets/customisation_variant_list/vegetarian_symbol.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VariantItem extends StatelessWidget {
  final Product product;
  final CartVariantData variantData;
  final Cart cart;

  const VariantItem({
    super.key,
    required this.product,
    required this.variantData,
    required this.cart,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const VegetarianSymbol(color: Colors.green),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("₹${variantData.price}"),
                Text(variantData.variantName)
              ],
            )
          ],
        ),
        Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<OutletMenuBloc>().add(
                          UpdateAmount(
                            product,
                            cart,
                            ProductVariantData.fromCartVariantData(variantData),
                            variantData.quantity - 1,
                          ),
                        );
                  },
                  child: const Icon(Icons.remove),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Text("${variantData.quantity}"),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<OutletMenuBloc>().add(
                          UpdateAmount(
                            product,
                            cart,
                            ProductVariantData.fromCartVariantData(variantData),
                            variantData.quantity + 1,
                          ),
                        );
                  },
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            Text("₹${variantData.price * variantData.quantity}"),
          ],
        )
      ],
    );
  }
}
