import 'package:flavr/features/cart/data/models/Cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../outlet_menu/data/models/Product.dart';
import '../../../outlet_menu/data/models/ProductVariantData.dart';
import '../../bloc/cart_bloc.dart';
import '../../data/models/CartVariantData.dart';

class CartItems extends StatefulWidget {
  const CartItems({
    super.key,
    required this.width,
    required this.height,
    required this.product,
    required this.cart,
    required this.variant,
    required this.price,
    required this.list,
  });

  final double width;
  final double height;
  final Product product;
  final Cart cart;
  final List<Product> list;

  // final CartBloc bloc;
  final CartVariantData variant;
  final int price;

  @override
  State<CartItems> createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems> {
  int _items() {
    for (var i in widget.cart.items[widget.product] ?? <CartVariantData>[]) {
      if (i.variantName == widget.variant.variantName) {
        return i.quantity;
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0.0125 * widget.height, 0, 0),
      // padding: EdgeInsets.symmetric(horizontal: 0.07778 * width),
      child: SizedBox(
        width: 0.9083 * widget.width,
        height: 0.145* widget.height,
        child: Card(
          elevation: 1,

          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.03*widget.width, 0, 0.02*widget.width, 0),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0.007*widget.height, 0, 0.007*widget.height),
                  child: SizedBox(
                    height: 0.1125*widget.height,
                    width: 0.23*widget.width,
                    child: ClipRRect(
                      child: Image.asset(
                        'assets/images/burger.jpg',
                        fit: BoxFit.cover,
                      ),
                        borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.fromLTRB(0.0618 * widget.width, 0, 0, 0),
                //   child: const Stack(
                //     alignment: AlignmentDirectional.center,
                //     children: [
                //       Icon(
                //         Icons.crop_square_sharp,
                //         color: Colors.green,
                //         size: 25,
                //       ),
                //       Icon(Icons.circle, color: Colors.green, size: 10),
                //     ],
                //   ),
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.product.name,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Icon(
                                  Icons.crop_square_sharp,
                                  color: Colors.green,
                                  size: 25,
                                ),
                                Icon(Icons.circle, color: Colors.green, size: 10),
                              ],
                            ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.currency_rupee,
                          size: 15,
                        ),
                        Text(
                          widget.price.toString(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                          ),
                        ),
                        Text((widget.variant.variantName != "Default")
                            ? widget.variant.variantName
                            : ""),
                      ],
                    ),
                    Text(
                      widget.product.description,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
