import 'dart:collection';

import 'package:flavr/pages/cart/Cart.dart';
import 'package:flavr/pages/cart/bloc/cart_bloc.dart';
import 'package:flavr/pages/ordernumber/OrderNumber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:slidable_button/slidable_button.dart';

// import 'package:lottie/lottie.dart';
import 'package:slider_button/slider_button.dart';

import '../outlet_menu/Product.dart';
import 'CartVariantData.dart';

class CartPage extends StatefulWidget {
  final Cart initialCart;

  const CartPage({Key? key, required this.initialCart}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool? valuefirst = false;
  final cartBloc = CartBloc();
  List<Product> list = [];
  bool isLoading = true;
  int grandTotal = 0;
  Cart cart = Cart();
  var cfPaymentGatewayService = CFPaymentGatewayService();

  @override
  void initState() {
    super.initState();
    cfPaymentGatewayService.setCallback(verifyPayment, onPaymentError);
  }

  void verifyPayment(String orderId) {
    cartBloc.add(VerifyPayment(orderId));
  }

  void onPaymentError(CFErrorResponse errorResponse, String orderId) {}

  @override
  Widget build(BuildContext context) {
    cart = widget.initialCart;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    List<Widget> extras = [
      GrandTotal(
        width: width,
        height: height,
        grandTotal: grandTotal,
      ),
      AddMoreItems(
        width: width,
        height: height,
        onTap: () {
          Navigator.pop(context, cart);
        },
      ),
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
      AddSpecialInstructions(width: width, height: height),
    ];
    List<Widget> children = [];
    for (var i in list) {
      for (var variant in i.variantList) {
        if (cart.items[i.id] != null &&
            cart.items[i.id]![variant.variantName] != null &&
            cart.items[i.id]![variant.variantName]!.quantity > 0) {
          int price = 0;
          for(var itr in i.variantList){
            if(itr.variantName==variant.variantName){
              price = itr.price;
            }
          }
          children.add(
            CartItems(
              width: width,
              height: height,
              product: i,
              cart: cart,
              bloc: cartBloc,
              variantName: variant.variantName,
              price: price,
              updateParentState: () {
                cartBloc.add(UpdateGrandTotal(cart, list));
              },
            ),
          );
        }
      }
    }

    children.addAll(extras);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, cart);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(45),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            leading: BackButton(
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context, cart);
              },
            ),
            title: const Text(
              "Cart",
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(
                alignment: Alignment.topRight,
                icon: const Icon(
                  Icons.person,
                  size: 30,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/profile");
                },
              )
            ],
          ),
        ),
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
                } else if (state is GrandTotalChanged) {
                  setState(() {
                    grandTotal = state.grandTotal;
                  });
                } else if (state is NavigateToPaymentState) {
                  Navigator.pushNamed(context, "/payment");
                } else if (state is StartCashFreeService) {
                  cfPaymentGatewayService
                      .doPayment(state.cfDropCheckoutPayment);
                } else if (state is ShowSnackbar) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                } else if (state is NavigateToOrderNumber) {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                OrderNumber(orderId: state.orderNumber)));
                    cart.items.clear();
                    isLoading = false;
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
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        0.19 * width, 0, 0, 0),
                                    // child: SliderButton(
                                    //   backgroundColor: const Color(0xff004932),
                                    //   action: () {
                                    //     Navigator.pushNamed(context, "/payment");
                                    //   },
                                    //   label: const Text(
                                    //     "Proceed to pay",
                                    //     style: TextStyle(
                                    //       color: Colors.white,
                                    //       fontSize: 15,
                                    //     ),
                                    //   ),
                                    //   icon: const Icon(
                                    //     Icons.wallet,
                                    //     color: Colors.black,
                                    //   ),
                                    //   buttonSize: 45,
                                    //   dismissible: true,
                                    //   buttonColor: const Color(0xffD6EAE1),
                                    //   baseColor: const Color(0xffD6EAE1),
                                    //   disable: false,
                                    //   width: 0.55 * width,
                                    //   height: 0.07 * height,
                                    // ),
                                    child: SizedBox(
                                      width: 0.55 * width,
                                      height: 0.07 * height,
                                      child: HorizontalSlidableButton(
                                        isRestart: true,
                                        height: 0.07 * height,
                                        buttonWidth: 60,
                                        color: const Color(0xFF004932),
                                        buttonColor: const Color(0xFFD6EAE1),
                                        dismissible: false,
                                        label: const Icon(Icons.wallet),
                                        completeSlideAt: 0.75,
                                        onChanged: (position) {
                                          if (position ==
                                              SlidableButtonPosition.end) {
                                            setState(() {
                                              position =
                                                  SlidableButtonPosition.start;
                                              cartBloc.add(ProceedToPay(cart));
                                              isLoading = true;
                                            });
                                          }
                                        },
                                        child: const Center(
                                          child: Text(
                                            "Proceed to Pay",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
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
      ),
    );
  }
}

