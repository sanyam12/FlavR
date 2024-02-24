import 'dart:ui';

import 'package:flavr/features/cart/data/models/Cart.dart';
import 'package:flavr/features/cart/data/models/CartVariantData.dart';
import 'package:flavr/features/outlet_menu/presentation/widgets/overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../bloc/outlet_menu_bloc.dart';
import '../../data/models/Product.dart';
import '../../data/models/ProductVariantData.dart';

class MenuItem extends StatefulWidget {
  const MenuItem({
    Key? key,
    required this.width,
    required this.height,
    required this.product,
    required this.cart,
  }) : super(key: key);

  final double width;
  final double height;
  final Product product;
  final Cart cart;

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.9027777778 * widget.width,
      height: 0.16625 * widget.height,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.white,
        elevation: 3,
        shadowColor: Colors.grey,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 0.9027777778 * widget.width,
            height: 0.16625 * widget.height,
            color: Colors.white,
            child: Row(
              children: [
                _getImage(
                  width: 0.3555555556 * widget.width,
                  height: 0.1694444444 * widget.height,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 12,
                      left: 12,
                      right: 20.0,
                      bottom: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 0.38 * widget.width,
                                  child: Text(
                                    widget.product.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily,
                                    ),
                                  ),
                                ),
                                _getVegIcon(),
                              ],
                            ),
                            RichText(
                              text: TextSpan(
                                  text: widget.product.description,
                                  style:
                                      GoogleFonts.poppins(color: Colors.black)),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Card(
                              color: const Color(0xFFF2F1F1),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 5,
                                ),
                                child: Text("₹ ${widget.product.price}"),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  )),
                              onPressed: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                      height: 0.84875 * widget.height,
                                      child: AddItemsOverlay(
                                        width: widget.width,
                                        height: widget.height,
                                        product: widget.product,
                                      ),
                                    );
                                  },
                                );
                              },
                              child: RichText(
                                text: TextSpan(
                                  text: "Add",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getImage({required double width, required double height}) {
    return (widget.product.productImage != "null")
        ? Image.network(
            widget.product.productImage,
            width: width,
            height: height,
            fit: BoxFit.cover,
          )
        : Image.asset(
            "assets/images/pasta.jpeg",
            width: width,
            height: height,
            fit: BoxFit.cover,
          );
  }

  _getVegIcon() {
    return widget.product.veg
        ? SizedBox(
            width: 0.0654 * widget.width,
            child: Image.asset("assets/images/vegetarian48.png"),
          )
        : SizedBox(
            width: 0.0654 * widget.width,
            child: Image.asset("assets/images/nonvegetarian48.png"),
          );
  }
}
