import 'package:flutter/material.dart';

class OrderDetailsOverlay extends StatefulWidget {
  const OrderDetailsOverlay({super.key});

  @override
  State<OrderDetailsOverlay> createState() => _OrderDetailsOverlayState();
}

class _OrderDetailsOverlayState extends State<OrderDetailsOverlay> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
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
  }
}
