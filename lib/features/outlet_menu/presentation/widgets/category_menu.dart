import 'dart:collection';
import 'dart:developer';

import 'package:flavr/features/outlet_menu/bloc/outlet_menu_bloc.dart';
import 'package:flavr/features/outlet_menu/data/models/ProductVariantData.dart';
import 'package:flavr/features/cart/Cart.dart';
import 'package:flavr/features/cart/CartVariantData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/Categories.dart';
import '../../data/models/Product.dart';

class CategoryMenu extends StatefulWidget {
  const CategoryMenu({
    super.key,
    required this.width,
    required this.height,
    required this.list,
    required this.cart,
    // required this.productList,
    // required this.updateParentState,
    required this.amount,
  });

  final double width;
  final double height;
  final List<Categories> list;
  final Cart cart;

  // final List<Product> productList;
  // final void Function() updateParentState;
  final int amount;

  @override
  State<CategoryMenu> createState() => _CategoryMenuState();
}

class _CategoryMenuState extends State<CategoryMenu> {
  // String itemCounter(HashMap<String, CartVariantData> list) {
  //   int count = 0;
  //   list.forEach((key, value) {
  //     count += value.quantity;
  //   });
  //   return count.toString();
  // }

  int _calculateTotalProductItems(Product product){
    int count = 0;
    for(var i in widget.cart.items[product] ??<CartVariantData>[]){
      count+=i.quantity;
    }
    return count;
  }

  _incrementAmount(Product j) {
    if (j.variantList.isEmpty) {
      context.read<OutletMenuBloc>().add(
            IncrementAmount(
              j,
              widget.cart,
              ProductVariantData(
                "default",
                j.price,
              ),
            ),
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
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    bool check = (widget.list.length > 1);
    for (var i in widget.list) {
      if (check && i.category != "All") {
        children.add(
          Row(
            children: [
              Text(
                i.category,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        );
      }
      for (var j in i.products) {
        children.add(
          SizedBox(
            width: 0.8888 * widget.width,
            height: 0.1575 * widget.height,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  width: 0.8888 * widget.width,
                  height: 0.1575 * widget.height,
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
                                      child: (j.productImage != "null")
                                          ? Image.network(j.productImage)
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
                                                _decrementAmount(j);
                                              },
                                              child: const Icon(
                                                Icons.remove,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Text(_calculateTotalProductItems(j)
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
                                                _incrementAmount(j);
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
                          padding: EdgeInsets.fromLTRB(
                              0.0611 * widget.width, 0, 0, 0),
                          child: SizedBox(
                            // width: 0.46 * widget.width,
                            height: 0.08625 * widget.height,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    j.veg
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
                                        j.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
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
                                        "₹${j.price}",
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
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
                                        j.description,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.grey,
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
          ),
        );
      }
    }

    return Column(
      children: children,
    );
  }
}
