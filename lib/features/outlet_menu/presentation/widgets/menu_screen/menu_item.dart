import 'package:flavr/features/cart/data/models/Cart.dart';
import 'package:flavr/features/outlet_menu/bloc/menu_screen/outlet_menu_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/models/Product.dart';

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
  String _calculateTotalItem() {
    int ans = 0;
    final list = widget.cart.items[widget.product];
    if (list != null) {
      for (var i in list) {
        ans += i.quantity;
      }
      return ans.toString();
    } else {
      return "0";
    }
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
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
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 5,
                                ),
                                child: Text("₹ ${widget.product.price}"),
                              ),
                            ),
                            _getButtons()
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

  Widget _getButtons() {
    final buttonSize = 36.0;
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFF2F1F1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.zero,
    );
    final list = widget.cart.items[widget.product];
    if (list != null && list.isNotEmpty) {
      return Row(
        children: [
          SizedBox(
            width: buttonSize,
            height: buttonSize,
            child: ElevatedButton(
              style: buttonStyle,
              onPressed: () {
                context.read<OutletMenuBloc>().add(RemoveClicked(
                      widget.product,
                      widget.cart,
                    ));
              },
              child: const Icon(
                Icons.remove,
                size: 14,
              ),
            ),
          ),
          const SizedBox(width: 8,),
          Text(_calculateTotalItem()),
          const SizedBox(width: 8,),
          SizedBox(
            width: buttonSize,
            height: buttonSize,
            child: ElevatedButton(
              style: buttonStyle,
              onPressed: () {
                context.read<OutletMenuBloc>().add(AddClicked(
                      widget.product,
                      widget.cart,
                    ));
              },
              child: const Icon(
                Icons.add,
                size: 14,
              ),
            ),
          ),
        ],
      );
    }
    else {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
        ),
        onPressed: () {
          context.read<OutletMenuBloc>().add(AddClicked(
                widget.product,
                widget.cart,
              ));
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
      );
    }
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
