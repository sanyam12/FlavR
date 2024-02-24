import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavr/core/components/heading.dart';
import 'package:flavr/features/orders_list/bloc/orders_list_bloc.dart';
import 'package:flavr/features/orders_list/presentation/widgets/order_details_overlay.dart';
import 'package:flavr/features/outlets_list_page/bloc/outlet_list_bloc.dart';
import 'package:flavr/pages/profile_page/OrderData.dart';
import 'package:flavr/pages/profile_page/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersList extends StatefulWidget {
  const OrdersList({super.key});

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  List<OrderData> list = [];
  String userName = "initial";
  bool isLoading = true;
  String email = "initial";
  String profilePicUrl = "null";

  @override
  void initState() {
    super.initState();
    context.read<OrdersListBloc>().add(GetProfileData());
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: BlocListener<OrdersListBloc, OrdersListState>(
  listener: (context, state) {
    if (state is ShowSnackbar) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(state.messsage)));
    } else if (state is ProfileDataState) {
      setState(() {
        isLoading = false;
        userName = state.userName;
        list = state.list;
        email = state.email;
        profilePicUrl = state.profilePicUrl;
      });
    }
  },
  child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0.0225 * height, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            0.18 * width, 0, 0, 0),
                        child: const Heading(
                          text: "Live Orders",
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.person_2_rounded,
                      color: Color(0xFF004932),
                      size: 32,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  0.05 * width, 0.00875 * height, 0, 0),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Almost there! We're whipping up your favorites",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "with a dash of joy...",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  0.05 * width, 0.00875 * height, 0, 0),
              child: const Text(
                "Pending Order : 5",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    builder: (context) {
                      return const OrderDetailsOverlay();
                    },
                );
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    0.04722 * width, 0.02125 * height, 0, 0),
                child: SizedBox(
                  height: 0.25 * height,
                  width: 0.9027778 * width,
                  child: Card(
                    margin: EdgeInsets.zero,
                    color: const Color(0xff000000),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              0.013889 * width,
                              0.00625 * height,
                              0.013889 * width,
                              0.00625 * height),
                          child: const Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "24 Feb, 2024",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffffffff),
                                ),
                                overflow: TextOverflow.clip,
                              ),
                              Text(
                                "Nescafe NITJ",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffffffff),
                                ),
                              ),
                              Text(
                                "13:40",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffffffff),
                                ),
                                overflow: TextOverflow.clip,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Card(
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(10.0),
                            ),
                            color: const Color(0xffffffff),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                  0.04 * width, 0, 0.04 * width, 0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        0,
                                        0.00625 * height,
                                        0,
                                        0.00625 * height),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          0.02 * width,
                                          0.01 * height,
                                          0.02 * width,
                                          0),
                                      child: const Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Order #",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight:
                                                  FontWeight.w800,
                                                  color: Color(
                                                      0xff000000),
                                                ),
                                              ),
                                              Text(
                                                "52",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  color: Color(
                                                      0xffff0000),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Amount : ",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight:
                                                  FontWeight.w800,
                                                ),
                                              ),
                                              Icon(
                                                Icons.currency_rupee,
                                                color:
                                                Color(0xff000000),
                                                size: 12,
                                              ),
                                              Text(
                                                "150",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  color: Color(
                                                      0xff000000),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                      0,
                                      0.01 * height,
                                      0,
                                      0.00625 * height,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 0.2778 * width,
                                          child: Stack(
                                            children: [
                                              // Padding(
                                              //   padding: EdgeInsets.fromLTRB(
                                              //     0.1112 * width, 0, 0.0556 * width, 0,),
                                              //   child: CircleAvatar(
                                              //     backgroundColor: Colors.white,
                                              //     radius: 32,
                                              //     child: ClipOval(
                                              //       child:
                                              //       Image.network(data.products[2].imageUrl),
                                              //     ),
                                              //   ),
                                              // ),

                                              Padding(
                                                padding: EdgeInsets
                                                    .fromLTRB(
                                                  0.0556 * width,
                                                  0,
                                                  0.0556 * width,
                                                  0,
                                                ),
                                                child:
                                                const CircleAvatar(
                                                  backgroundColor:
                                                  Colors.white,
                                                  radius: 32,
                                                  child: ClipOval(
                                                    child: Image(
                                                      image: AssetImage(
                                                          'assets/images/pasta.jpeg'),
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              const CircleAvatar(
                                                backgroundColor:
                                                Colors.white,
                                                radius: 32,
                                                child: ClipOval(
                                                  child: Image(
                                                    image: AssetImage(
                                                        'assets/images/pasta.jpeg'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                            EdgeInsets.fromLTRB(
                                                0,
                                                0,
                                                0.02 * width,
                                                0),
                                            child: const Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  "Items",
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight:
                                                    FontWeight
                                                        .w900,
                                                    color: Color(
                                                        0xff000000),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "1x Red Sauce Pasta",
                                                      style:
                                                      TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight
                                                            .w700,
                                                        color: Color(
                                                            0xff000000),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .currency_rupee,
                                                          size: 12,
                                                          color: Color(
                                                              0xff004932),
                                                        ),
                                                        Text(
                                                          "150",
                                                          style:
                                                          TextStyle(
                                                            fontSize:
                                                            12,
                                                            fontWeight:
                                                            FontWeight
                                                                .w700,
                                                            color: Color(
                                                                0xff000000),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                //if(data.products.length>=2)
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "1x Veg Cheese Burger",
                                                      style:
                                                      TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight
                                                            .w700,
                                                        color: Color(
                                                            0xff000000),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .currency_rupee,
                                                          size: 12,
                                                          color: Color(
                                                              0xff004932),
                                                        ),
                                                        Text(
                                                          "150",
                                                          style:
                                                          TextStyle(
                                                            fontSize:
                                                            12,
                                                            fontWeight:
                                                            FontWeight
                                                                .w700,
                                                            color: Color(
                                                                0xff000000),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  "+ 2 more items...",
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight:
                                                    FontWeight
                                                        .w600,
                                                    color: Color(
                                                        0xff004932),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        0,
                                        0.01 * height,
                                        0,
                                        0.00625 * height),
                                    child: const Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text(
                                          "Waiting for confirmation...",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight:
                                            FontWeight.bold,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                        Text(
                                          "14:17 PM",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight:
                                            FontWeight.bold,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (var i in list)
                      OrderCard(
                          width: width,
                          height: height,
                          data: i,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
),
      ),
    );
  }
}
