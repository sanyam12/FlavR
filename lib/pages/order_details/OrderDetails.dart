
import 'dart:developer';

import 'package:flavr/pages/order_details/order_details_bloc.dart';
import 'package:flavr/pages/profile_page/OrderProductData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../profile_page/OrderData.dart';

class OrderDetails extends StatefulWidget {
  final OrderData orderData;

  const OrderDetails({super.key, required this.orderData});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final bloc = OrderDetailsBloc();

  Widget _getOutletImage() {
    //TODO: Get Outlet ID in order
    return const Placeholder();
  }

  String _formatDate(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd MMM, yyyy');
    return formatter.format(dateTime);
  }

  String _formatTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('hh:mm a');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    for (var i in widget.orderData.products) {
      log("${i.productName}: ${i.variant} ${i.price}");
    }
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => OrderDetailsBloc(),
      child: BlocListener<OrderDetailsBloc, OrderDetailsState>(
        listener: (context, state) {
          if (state is ShowSnackbar) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is OrderDataState) {
            log(state.outletName);
            log(state.outletAddress);
            log(state.imageUrl);
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Center(
              //TODO: Add Single Child Scroll View
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 0.285 * height,
                        child: _getOutletImage(),
                      ),
                      Stack(
                        children: [
                          RawMaterialButton(
                            onPressed: () {},
                            elevation: 5.0,
                            child: Icon(
                              Icons.circle,
                              size: 0.09722 * width,
                              color: const Color(0xff004932),
                              shadows: const <Shadow>[
                                Shadow(
                                  color: Colors.white,
                                  blurRadius: 7.0,
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const BackButton(),
                            iconSize: 0.030625 * height,
                            color: const Color(0xffffffff),
                            padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                0.29722 * width, 0.26125 * height, 0, 0),
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: 0.04375 * height,
                                  width: 0.416667 * width,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    color: const Color(0xffffffff),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          0.09722 * width,
                                          0.004 * height,
                                          0,
                                          0),
                                      child: Text(
                                        'Nescafe',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          fontFamily: GoogleFonts.poppins().fontFamily
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.150556 * width, 0, 0, 0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 0.025 * height,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.fromLTRB(0.013889 * width, 0, 0, 0),
                          child: Text(
                            'Nit Jalandhar, Grand trunk road, Barnala-Amritsar Bypass',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff000000),
                              fontSize: 10,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          0.0378 * width, 0.0125 * height, 0, 0),
                      child: Column(
                        children: [
                          Text(
                            'Date : ${_formatDate(widget.orderData.createdAt)}',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff000000),
                              fontFamily: GoogleFonts.poppins().fontFamily,
                            ),
                          ),
                          Text(
                            'Order Placed : ${_formatTime(widget.orderData.createdAt)}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff000000),
                              fontFamily: GoogleFonts.poppins().fontFamily,
                            ),
                          ),
                          Text(
                            'Last Updated : ${_formatTime(widget.orderData.updatedAt)}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff000000),
                              fontFamily: GoogleFonts.poppins().fontFamily,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(0, 0.025 * height, 0, 0),
                            child: SizedBox(
                              height: 0.4875 * height,
                              child: Column(
                                children: [
                                  for (var i in widget.orderData.products)
                                    ItemCard(
                                      width: width,
                                      height: height,
                                      data: i,
                                    )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.075 * height,
                    width: 0.833 * width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff004932),
                      ),
                      onPressed: () => {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Implementation Pending"),
                          ),
                        )
                      },
                      child: Text(
                        'Re Order',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          backgroundColor: Color(0xff004932),
                          color: Color(0xffffffff),
                          fontFamily: GoogleFonts.poppins().fontFamily,
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
    );
  }
}

class ItemCard extends StatelessWidget {
  final double width;
  final double height;
  final OrderProductData data;

  const ItemCard({
    super.key,
    required this.width,
    required this.height,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.8889 * width,
      height: 0.1575 * height,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: const Color(0xffffffff),
        elevation: 3,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 0.1125 * height,
                height: 0.1125 * height,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(data.imageUrl),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.fromLTRB(0.15 * width, 0.03625 * height, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            Icons.crop_square_sharp,
                            color: Colors.green,
                            size: 0.025 * height,
                          ),
                          Icon(Icons.circle,
                              color: Colors.green, size: 0.02160556 * width),
                        ],
                      ),
                      Text(
                        data.productName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff000000),
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.currency_rupee,
                        color: const Color(0xff004932),
                        size: 0.041667 * width,
                      ),
                      Text(
                        data.price.toString(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff004932),
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                      Text(
                        data.variant,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff000000),
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      )
                    ],
                  ),
                  Text(
                    data.description,
                    style: TextStyle(
                      color: Color(0xff8A8888),
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
