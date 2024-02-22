import 'package:flavr/features/cart/data/models/Cart.dart';
import 'package:flavr/features/cart/data/models/CartVariantData.dart';
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
  _sendEvent(OutletMenuEvent event) {
    context.read<OutletMenuBloc>().add(
          event,
        );
  }

  int _calculateTotalProductItems(Product product) {
    int count = 0;
    for (var i in widget.cart.items[product] ?? <CartVariantData>[]) {
      count += i.quantity;
    }
    return count;
  }

  _incrementAmount(Product j) {
    if (j.variantList.isEmpty) {
      _sendEvent(
        IncrementAmount(
          j,
          widget.cart,
          ProductVariantData(
            "default",
            j.price,
          ),
        ),
      );
    } else {
      _showBottomSheet(
        title: "Select Items to Add",
        product: j,
        callback: (name, price) {
          _sendEvent(
            IncrementAmount(
              j,
              widget.cart,
              ProductVariantData(
                name,
                price,
              ),
            ),
          );
        },
      );
    }
  }

  _decrementAmount(Product j) {
    if (j.variantList.isEmpty) {
      context.read<OutletMenuBloc>().add(
            DecrementAmount(
              j,
              widget.cart,
              ProductVariantData("default", j.price),
            ),
          );
    } else {
      _showBottomSheet(
        title: "Select Items to Remove",
        product: j,
        callback: (name, price) {
          _sendEvent(
            DecrementAmount(
              j,
              widget.cart,
              ProductVariantData(
                name,
                price,
              ),
            ),
          );
        },
      );
    }
  }

  _showBottomSheet({
    required String title,
    required Product product,
    required void Function(String variant, int price) callback,
  }) {
    showBottomSheet(
      context: context,
      backgroundColor: const Color(0xFFA3C2B3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              title: Title(
                color: Colors.black,
                child: Text(title),
              ),
            ),
            for (var variant in product.variantList)
              ListTile(
                title: Text(variant.variantName),
                trailing: Text(variant.price.toString()),
                onTap: () {
                  callback(variant.variantName, variant.price);
                  Navigator.pop(context);
                },
              )
          ],
        );
      },
    );
  }

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
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 0.2861 * widget.width,
                    height: 0.1275 * widget.height,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: SizedBox(
                                width: 0.2861 * widget.width,
                                height: 0.1025 * widget.height,
                                child: (widget.product.productImage != "null")
                                    ? Image.network(widget.product.productImage)
                                    : Image.asset(
                                        "assets/images/pasta.jpeg",
                                      ),
                              ),
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
                                  color: Color(0xFF004932),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          _decrementAmount(widget.product);
                                        },
                                        child: const Icon(
                                          Icons.remove,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Text(_calculateTotalProductItems(widget.product)
                                        .toString()),
                                    SizedBox(
                                      width: 0.06777 * widget.width,
                                      height: 0.03125 * widget.height,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFFD6EAE1),
                                            padding: EdgeInsets.zero),
                                        onPressed: () {
                                          _incrementAmount(widget.product);
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
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.fromLTRB(0.0611 * widget.width, 0, 0, 0),
                    child: SizedBox(
                      // width: 0.46 * widget.width,
                      height: 0.08625 * widget.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              widget.product.veg
                                  ? SizedBox(
                                      width: 0.0654 * widget.width,
                                      child: Image.asset(
                                          "assets/images/vegetarian48.png"),
                                    )
                                  : SizedBox(
                                      width: 0.0654 * widget.width,
                                      child: Image.asset(
                                          "assets/images/nonvegetarian48.png"),
                                    ),
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
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(
                                    0.0566 * widget.width, 0, 0, 0),
                                width: 0.4 * widget.width,
                                child: Text(
                                  "₹${widget.product.price}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 0.4 * widget.width,
                                padding: EdgeInsets.fromLTRB(
                                  0.0566 * widget.width,
                                  0,
                                  0,
                                  0,
                                ),
                                child: Text(
                                  widget.product.description,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
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
      ),
    );
  }
}
