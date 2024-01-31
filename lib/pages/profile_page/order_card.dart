import 'dart:developer';

import 'package:flavr/pages/order_details/OrderDetails.dart';
import 'package:flavr/pages/profile_page/OrderData.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final double width;
  final double height;
  final OrderData data;

  const OrderCard(
      {super.key,
      required this.width,
      required this.height,
      required this.data});

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
                builder: (context) => OrderDetails(orderId: data.id),
              ),
            );
          },
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0.013889 * width, 0.00625 * height,
                    0.013889 * width, 0.00625 * height),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data.createdAt.day.toString(),
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff000000),
                      ),
                      overflow: TextOverflow.clip,
                    ),
                    const Text(
                      //TODO: Outlet name
                      "data.outlet",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff000000),
                      ),
                    ),
                    const Text(
                      "time data.createdAt",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff000000),
                      ),
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              ),
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
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff000000),
                          ),
                        ),
                        Text(
                          data.orderNumber?.toString() ?? "NA",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffff0000),
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
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
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
                        if(data.products.isNotEmpty)
                          Text(
                            "${data.products[0].quantity} x ${data.products[0].productName}",
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff000000),
                            ),
                          ),
                        if(data.products.length>=2)
                          Text(
                            "${data.products[1].quantity} x ${data.products[1].productName}",
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff000000),
                            ),
                          ),
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
                    const Text(
                      "Last Updated: time",
                      style: TextStyle(
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
    );
  }
}
