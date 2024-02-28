import 'dart:developer';

import 'package:flavr/features/orders_list/presentation/widgets/order_details_overlay.dart';
import 'package:flavr/pages/order_details/OrderDetails.dart';
import 'package:flavr/pages/profile_page/OrderData.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatelessWidget {
  final double width;
  final double height;
  final OrderData data;

  const OrderCard(
      {super.key,
      required this.width,
      required this.height,
      required this.data});

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
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: width * 0.886111,
          color: Colors.black,
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) {
                  return OrderDetailsOverlay(data:data);
                },
              );
            },
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0.013889 * width,
                      0.00625 * height, 0.013889 * width, 0.00625 * height),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDate(data.createdAt),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                        overflow: TextOverflow.clip,
                      ),
                      Text(
                        //TODO: Outlet name
                        "data.outlet",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                      Text(
                        _formatTime(data.createdAt),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                        overflow: TextOverflow.clip,
                      ),
                    ],
                  ),
                ),
                Card(
                  margin: EdgeInsets.zero,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            0.013889 * width,
                            0.00625 * height,
                            0.013889 * width,
                            0.00625 * height),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Order #",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff000000),
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                  ),
                                ),
                                Text(
                                  data.orderNumber?.toString() ?? "NA",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xffff0000),
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.currency_rupee,
                                  color: Color(0xff004932),
                                  size: 16,
                                ),
                                Text(
                                  data.totalPrice.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff000000),
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          0.013889 * width,
                          0.00625 * height,
                          0.013889 * width,
                          0.00625 * height,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(
                              children: [
                                if (data.products.length >= 3)
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                      0.1112 * width,
                                      0,
                                      0.0556 * width,
                                      0,
                                    ),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 32,
                                      child: ClipOval(
                                        child: Image.network(
                                            data.products[2].imageUrl),
                                      ),
                                    ),
                                  ),
                                if (data.products.length >= 2)
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                      0.0556 * width,
                                      0,
                                      0.0556 * width,
                                      0,
                                    ),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 32,
                                      child: ClipOval(
                                        child: Image.network(
                                            data.products[1].imageUrl),
                                      ),
                                    ),
                                  ),
                                if (data.products.isNotEmpty)
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 32,
                                    child: ClipOval(
                                      child: Image.network(
                                        data.products[0].imageUrl,
                                      ),
                                    ),
                                  )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (data.products.isNotEmpty)
                                  Text(
                                    "${data.products[0].quantity} x ${data.products[0].productName}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xff000000),
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily,
                                    ),
                                  ),
                                if (data.products.length >= 2)
                                  Text(
                                    "${data.products[1].quantity} x ${data.products[1].productName}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff000000),
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily,
                                    ),
                                  ),
                                // if(data.products.length>=3)
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (data.products.isNotEmpty)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Icon(
                                        Icons.currency_rupee,
                                        size: 12,
                                        color: Color(0xff004932),
                                      ),
                                      Text(
                                        "${data.products[0].price}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff000000),
                                          fontFamily:
                                              GoogleFonts.poppins().fontFamily,
                                        ),
                                      ),
                                    ],
                                  ),
                                if (data.products.length >= 2)
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.currency_rupee,
                                        size: 12,
                                        color: Color(0xff004932),
                                      ),
                                      Text(
                                        "${data.products[1].price}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff000000),
                                          fontFamily:
                                              GoogleFonts.poppins().fontFamily,
                                        ),
                                      ),
                                    ],
                                  ),
                                if (data.products.length >= 3)
                                  Text(
                                    "And More...",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff000000),
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily,
                                    ),
                                  )
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            0.013889 * width,
                            0.00625 * height,
                            0.013889 * width,
                            0.00625 * height),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data.status,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff004932),
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                            Text(
                              _formatTime(data.createdAt),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff004932),
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                          ],
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
    );
  }
}