class CartItems extends StatefulWidget {
  const CartItems({
    super.key,
    required this.width,
    required this.height,
    required this.product,
    required this.cart,
    required this.bloc,
    required this.variantName,
    required this.price,
    required this.updateParentState,
  });

  final double width;
  final double height;
  final Product product;
  final Cart cart;
  final CartBloc bloc;
  final String variantName;
  final int price;
  final void Function() updateParentState;

  @override
  State<CartItems> createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems> {
  String itemCounter(HashMap<String, CartVariantData> list) {
    int count = 0;
    list.forEach((key, value) {
      count += value.quantity;
    });
    return count.toString();
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
                                      setState(() {
                                        if (widget
                                            .product.variantList.isNotEmpty) {
                                          showBottomSheet(
                                              context: context,
                                              backgroundColor:
                                                  const Color(0xFFA3C2B3),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              builder: (context) {
                                                final List<Widget> list = [];
                                                list.add(ListTile(
                                                  title: Title(
                                                      color: Colors.black,
                                                      child: const Text(
                                                          "Select Items to Remove")),
                                                ));
                                                for (var variant in widget
                                                    .product.variantList) {
                                                  list.add(ListTile(
                                                    title: Text(
                                                        variant.variantName),
                                                    trailing: Text(variant.price
                                                        .toString()),
                                                    onTap: () {
                                                      if (widget.cart
                                                                      .items[
                                                                  widget.product
                                                                      .id] !=
                                                              null &&
                                                          widget.cart.items[
                                                                  widget.product
                                                                      .id]![variant
                                                                  .variantName] !=
                                                              null &&
                                                          widget
                                                                  .cart
                                                                  .items[widget
                                                                      .product
                                                                      .id]![variant.variantName]!
                                                                  .quantity >
                                                              0) {
                                                        widget
                                                            .cart
                                                            .items[widget
                                                                    .product
                                                                    .id]![
                                                                variant
                                                                    .variantName]!
                                                            .quantity--;
                                                      }
                                                      widget.bloc.add(
                                                        UpdateCartEvent(
                                                          widget.product,
                                                          widget.cart,
                                                        ),
                                                      );
                                                      widget
                                                          .updateParentState();
                                                      Navigator.pop(context);
                                                    },
                                                  ));
                                                }
                                                return Wrap(
                                                  children: list,
                                                );
                                              });
                                        } else {
                                          if (widget.cart.items[
                                                      widget.product.id] !=
                                                  null &&
                                              widget.cart.items[widget.product
                                                      .id]!["default"] !=
                                                  null &&
                                              widget
                                                      .cart
                                                      .items[widget.product
                                                          .id]!["default"]!
                                                      .quantity >
                                                  0) {
                                            widget
                                                .cart
                                                .items[widget.product.id]![
                                                    "default"]!
                                                .quantity--;
                                          }
                                          widget.bloc.add(
                                            UpdateCartEvent(
                                              widget.product,
                                              widget.cart,
                                            ),
                                          );
                                          widget.updateParentState();
                                        }
                                      });
                                    },
                                    child: const Icon(
                                      Icons.remove,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Text((widget.cart.items[widget.product.id] ==
                                        null)
                                    ? "0"
                                    : itemCounter(
                                        widget.cart.items[widget.product.id]!)),
                                SizedBox(
                                  width: 0.06777 * widget.width,
                                  height: 0.03125 * widget.height,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFFD6EAE1),
                                        padding: EdgeInsets.zero),
                                    onPressed: () {
                                      setState(() {
                                        if (widget
                                            .product.variantList.isNotEmpty) {
                                          showBottomSheet(
                                              context: context,
                                              backgroundColor:
                                                  const Color(0xFFA3C2B3),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              builder: (context) {
                                                final List<Widget> list = [];
                                                for (var variant in widget
                                                    .product.variantList) {
                                                  list.add(ListTile(
                                                    title: Text(
                                                        variant.variantName),
                                                    trailing: Text(variant.price
                                                        .toString()),
                                                    onTap: () {
                                                      if (widget.cart.items[
                                                              widget.product
                                                                  .id] !=
                                                          null) {
                                                        if (widget.cart.items[
                                                                widget.product
                                                                    .id]![variant
                                                                .variantName] !=
                                                            null) {
                                                          widget
                                                              .cart
                                                              .items[widget
                                                                      .product
                                                                      .id]![
                                                                  variant
                                                                      .variantName]!
                                                              .quantity++;
                                                        } else {
                                                          widget.cart.items[
                                                                  widget.product
                                                                      .id]![variant
                                                                  .variantName] =
                                                              CartVariantData(
                                                                  variant
                                                                      .variantName,
                                                                  1);
                                                        }
                                                      } else {
                                                        final temp = HashMap<
                                                            String,
                                                            CartVariantData>();
                                                        temp[variant
                                                                .variantName] =
                                                            CartVariantData(
                                                                variant
                                                                    .variantName,
                                                                1);
                                                        widget.cart.items[widget
                                                            .product.id] = temp;
                                                      }
                                                      widget.bloc.add(
                                                        UpdateCartEvent(
                                                          widget.product,
                                                          widget.cart,
                                                        ),
                                                      );
                                                      widget
                                                          .updateParentState();
                                                      Navigator.pop(context);
                                                    },
                                                  ));
                                                }
                                                return Wrap(
                                                  children: list,
                                                );
                                              });
                                        } else {
                                          if (widget.cart
                                                  .items[widget.product.id] !=
                                              null) {
                                            if (widget.cart.items[widget
                                                    .product.id]!["default"] !=
                                                null) {
                                              widget
                                                  .cart
                                                  .items[widget.product.id]![
                                                      "default"]!
                                                  .quantity++;
                                            } else {
                                              widget.cart.items[widget
                                                      .product.id]!["default"] =
                                                  CartVariantData("default", 1);
                                            }
                                          } else {
                                            final temp = HashMap<String,
                                                CartVariantData>();
                                            temp["default"] =
                                                CartVariantData("default", 1);
                                            widget.cart
                                                    .items[widget.product.id] =
                                                temp;
                                          }
                                          widget.bloc.add(
                                            UpdateCartEvent(
                                              widget.product,
                                              widget.cart,
                                            ),
                                          );
                                          widget.updateParentState();
                                        }
                                      });
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
                          widget.price.toString(),
                          style: const TextStyle(fontSize: 12),
                        ),
                        Text(widget.variantName),
                      ],
                    ),
                    Text(
                      widget.product.description,
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
  const GrandTotal(
      {super.key,
      required this.width,
      required this.height,
      required this.grandTotal});

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
  const AddMoreItems(
      {super.key,
      required this.width,
      required this.height,
      required this.onTap});

  final double width;
  final double height;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
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
