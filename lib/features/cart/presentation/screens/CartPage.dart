import 'package:flavr/core/CartChangeProvider.dart';
import 'package:flavr/core/components/loading.dart';
import 'package:flavr/features/cart/data/models/Cart.dart';
import 'package:flavr/features/cart/bloc/cart_bloc.dart';
import 'package:flavr/pages/ordernumber/OrderNumber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../outlet_menu/data/models/Categories.dart';
import '../../../outlet_menu/data/models/Product.dart';
import '../widgets/cart_items.dart';

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
  final instructionController = TextEditingController();
  final couponController = TextEditingController();

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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text("payment failed ${errorResponse.getMessage().toString()}"),
      ),
    );
  }

  int _totalAmount() {
    int total = 0;
    for (var i in cart.items.entries) {
      for (var j in i.value) {
        total += j.quantity * j.price;
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(0,0,0,0.005*height),
        child: SafeArea(
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
              } else if (state is StartCashFreeService) {
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding:
                            EdgeInsets.fromLTRB(0.06 * width, 0, 0.04 * width, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Check your picks, settle the bill, and we'll whip up",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            const Text(
                              "your order in no time!",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
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
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(0, 0.02 * height, 0, 0),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Coupon",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                  Text(
                                    "Got a magic code? Unvell its power here!",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      0, 0.015 * height, 0, 0),
                                  child: SizedBox(
                                    width: 0.563889 * width,
                                    child: TextFormField(
                                      controller: couponController,
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: "Enter coupon code",
                                        hintStyle: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),
                                      obscureText: false,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 0.05125 * height,
                                  width: 0.280556 * width,
                                  child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xff000000),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),
                                      child: const Text(
                                        "Apply",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 14,
                                          color: Color(0xffffffff),
                                        ),
                                      )),
                                )
                              ],
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(0, 0.02 * height, 0, 0),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Special Instructions",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                  Text(
                                    "Jot down your flavr wishes in the box below!",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(0, 0.015 * height, 0, 0),
                              child: SizedBox(
                                width: 0.875 * width,
                                child: TextFormField(
                                  controller: instructionController,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText:
                                        "Enter specific instructions here...",
                                    hintStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  obscureText: false,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(0, 0.02 * height, 0, 0),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Price Breakdown",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                  Text(
                                    "Here's a complete breakdown of your bill",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Total Bill",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.currency_rupee,
                                          color: Color(0xff000000),
                                          size: 12,
                                        ),
                                        Text(
                                          _totalAmount().toInt().toString(),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "SGST (5%)",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.currency_rupee,
                                          color: Color(0xff000000),
                                          size: 12,
                                        ),
                                        Text(
                                          (_totalAmount() * 0.05)
                                              .toInt()
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "CGST (5%)",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.currency_rupee,
                                          color: Color(0xff000000),
                                          size: 12,
                                        ),
                                        Text(
                                          (_totalAmount() * 0.05)
                                              .toInt()
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Total Amount",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.currency_rupee,
                                          color: Color(0xff000000),
                                          size: 12,
                                        ),
                                        Text(
                                          (_totalAmount() * 1.1)
                                              .toInt()
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // GrandTotal(
                            //   width: width,
                            //   height: height,
                            //   grandTotal: grandTotal,
                            // ),
                            // AddMoreItems(
                            //   width: width,
                            //   height: height,
                            //   onTap: () {
                            //     Navigator.pop(context, cart);
                            //   },
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: (_totalAmount() * 1.1).toInt() != 0 ,
                    child: SizedBox(
                      height: 0.0675 * height,
                      width: 0.90833 * width,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<CartBloc>().add(
                                ProceedToPay(
                                  cart,
                                  instructionController.text,
                                ),
                              );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff000000),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Pay Now",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: Color(0xffffffff),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "24min ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.currency_rupee,
                                      color: Color(0xffffffff),
                                      size: 15,
                                    ),
                                    Text(
                                      (_totalAmount() * 1.1).toInt().toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xffffffff),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   alignment: Alignment.bottomCenter,
                  //   width: double.infinity,
                  //   height: 0.10875 * height,
                  //   child: Card(
                  //     child: Row(
                  //       children: [
                  //         Padding(
                  //           padding: const EdgeInsets.symmetric(
                  //               vertical: 15.0, horizontal: 10.0),
                  //           child: Column(
                  //             children: [
                  //               Row(
                  //                 children: [
                  //                   const Icon(
                  //                     Icons.currency_rupee,
                  //                     color: Colors.black,
                  //                     size: 20,
                  //                   ),
                  //                   Text(
                  //                     grandTotal.toString(),
                  //                     style: const TextStyle(
                  //                       color: Colors.black,
                  //                       fontFamily: "inter",
                  //                       fontSize: 20,
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //               const Text(
                  //                 "Total",
                  //                 style: TextStyle(
                  //                   color: Colors.black,
                  //                   fontSize: 16,
                  //                   fontFamily: "inter",
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //         Expanded(
                  //           child: Padding(
                  //             padding: EdgeInsets.fromLTRB(
                  //               0.19 * width,
                  //               0,
                  //               0,
                  //               0,
                  //             ),
                  //             child: SizedBox(
                  //               width: 0.55 * width,
                  //               height: 0.07 * height,
                  //               child: HorizontalSlidableButton(
                  //                 isRestart: true,
                  //                 height: 0.07 * height,
                  //                 buttonWidth: 60,
                  //                 color: const Color(0xFF004932),
                  //                 buttonColor: const Color(0xFFD6EAE1),
                  //                 dismissible: false,
                  //                 label: const Icon(Icons.wallet),
                  //                 completeSlideAt: 0.75,
                  //                 onChanged: (position) {
                  //                   if (position ==
                  //                       SlidableButtonPosition.end) {
                  //                     context
                  //                         .read<CartBloc>()
                  //                         .add(ProceedToPay(cart));
                  //                     // setState(() {
                  //                     //   position =
                  //                     //       SlidableButtonPosition.start;
                  //                     //   // cartBloc.add(ProceedToPay(cart));
                  //                     //   isLoading = true;
                  //                     // });
                  //                   }
                  //                 },
                  //                 child: Container(
                  //                   alignment: Alignment.centerLeft,
                  //                   child: const Padding(
                  //                     padding: EdgeInsets.fromLTRB(
                  //                       63,
                  //                       0,
                  //                       0,
                  //                       0,
                  //                     ),
                  //                     child: Text(
                  //                       "Swipe to Pay",
                  //                       style: TextStyle(
                  //                           color: Colors.white,
                  //                           fontSize: 18,
                  //                           fontWeight: FontWeight.bold),
                  //                       textAlign: TextAlign.center,
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
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
        title: Text(
          "Cart",
          style: TextStyle(
            color: Colors.black,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
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
