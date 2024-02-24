import 'dart:collection';
import 'dart:developer';

import 'package:flavr/core/CartChangeProvider.dart';
import 'package:flavr/core/components/loading.dart';
import 'package:flavr/features/outlet_menu/bloc/outlet_menu_bloc.dart';
import 'package:flavr/features/outlet_menu/data/models/ProductVariantData.dart';
import 'package:flavr/features/cart/data/models/Cart.dart';
import 'package:flavr/features/cart/bloc/cart_bloc.dart';
import 'package:flavr/pages/ordernumber/OrderNumber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:slidable_button/slidable_button.dart';

// import 'package:lottie/lottie.dart';
import 'package:slider_button/slider_button.dart';

import '../../../../core/components/heading.dart';
import '../../../outlet_menu/data/models/Categories.dart';
import '../../../outlet_menu/data/models/Product.dart';
import '../../data/models/CartVariantData.dart';
import '../widgets/add_more_items.dart';
import '../widgets/cart_items.dart';
import '../widgets/grand_total.dart';

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
  var cfPaymentGatewayService = CFPaymentGatewayService();

  @override
  void initState() {
    super.initState();
    cfPaymentGatewayService.setCallback(verifyPayment, onPaymentError);
    cart = context.read<CartChangeProvider>().cart;
    context.read<CartBloc>().add(UpdateGrandTotal(cart, list));
  }

  void verifyPayment(String orderId) {
    context.read<CartBloc>().add(VerifyPayment(orderId));
  }

  void onPaymentError(CFErrorResponse errorResponse, String orderId) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
        SnackBar(
            content: Text("payment failed ${errorResponse.toString()}"),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
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
              } else if(state is StartCashFreeService){
                cfPaymentGatewayService.doPayment(state.cfDropCheckoutPayment);
              }
            },
            builder: (context, state) {
              if (state is CartLoading) {
                return const Center(
                  child: CustomLoadingAnimation(),
                );
              }
              // if(isLoading){
              //   return const Center(
              //     child: CustomLoadingAnimation(),
              //   );
              // }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0.06*width,0,0.04*width,0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Check your picks, settle the bill, and we'll whip up",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            const Text(
                              "your order in no time!",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
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
                                      context
                                          .read<CartBloc>()
                                          .add(ProceedToPay(cart));
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
        title:Heading(
          text:"Cart",
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
