import 'dart:collection';
import 'dart:developer';

import 'package:flavr/core/CartChangeProvider.dart';
import 'package:flavr/features/outlet_menu/data/models/ProductVariantData.dart';
import 'package:flavr/features/cart/Cart.dart';
import 'package:flavr/features/cart/bloc/cart_bloc.dart';
import 'package:flavr/pages/ordernumber/OrderNumber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:slidable_button/slidable_button.dart';

// import 'package:lottie/lottie.dart';
import 'package:slider_button/slider_button.dart';

import '../../components/loading.dart';
import '../../features/outlet_menu/data/models/Categories.dart';
import '../../features/outlet_menu/data/models/Product.dart';
import 'CartVariantData.dart';

class CartPage extends StatefulWidget {
  // final Cart initialCart;
  final List<Categories> list;

  const CartPage({Key? key, required this.list}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool? valuefirst = false;
  List<Product> list = [];
  bool isLoading = true;
  int grandTotal = 0;
  late Cart cart;

  @override
  void initState() {
    super.initState();
    cart = context.read<CartChangeProvider>().cart;
    context.read<CartBloc>().add(UpdateGrandTotal(cart, list));
  }

  void onPaymentError(CFErrorResponse errorResponse, String orderId) {}

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: SafeArea(
          child: BlocConsumer<CartBloc, CartState>(
            listener: (context, state) {
              if (state is GrandTotalChanged) {
                grandTotal = state.grandTotal;
              } else if (state is NavigateToPaymentState) {
                Navigator.pushNamed(context, "/payment");
              } else if (state is ShowSnackbar) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              } else if (state is NavigateToOrderNumber) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderNumber(
                      orderId: state.orderNumber,
                    ),
                  ),
                );
                cart.items.clear();
              }
            },
            builder: (context, state) {
              // if(isLoading){
              //   return const Center(
              //     child: CustomLoadingAnimation(),
              //   );
              // }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          for (var i in cart.items.entries)
                            for (var j in i.value)
                              if (j.quantity != 0)
                                CartItems(
                                  width: width,
                                  height: height,
                                  product: i.key,
                                  cart: cart,
                                  variant: j,
                                  price: j.price,
                                  list: list,
                                ),
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
                        ],
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
                                0.19 * width,
                                0,
                                0,
                                0,
                              ),
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
                                      // setState(() {
                                      //   position =
                                      //       SlidableButtonPosition.start;
                                      //   // cartBloc.add(ProceedToPay(cart));
                                      //   isLoading = true;
                                      // });
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: const Padding(
                                      padding: EdgeInsets.fromLTRB(
                                        63,
                                        0,
                                        0,
                                        0,
                                      ),
                                      child: Text(
                                        "Swipe to Pay",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  _buildAppBar() {
    return PreferredSize(
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
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Text((widget.variant.variantName != "Default")
                            ? widget.variant.variantName
                            : ""),
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
