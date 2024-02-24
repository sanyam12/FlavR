import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavr/core/components/loading.dart';
import 'package:flavr/pages/profile_page/order_card.dart';
import 'package:flavr/pages/profile_page/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/components/heading.dart';
import 'OrderData.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = "initial";
  bool isLoading = true;
  String email = "initial";
  String profilePicUrl = "null";
  List<OrderData> list = [];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final bloc = ProfileBloc();

    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) {
            bloc.add(GetProfileData());
            return bloc;
          },
          child: BlocListener<ProfileBloc, ProfileState>(
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
            child: (isLoading)
                ? const Center(
                    child: CustomLoadingAnimation(),
                  )
                : Column(
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
                                return Container(
                                  height: 0.875 * height,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 9.0,
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: const CircleAvatar(
                                            backgroundColor: Color(0xFFF2F1F1),
                                            child: Icon(
                                              Icons.close,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(20.0)),
                                          ),
                                          child: Column(
                                            children: [
                                              SingleChildScrollView(
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0.07 * width,
                                                      0,
                                                      0.07 * width,
                                                      0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0,
                                                                0.03125 *
                                                                    height,
                                                                0,
                                                                0),
                                                        child: Container(
                                                          height:
                                                              0.23625 * height,
                                                          width: 0.98 * width,
                                                          color:
                                                              Color(0x00000000),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child: Image.asset(
                                                              'assets/images/discount.webp',
                                                              //width:0.96*width,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0,
                                                                0.02 * height,
                                                                0,
                                                                0),
                                                        child: const Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Nescafe NITJ",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color(
                                                                    0xff000000),
                                                              ),
                                                            ),
                                                            Text(
                                                              "24 Feb, 2024",
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                color: Color(
                                                                    0xff000000),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0,
                                                                0.007 * height,
                                                                0,
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
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                    color: Color(
                                                                        0xff000000),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  "52",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                    color: Color(
                                                                        0xffff3c3c),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Text(
                                                              "06:53",
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                color: Color(
                                                                    0xff000000),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0,
                                                                0.02 * height,
                                                                0,
                                                                0),
                                                        child: const Text(
                                                          "Items",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Color(
                                                                0xff000000),
                                                          ),
                                                        ),
                                                      ),
                                                      const Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "1x Red Sauce Pasta (Small)",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Color(
                                                                  0xff000000),
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .currency_rupee,
                                                                color: Color(
                                                                    0xff000000),
                                                                size: 12,
                                                              ),
                                                              Text(
                                                                "150",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Color(
                                                                      0xff000000),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      const Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "1x Veg Cheese Burger",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Color(
                                                                  0xff000000),
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .currency_rupee,
                                                                color: Color(
                                                                    0xff000000),
                                                                size: 12,
                                                              ),
                                                              Text(
                                                                "150",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Color(
                                                                      0xff000000),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      const Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "1x Red Sauce Pasta (Small)",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Color(
                                                                  0xff000000),
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .currency_rupee,
                                                                color: Color(
                                                                    0xff000000),
                                                                size: 12,
                                                              ),
                                                              Text(
                                                                "150",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Color(
                                                                      0xff000000),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      const Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "1x Veg Cheese Burger",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Color(
                                                                  0xff000000),
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .currency_rupee,
                                                                color: Color(
                                                                    0xff000000),
                                                                size: 12,
                                                              ),
                                                              Text(
                                                                "150",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Color(
                                                                      0xff000000),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0,
                                                                0.02 * height,
                                                                0,
                                                                0),
                                                        child: const Text(
                                                          "Breakdown",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Color(
                                                                0xff000000),
                                                          ),
                                                        ),
                                                      ),
                                                      const Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Total Bill",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Color(
                                                                  0xff000000),
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .currency_rupee,
                                                                color: Color(
                                                                    0xff000000),
                                                                size: 12,
                                                              ),
                                                              Text(
                                                                "600",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Color(
                                                                      0xff000000),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      const Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "SGST (9%)",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Color(
                                                                  0xff000000),
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .currency_rupee,
                                                                color: Color(
                                                                    0xff000000),
                                                                size: 12,
                                                              ),
                                                              Text(
                                                                "54",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Color(
                                                                      0xff000000),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      const Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "CGST",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Color(
                                                                  0xff000000),
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .currency_rupee,
                                                                color: Color(
                                                                    0xff000000),
                                                                size: 12,
                                                              ),
                                                              Text(
                                                                "54",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Color(
                                                                      0xff000000),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      const Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Total Amount",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Color(
                                                                  0xff000000),
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .currency_rupee,
                                                                color: Color(
                                                                    0xff000000),
                                                                size: 12,
                                                              ),
                                                              Text(
                                                                "708",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Color(
                                                                      0xff000000),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0,
                                                                0.02 * height,
                                                                0,
                                                                0),
                                                        child: const Text(
                                                          "Instructions",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Color(
                                                                0xff000000),
                                                          ),
                                                        ),
                                                      ),
                                                      const Text(
                                                        "Please add extra cheese in burger",
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xff000000),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0,
                                                                0.02 * height,
                                                                0,
                                                                0),
                                                        child: const Text(
                                                          "Payment Details",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Color(
                                                                0xff000000),
                                                          ),
                                                        ),
                                                      ),
                                                      const Text(
                                                        "Method : UPI",
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xff000000),
                                                        ),
                                                      ),
                                                      const Text(
                                                        "Provider : CRED",
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xff000000),
                                                        ),
                                                      ),
                                                      const Text(
                                                        "Transaction ID: #324721340912831",
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xff000000),
                                                        ),
                                                      ),
                                                      const Text(
                                                        "Time : 24 Feb, 2024 17:34PM",
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xff000000),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0,
                                                                0.02 * height,
                                                                0,
                                                                0.02 * height),
                                                        child: SizedBox(
                                                          width:
                                                              0.902778 * width,
                                                          height: 0.05 * height,
                                                          child: ElevatedButton(
                                                            onPressed: () {},
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  Color(
                                                                      0xff000000),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                      //to set border radius to button
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                            ),
                                                            child: const Text(
                                                              'Download Invoice',
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xffffffff),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
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
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
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
                                    data: i),
                            ],
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.of(context).pushNamedAndRemoveUntil("/signInWithGoogle", (route) => false);
                        },
                        child: const Text(
                          "Log Out",
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

// class OrderCard extends StatelessWidget {
//   const OrderCard(
//       {super.key,
//       required this.width,
//       required this.height,
//       required this.orderData});
//
//   final double width;
//   final double height;
//   final OrderData orderData;
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => OrderDetails(
//                       orderId: orderData.id,
//                     )));
//       },
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 0.02278 * width),
//         child: SizedBox(
//           width: width,
//           height: 0.13625 * height,
//           child: Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     "Red Sauce Pasta",
//                   ),
//                   Card(
//                     child: Container(
//                       alignment: AlignmentDirectional.center,
//                       width: 0.24166 * width,
//                       height: 0.06625 * height,
//                       child: const Text("₹100"),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
