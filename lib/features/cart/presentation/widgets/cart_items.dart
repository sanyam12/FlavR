import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../outlet_menu/data/models/Product.dart';
import '../../../outlet_menu/data/models/ProductVariantData.dart';
import '../../bloc/cart_bloc.dart';
import '../../data/models/Cart.dart';
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
        width: 0.888 * widget.width,
        child: Card(
          elevation: 3,
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 0.2861 * widget.width,
                height: 0.1275 * widget.height,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        height: 0.2 * widget.height,
                        width: 0.3 * widget.width,
                        child: (widget.product.productImage != "null")
                            ? Image.network(widget.product.productImage)
                            : const Image(
                                image: AssetImage("assets/images/pizza.jpg"),
                              ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: 0.205556 * widget.width,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Color(0xFF004932), width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 0.06777 * widget.width,
                                  height: 0.03125 * widget.height,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFFD6EAE1),
                                        padding: EdgeInsets.zero),
                                    onPressed: () {
                                      context.read<CartBloc>()
                                        ..add(
                                          CartDecrementAmount(
                                            widget.product,
                                            widget.cart,
                                            ProductVariantData(
                                              widget.variant.variantName,
                                              widget.variant.price,
                                            ),
                                          ),
                                        )
                                        ..add(
                                          UpdateGrandTotal(
                                            widget.cart,
                                            widget.list,
                                          ),
                                        );
                                    },
                                    child: const Icon(
                                      Icons.remove,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Text(_items().toString()),
                                SizedBox(
                                  width: 0.06777 * widget.width,
                                  height: 0.03125 * widget.height,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFFD6EAE1),
                                        padding: EdgeInsets.zero),
                                    onPressed: () {
                                      context.read<CartBloc>()
                                        ..add(
                                          CartIncrementAmount(
                                            widget.product,
                                            widget.cart,
                                            ProductVariantData(
                                              widget.variant.variantName,
                                              widget.variant.price,
                                            ),
                                          ),
                                        )
                                        ..add(
                                          UpdateGrandTotal(
                                            widget.cart,
                                            widget.list,
                                          ),
                                        );
                                    },
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.0618 * widget.width, 0, 0, 0),
                child: const Stack(
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
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.02 * widget.width, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                      overflow: TextOverflow.ellipsis,
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
