import 'dart:developer';
import 'package:flavr/pages/cart/Cart.dart';
import 'package:flavr/pages/cart/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:lottie/lottie.dart';
import 'package:slider_button/slider_button.dart';

import '../outlet_menu/Product.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool? valuefirst = false;
  final cartBloc = CartBloc();
  Cart cart = Cart();
  List<Product> list = [];
  bool isLoading = true;
  int grandTotal = 0;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    List<Widget> extras = [
      GrandTotal(width: width, height: height, grandTotal: grandTotal,),
      AddMoreItems(width: width, height: height),
      AddOtherInstructions(
        width: width,
        height: height,
        valuefirst: valuefirst,
        onChanged: (value) {
          setState(() {
            valuefirst = value;
          });
        },
      ),
      YourDetails(
        width: width,
        height: height,
      ),
      AddSpecialInstructions(width: width, height: height),
    ];
    List<Widget> children = [];
    for (var i in list) {
      if (cart.items[i.id] != null && cart.items[i.id] != 0) {
        children.add(
          CartItems(
            width: width,
            height: height,
            product: i,
          ),
        );
      }
    }

    children.addAll(extras);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocProvider(
          create: (context) {
            cartBloc.add(GetCart(cart, list));
            return cartBloc;
          },
          child: BlocListener<CartBloc, CartState>(
            listener: (context, state) {
              if (state is RefreshUI) {
                setState(() {
                  isLoading = false;
                  grandTotal = state.grandTotal;
                });
              }
            },
            child: (isLoading)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            0.05 * width, 0, 0.05 * width, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              alignment: Alignment.topLeft,
                              color: Colors.black,
                              icon: const Icon(Icons.arrow_back_ios),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            IconButton(
                              alignment: Alignment.topRight,
                              color: Colors.black,
                              icon: const Icon(Icons.person),
                              onPressed: () {
                                Navigator.pushNamed(context, "/profile");
                              },
                            )
                          ],
                        ),
                      ),
                      const Text(
                        "Cart",
                        style: TextStyle(fontFamily: "inter", fontSize: 25),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: children,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        width: double.infinity,
                        height: 0.10875 * height,
                        child: Card(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 10.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.currency_rupee,
                                          color: Colors.black,
                                          size: 20,
                                        ),
                                        Text(
                                          grandTotal.toString(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: "inter",
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Text(
                                      "Total",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: "inter",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(0.19 * width, 0, 0, 0),
                                child: SliderButton(
                                  backgroundColor: const Color(0xff004932),
                                  action: () {
                                    Navigator.pushNamed(context, "/payment");
                                  },
                                  label: const Text(
                                    "Proceed to pay",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.wallet,
                                    color: Colors.black,
                                  ),
                                  buttonSize: 45,
                                  buttonColor: const Color(0xffD6EAE1),
                                  baseColor: const Color(0xffD6EAE1),
                                  disable: false,
                                  width: 0.55 * width,
                                  height: 0.07 * height,
                                ),
                              ),
                              // ElevatedButton(
                              //     onPressed: () {
                              //       Navigator.pushNamed(context, "/payment");
                              //     },
                              //     child: const Text(
                              //       "Check Out",
                              //     )
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class CartItems extends StatelessWidget {
  const CartItems(
      {super.key,
      required this.width,
      required this.height,
      required this.product});

  final double width;
  final double height;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0.0125 * height, 0, 0),
      // padding: EdgeInsets.symmetric(horizontal: 0.07778 * width),
      child: SizedBox(
        width: 0.888 * width,
        child: Card(
          elevation: 3,
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 0.2861 * width,
                height: 0.1275 * height,
                child: Stack(
                  children: [
                    SizedBox(
                      height: 0.2 * height,
                      width: 0.3 * width,
                      child: const Image(
                        image: AssetImage("assets/images/pizza.jpg"),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.0618 * width, 0, 0, 0),
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
                padding: EdgeInsets.fromLTRB(0.02 * width, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.currency_rupee,
                          size: 15,
                        ),
                        Text(
                          product.price.toString(),
                          style: const TextStyle(fontSize: 12),
                        ),
                        const Text("(Medium)"),
                      ],
                    ),
                    Text(
                      product.description,
                      style: const TextStyle(fontSize: 12),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              )
              // SizedBox(
              //   width: 0.88889 * width,
              //   height: 0.06125 * height,
              //   child: Padding(
              //     padding: EdgeInsets.fromLTRB(
              //         0.0444 * width, 0.02 * height, 0, 0),
              //     child: const Text(
              //       'Your Order',
              //       style: TextStyle(
              //         fontSize: 15,
              //         fontFamily: "inter",
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   width: 0.88889 * width,
              //   child: const Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Stack(
              //         alignment: AlignmentDirectional.center,
              //         children: [
              //           Icon(
              //             Icons.crop_square_sharp,
              //             color: Colors.green,
              //             size: 30,
              //           ),
              //           Icon(
              //             Icons.circle,
              //             color: Colors.green,
              //             size: 10,
              //           ),
              //         ],
              //       ),
              //       Text(
              //         "Shillong Shezwan Maggi",
              //         style: TextStyle(
              //           fontFamily: "inter",
              //           fontWeight: FontWeight.w200,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class GrandTotal extends StatelessWidget {
  const GrandTotal({super.key, required this.width, required this.height, required this.grandTotal});

  final double width;
  final double height;
  final int grandTotal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          0.06 * width, 0.0175 * height, 0.05277 * width, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Grand Total",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
          Row(
            children: [
              const Icon(
                Icons.currency_rupee,
                size: 22,
                color: Color(0xff004932),
              ),
              Text(
                grandTotal.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff004932),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class AddMoreItems extends StatelessWidget {
  const AddMoreItems({super.key, required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.888 * width,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Color(0xffBDBDBC))),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0.025 * width, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Add more items",
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: "inter",
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/outletMenu");
                },
                icon: const Icon(Icons.arrow_forward_ios),
                iconSize: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddOtherInstructions extends StatelessWidget {
  const AddOtherInstructions(
      {super.key,
      required this.width,
      required this.height,
      required this.valuefirst,
      required this.onChanged});

  final double width;
  final double height;
  final bool? valuefirst;
  final void Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.888 * width,
      height: 0.2 * height,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 0.01 * height, 0, 0),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Color(0xffBDBDBC))),
          elevation: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                alignment: AlignmentDirectional.centerStart,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      0.025 * width, 0.01125 * height, 0, 0),
                  child: const Text(
                    "Add Order Instructions",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.027 * width, 0, 0, 0),
                child: Container(
                  alignment: AlignmentDirectional.centerStart,
                  child: SizedBox(
                    width: 0.29444 * width,
                    height: 0.11375 * height,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Color(0xffBDBDBC))),
                      elevation: 3,
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(0, 0.01 * height, 0, 0),
                            child: const Text(
                              "Pack the order",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Icon(Icons.backpack),
                              Checkbox(
                                value: valuefirst,
                                onChanged: (bool? value) {
                                  onChanged(value);
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class YourDetails extends StatelessWidget {
  const YourDetails({super.key, required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.888 * width,
      height: 0.128 * height,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Color(0xffBDBDBC))),
        elevation: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              alignment: AlignmentDirectional.centerStart,
              child: Padding(
                padding:
                    EdgeInsets.fromLTRB(0.033 * width, 0.01125 * height, 0, 0),
                child: const Text(
                  "Your details",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 0.82 * width,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Color(0xffBDBDBC))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0194 * width, 0, 0, 0),
                      child: const Text("akshita , 62849xxxxx"),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/profile");
                        },
                        icon: const Icon(Icons.arrow_forward_ios))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddSpecialInstructions extends StatelessWidget {
  const AddSpecialInstructions(
      {super.key, required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.888 * width,
      height: 0.128 * height,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Color(0xffBDBDBC))),
        elevation: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              alignment: AlignmentDirectional.centerStart,
              child: Padding(
                padding:
                    EdgeInsets.fromLTRB(0.033 * width, 0.01125 * height, 0, 0),
                child: const Text(
                  "Add Special Instructions",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 0.82 * width,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                    color: Color(0xffBDBDBC),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0194 * width, 0, 0, 0),
                      child: SizedBox(
                        height: 0.04625 * height,
                        child: const Center(
                          child: Text("Your instructions"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
