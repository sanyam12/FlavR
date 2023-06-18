import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OrderNumber extends StatefulWidget {
  final String orderNumber;
  const OrderNumber({Key? key, required this.orderNumber}) : super(key: key);

  @override
  State<OrderNumber> createState() => _OrderNumberState();
}

class _OrderNumberState extends State<OrderNumber> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 0.369 * height,
            child: Card(
              color: const Color(0xffA3C2B3),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0.0575 * height, 0, 0),
                    child: const Text(
                      "Your order is ready!!",
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  LottieBuilder.asset(
                    "assets/animations/done.json",
                    width: 0.555 * width,
                    height: 0.25 * height,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0.0075 * height, 0, 0),
                    child: const Text(
                      "Order number: 22",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0.02 * height, 0, 0),
                    child: const Text(
                      "Current order number: 22",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0.02 * height, 0, 0),
                    child: const Text(
                      "13:01:25  Wednesday, 06-06-2023",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 0.88*width,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0,0.0275*height,0,0),
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child:
                         Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0.0416*width, 0.0075 * height, 0, 0),
                              child: Container(
                                alignment: AlignmentDirectional.centerStart,
                                child: const Text(
                                  "Order details",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.fromLTRB(0.045*width,0.01875*height,0,0),
                              child:  Row(

                                children: [
                                   const Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Icon(
                                        Icons.crop_square_sharp,
                                        color: Colors.green,
                                        size: 25,
                                      ),
                                      Icon(Icons.circle,
                                          color: Colors.green, size: 10),
                                    ],
                                  ),
                                   Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0.030*width,0,0,0),
                                        child: const Text("Shillong Shezwan maggi x1 ",
                                            style: TextStyle(
                                                 fontSize: 15)),
                                      ),
                                      const Row(
                                        children: [
                                          Icon(
                                            Icons.currency_rupee,
                                            size: 15,
                                            color: Color(0xff004932),
                                          ),
                                          Text(
                                            "140",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff004932),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.fromLTRB(0.045*width,0.01875*height,0,0),
                              child:  Row(

                                children: [
                                  const Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Icon(
                                        Icons.crop_square_sharp,
                                        color: Colors.green,
                                        size: 25,
                                      ),
                                      Icon(Icons.circle,
                                          color: Colors.green, size: 10),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0.030*width,0,0,0),
                                        child: const Text("Shillong Shezwan maggi x1 ",
                                            style: TextStyle(
                                                fontSize: 15)),
                                      ),
                                      const Row(
                                        children: [
                                          Icon(
                                            Icons.currency_rupee,
                                            size: 15,
                                            color: Color(0xff004932),
                                          ),
                                          Text(
                                            "140",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff004932),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.fromLTRB(0.045*width,0.01875*height,0,0),
                              child:  Row(

                                children: [
                                  const Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Icon(
                                        Icons.crop_square_sharp,
                                        color: Colors.green,
                                        size: 25,
                                      ),
                                      Icon(Icons.circle,
                                          color: Colors.green, size: 10),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0.030*width,0,0,0),
                                        child: const Text("Shillong Shezwan maggi x1 ",
                                            style: TextStyle(
                                                fontSize: 15)),
                                      ),
                                      const Row(
                                        children: [
                                          Icon(
                                            Icons.currency_rupee,
                                            size: 15,
                                            color: Color(0xff004932),
                                          ),
                                          Text(
                                            "140",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff004932),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.fromLTRB(0.045*width,0.01875*height,0,0),
                              child:  Row(

                                children: [
                                  const Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Icon(
                                        Icons.crop_square_sharp,
                                        color: Colors.green,
                                        size: 25,
                                      ),
                                      Icon(Icons.circle,
                                          color: Colors.green, size: 10),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0.030*width,0,0,0),
                                        child: const Text("Shillong Shezwan maggi x1 ",
                                            style: TextStyle(
                                                fontSize: 15)),
                                      ),
                                      const Row(
                                        children: [
                                          Icon(
                                            Icons.currency_rupee,
                                            size: 15,
                                            color: Color(0xff004932),
                                          ),
                                          Text(
                                            "140",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff004932),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                               padding: EdgeInsets.fromLTRB(0.0416*width,0.01625*height,0,0.01375*height),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: const Text(
                                      "Grand Total",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.fromLTRB(0, 0, 0.0722*width, 0),
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.currency_rupee,
                                          size: 15,
                                          color: Color(0xff004932),
                                        ),
                                        Text(
                                          "140",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff004932),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                            ),
                             )
                          ],
                        ),
                      ),

                    ),
                  ),
                  SizedBox(
                    width: 0.88*width,
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0.0416*width, 0.0075 * height, 0, 0),
                            child: Container(
                              alignment: AlignmentDirectional.centerStart,
                              child: const Text(
                                "Special Instructions",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0,0.0075*height,0,0),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.circle,
                                    color: Colors.black, size: 10),
                                Text("Don’t add cheese to one medium shillong shezwan maggi" , style:
                                  TextStyle(
                                    fontSize: 10
                                  ),),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0,0.0075*height,0,0),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.circle,
                                    color: Colors.black, size: 10),
                                Text("Don’t add cheese to one medium shillong shezwan maggi" , style:
                                TextStyle(
                                    fontSize: 10
                                ),),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0,0.0075*height,0,0),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.circle,
                                    color: Colors.black, size: 10),
                                Text("Don’t add cheese to one medium shillong shezwan maggi" , style:
                                TextStyle(
                                    fontSize: 10
                                ),),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0,0.0075*height,0,0),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.circle,
                                    color: Colors.black, size: 10),
                                Text("Don’t add cheese to one medium shillong shezwan maggi" , style:
                                TextStyle(
                                    fontSize: 10
                                ),),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0,0.0075*height,0,0),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.circle,
                                    color: Colors.black, size: 10),
                                Text("Don’t add cheese to one medium shillong shezwan maggi" , style:
                                TextStyle(
                                    fontSize: 10
                                ),),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0,0.0075*height,0,0),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.circle,
                                    color: Colors.black, size: 10),
                                Text("Don’t add cheese to one medium shillong shezwan maggi" , style:
                                TextStyle(
                                    fontSize: 10
                                ),),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0,0.0075*height,0,0),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.circle,
                                    color: Colors.black, size: 10),
                                Text("Don’t add cheese to one medium shillong shezwan maggi" , style:
                                TextStyle(
                                    fontSize: 10
                                ),),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0,0.0075*height,0,0),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.circle,
                                    color: Colors.black, size: 10),
                                Text("Don’t add cheese to one medium shillong shezwan maggi" , style:
                                TextStyle(
                                    fontSize: 10
                                ),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
