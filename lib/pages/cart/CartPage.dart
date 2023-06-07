import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
                0.05 * width, 0.0325 * height, 0.05 * width, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  alignment: Alignment.topLeft,
                  color: Colors.black,
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                IconButton(
                  alignment: Alignment.topRight,
                  color: Colors.black,
                  icon: const Icon(Icons.person_outline_rounded),
                  onPressed: () {
                    Navigator.pushNamed(context, "/profile");
                  },
                )
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: (0.4 * height),
                  child: Container(
                    color: Colors.transparent,
                    child: Lottie.asset("assets/animations/add_to.json"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.07778 * width),
                  child: Card(
                    elevation: 5,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 0.88889 * width,
                          height: 0.06125 * height,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                0.0444 * width, 0.02 * height, 0, 0),
                            child: const Text(
                              'Your Order',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: "inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 0.88889 * width,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  Icon(
                                    Icons.crop_square_sharp,
                                    color: Colors.green,
                                    size: 30,
                                  ),
                                  Icon(
                                    Icons.circle,
                                    color: Colors.green,
                                    size: 10,
                                  ),
                                ],
                              ),
                              Text(
                                "Shillong Shezwan Maggi",
                                style: TextStyle(
                                  fontFamily: "inter",
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/payment");
                    },
                    child:const  Text(
                        "Check Out",
                    )
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// }
