import 'package:flavr/features/cart/data/models/Cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0.007*widget.height, 0, 0.007*widget.height),
                  child: SizedBox(
                    height: 0.1125*widget.height,
                    width: 0.23*widget.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: widget.product.productImage.isEmpty?Image.asset(
                        'assets/images/burger.jpg',
                        fit: BoxFit.cover,
                      ):Image.network(widget.product.productImage),
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
                Expanded(
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0.03*widget.width,0.01*widget.height,0.03*widget.width,0.01*widget.height),
                      child: Column(
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
                              const Stack(
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
                          // Row(
                          //   children: [
                          //     const Icon(
                          //       Icons.currency_rupee,
                          //       size: 15,
                          //     ),
                          //     Text(
                          //       widget.price.toString(),
                          //       style: const TextStyle(
                          //           fontSize: 12, fontWeight: FontWeight.bold),
                          //     ),
                          //     Text((widget.variant.variantName != "Default")
                          //         ? widget.variant.variantName
                          //         : ""),
                          //   ],
                          // ),
                          Text(
                            widget.product.description,
                            style: const TextStyle(fontSize: 10),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0.01*widget.height, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:[
                                SizedBox(
                                  height:0.03875*widget.height,
                                  width:0.130556*widget.width,
                                  child: Card(
                                    color: const Color(0xfff2f1f1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),


                                      ),
                                      child:Padding(
                                        padding: EdgeInsets.fromLTRB(0.01*widget.width, 0, 0, 0),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.currency_rupee,
                                              color:
                                              Color(0xff000000),
                                              size: 12,
                                            ),
                                            Text(
                                              widget.variant.price.toString(),
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                FontWeight.w800,
                                                color:
                                                Color(0xff000000),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 0.069444 * widget.width,
                                      height: 0.03125 * widget.height,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                            const Color(0xFFF2F1F1),
                                            padding: EdgeInsets.zero,
                                            shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),),
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
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0.01*widget.width,0,0.01*widget.width,0),
                                      child: Text(_items().toString()),
                                    ),
                                    SizedBox(
                                      width: 0.069444 * widget.width,
                                      height: 0.03125 * widget.height,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                            const Color(0xFFF2F1F1),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
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

                              ],
                            ),
                          ),
                        ],
                      ),
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
}
