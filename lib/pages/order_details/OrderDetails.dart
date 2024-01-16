import 'dart:developer';

import 'package:flavr/pages/order_details/order_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetails extends StatefulWidget {
  final String orderId;

  const OrderDetails({super.key, required this.orderId});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {

  final bloc = OrderDetailsBloc();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) {
        bloc.add(GetOrderData(widget.orderId));
        return bloc;
      },
      child: BlocListener<OrderDetailsBloc, OrderDetailsState>(
        listener: (context, state) {
          if(state is ShowSnackbar){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message))
            );
          }else if(state is OrderData){
            log(state.outletName);
            log(state.outletAddress);
            log(state.imageUrl);
          }
        },
        child: Scaffold(
          body: Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 0.285*height,
                      child: Image.asset(
                        'assets/images/RWPasta.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Stack(
                      children: [
                        RawMaterialButton(
                          onPressed: () {},
                          elevation: 5.0,

                          child: Icon(
                            Icons.circle,
                            size: 0.09722*width,
                            color: Color(0xff004932),
                            shadows: <Shadow>[Shadow(color: Colors.white, blurRadius: 7.0)],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: BackButton(),
                          iconSize: 0.030625*height,
                          color: Color(0xffffffff),
                          padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.29722*width,0.26125*height,0,0),
                          child: Stack(
                            children : [
                              SizedBox(
                                height: 0.04375*height,
                                width: 0.416667*width,
                                child: Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  color: const Color(0xffffffff),
                                  child: Padding(
                                      padding: EdgeInsets.fromLTRB(0.09722*width, 0.004*height, 0, 0),
                                    child: const Text('Nescafe',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
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
                  padding: EdgeInsets.fromLTRB(0.150556*width,0,0,0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 0.025*height,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.013889*width,0,0,0),
                        child: const Text(
                          'Nit Jalandhar, Grand trunk road, Barnala-Amritsar Bypass',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xff000000),
                            fontSize: 10,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0378*width,0.0125*height,0,0),
                  child: Column(
                    children: [
                      const Text(
                        'Date : 26-05-23 , Friday',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff000000),
                        ),
                      ),
                      const Text(
                        'Order Placed : 13:11',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff000000),
                      ),
                      ),
                      const Text(
                        'Order Picked : 13:40',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff000000),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0,0.025*height,0,0),
                        child: SizedBox(
                          height: 0.4875*height,
                          child: Column(
                            children: [
                              SizedBox(
                                width: 0.8889 * width,
                                height: 0.1575*height,
                                child: Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  color: const Color(0xffffffff),
                                  elevation: 3,
                                  child: Row(
                                    children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                      width: 0.1125*height,
                                      height: 0.1125*height,
                                        child:ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: Image.asset('assets/images/pizza.jpg'),
                                        ),
                                      ),
                                    ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0.15*width,0.03625*height,0,0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    Icon(Icons.crop_square_sharp, color: Colors.green, size: 0.025*height,),
                                                    Icon(Icons.circle, color: Colors.green, size: 0.02160556*width),
                                                  ],
                                                ),
                                                const Text(
                                                  'Original Maggi',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff000000),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.currency_rupee,
                                                  color: const Color(0xff004932),
                                                  size: 0.041667*width,
                                                ),
                                                const Text(
                                                  '80',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color(0xff004932),
                                                  ),
                                                ),
                                                const Text(
                                                  '(Large)',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff000000),
                                                  ),
                                                )
                                              ],
                                            ),
                                            const Text(
                                              'Maggi with maggi masala',
                                              style: TextStyle(
                                                color: Color(0xff8A8888),
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 0.8889 * width,
                                height: 0.1575*height,
                                child: Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  color: const Color(0xffffffff),
                                  elevation: 3,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: 0.1125*height,
                                          height: 0.1125*height,
                                          child:ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: Image.asset('assets/images/pizza.jpg'),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0.15*width,0.03625*height,0,0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    Icon(Icons.crop_square_sharp, color: Colors.green, size: 0.025*height,),
                                                    Icon(Icons.circle, color: Colors.green, size: 0.02160556*width),
                                                  ],
                                                ),
                                                const Text(
                                                  'Original Maggi',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff000000),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.currency_rupee,
                                                  color: const Color(0xff004932),
                                                  size: 0.041667*width,
                                                ),
                                                const Text(
                                                  '80',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color(0xff004932),
                                                  ),
                                                ),
                                                const Text(
                                                  '(Large)',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff000000),
                                                  ),
                                                )
                                              ],
                                            ),
                                            const Text(
                                              'Maggi with maggi masala',
                                              style: TextStyle(
                                                color: Color(0xff8A8888),
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
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
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0,0,0,0),
                  child: SizedBox(
                    height: 0.075*height,
                    width: 0.833*width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff004932),
                      ),
                      onPressed: ()=>{},

                        child: const Text(
                          'Re Order',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            backgroundColor: Color(0xff004932),
                            color: Color(0xffffffff),
                          ),
                        ),
                    ),
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
