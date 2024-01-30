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
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "11 Dec,2024",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff000000),
                      ),
                    ),
                    Text(
                      //TODO: Outlet name
                      "Outlet Name",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff000000),
                      ),
                    ),
                    Text(
                      "12:44 PM",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff000000),
                      ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(
                                0.0556 * width, 0, 0.0556 * width, 0,),
                            child: CircleAvatar(
                              radius: 32,
                              child: ClipOval(
                                  child:
                                      Image.asset('assets/images/pasta.jpeg'),
                              ),
                            ),
                        ),
                        CircleAvatar(
                          radius: 32,
                          child: ClipOval(
                              child: Image.asset('assets/images/pasta.jpeg')),
                        )
                      ],
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "1 x Red Sauce Pasta",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff000000),
                          ),
                        ),
                        Text(
                          "2 x Veg Cheese Burger",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff000000),
                          ),
                        ),
                      ],
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.currency_rupee,
                              size: 12,
                              color: Color(0xff004932),
                            ),
                            Text(
                              "180",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff000000),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.currency_rupee,
                              size: 12,
                              color: Color(0xff004932),
                            ),
                            Text(
                              "180",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff000000),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.013889 * width, 0.00625 * height,
                    0.013889 * width, 0.00625 * height),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Delivered Successfully",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff004932),
                      ),
                    ),
                    Text(
                      "7:00 PM",
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
