import 'dart:developer';

import 'package:flavr/pages/order_details/OrderDetails.dart';
import 'package:flavr/pages/profile_page/OrderData.dart';
import 'package:flutter/material.dart';
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
      child: Container(
        width: width * 0.886111,
        color: const Color(0xffffffff),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderDetails(orderData: data),
              ),
            );
          },
          child: SizedBox(
            height: 0.25*height,
            width: 0.9027778*width,
            child: Card(
              color: const Color(0xff000000),
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.013889 * width, 0.00625 * height,
                        0.013889 * width, 0.00625 * height),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatDate(data.createdAt),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffffffff),
                          ),
                          overflow: TextOverflow.clip,
                        ),
                        const Text(
                          //TODO: Outlet name
                          "data.outlet",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffffffff),
                          ),
                        ),
                        Text(
                          _formatTime(data.createdAt),
                          style: const TextStyle(
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),),
                      color: const Color(0xffffffff),
                      child: Column(
                        children:[
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.013889 * width, 0.00625 * height,
                              0.013889 * width, 0.00625 * height),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Order #",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                  Text(
                                    data.orderNumber?.toString() ?? "NA",
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffff0000),
                                    ),
                                  ),
                                ],
                              ),
                              Row(

                                children: [
                                  const Text(
                                    "Amount : ",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.currency_rupee,
                                    color: Color(0xff000000),
                                    size: 12,
                                  ),
                                  Text(
                                    data.totalPrice.toString(),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff000000),
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
                                if(data.products.length>=3)
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                      0.1112 * width, 0, 0.0556 * width, 0,),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 32,
                                      child: ClipOval(
                                        child:
                                        Image.network(data.products[2].imageUrl),
                                      ),
                                    ),
                                  ),
                                if(data.products.length>=2)
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          0.0556 * width, 0, 0.0556 * width, 0,),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 32,
                                        child: ClipOval(
                                            child:
                                                Image.network(data.products[1].imageUrl),
                                        ),
                                      ),
                                  ),
                                if(data.products.isNotEmpty)
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
                                const Text(
                                  "Items",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff000000),
                                  ),
                                ),
                                if(data.products.isNotEmpty)
                                  Row(
                                    children: [
                                      Text(
                                        "${data.products[0].quantity} x ${data.products[0].productName}",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.currency_rupee,
                                            size: 11,
                                            color: Color(0xff00000000),
                                          ),

                                      Text(
                                        "${data.products[0].price}",
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff000000),
                                        ),
                                        ),
                                        ],
                                      ),
                                    ],
                                  ),
                                if(data.products.length>=2)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${data.products[1].quantity} x ${data.products[1].productName}",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff000000),
                                        ),
                                      ),

                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.currency_rupee,
                                              size: 11,
                                              color: Color(0xff00000000),
                                            ),


                                        Text(
                                          "${data.products[0].price}",
                                          style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff000000),
                                          ),
                                        ),],),
                                    ],
                                  ),
                                const Text(
                                  "+ 2 more items...",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0x00004932),
                                  ),
                                )
                                // if(data.products.length>=3)

                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if(data.products.isNotEmpty)
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
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                    ],
                                  ),
                                if(data.products.length>=2)
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.currency_rupee,
                                        size: 12,
                                        color: Color(0xff004932),
                                      ),
                                      Text(
                                        "${data.products[1].price}",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                    ],
                                  ),
                                if(data.products.length>=3)
                                  const Text(
                                    "And More...",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff000000),
                                    ),
                                  )
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.013889 * width, 0.00625 * height,
                            0.013889 * width, 0.00625 * height),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data.status,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff004932),
                              ),
                            ),
                            Text(
                              _formatTime(data.createdAt),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff004932),
                              ),
                            ),
                          ],
                        ),
                      )
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