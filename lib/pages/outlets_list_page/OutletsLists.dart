import 'dart:async';
import 'dart:developer';

import 'package:flavr/pages/outlets_list_page/outlet_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../outlet_menu/Outlet.dart';

class OutletsList extends StatefulWidget {
  const OutletsList({Key? key}) : super(key: key);

  @override
  State<OutletsList> createState() => _OutletsListState();
}

class _OutletsListState extends State<OutletsList> {
  final controller = TextEditingController();
  final _outletListBloc = OutletListBloc();
  final List<String> list = [
    "https://cdn.pixabay.com/photo/2014/10/19/20/59/hamburger-494706_1280.jpg",
    "https://cdn.pixabay.com/photo/2017/12/10/14/47/pizza-3010062_1280.jpg",
    "https://cdn.pixabay.com/photo/2017/11/08/22/18/spaghetti-2931846_1280.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    StreamController<List<Outlet>> list = StreamController<List<Outlet>>();
    //List<Outlet> outletList = [];

    return BlocProvider(
        create: (context) {
          return _outletListBloc;
        },
        child: BlocListener<OutletListBloc, OutletListState>(
          listener: (context, state) {
            if (state is NavigateToProfile) {
              Navigator.pushNamed(context, "/profile");
            }
          },
          child: Scaffold(
            body: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0.04166 * width, 0.05 * height, 0.03 * width, 0),
                  child: Row(
                    children: [
                      const Column(
                        children: [
                          Text("Good morning, ",
                              style: TextStyle(
                                color: Color(0xff004932),
                                fontFamily: "inter",
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              )),
                          Text(
                            "Akshita Goyal",
                            style: TextStyle(
                              color: Color(0xff004932),
                              fontFamily: "inter",
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.33 * width, 0, 0, 0),
                        child: const Icon(Icons.search,
                            color: Color(0xff004932), size: 30),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.05 * width, 0, 0, 0),
                        child: IconButton(
                          onPressed: () {
                            _outletListBloc.add(const OnProfileButtonClicked());
                          },
                          icon: const Icon(Icons.person,
                              color: Color(0xff004932), size: 30),
                        ),
                        // Icons.person , color: Color(0xff004932) , size: 30
                      )
                    ],
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.fromLTRB(7, 0.05 * height, 0, 0),
                //   child: Container(
                //     width: double.infinity,
                //     alignment: Alignment.centerLeft,
                //     child: const Text(
                //       "Choose Outlet",
                //       style: TextStyle(
                //           fontFamily: "inter",
                //           fontSize: 30,
                //           fontWeight: FontWeight.w600),
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.fromLTRB(0, 0.015 * height, 0, 0),
                //   child: Center(
                //     child: SizedBox(
                //       height: 0.065 * height,
                //       width: 0.91111 * width,
                //       child: Container(
                //         // color: Colors.red,
                //         child: TextField(
                //           controller: controller,
                //           decoration: InputDecoration(
                //               contentPadding:
                //                   const EdgeInsets.symmetric(vertical: 0),
                //               hintText: "Hinted search text",
                //               hintStyle: const TextStyle(
                //                 color: Color(0xFFBBB7B7),
                //                 fontSize: 20,
                //               ),
                //               prefixIcon: const Icon(Icons.search),
                //               suffixIcon: Padding(
                //                 padding: const EdgeInsets.symmetric(
                //                     vertical: 0, horizontal: 6),
                //                 child: CircleAvatar(
                //                   child: IconButton(
                //                     onPressed: () {
                //                       _outletListBloc.add(const OnProfileButtonClicked());
                //                     },
                //                     icon: const Icon(Icons.person_outline_rounded),
                //                   ),
                //                 ),
                //               ),
                //               filled: true,
                //               fillColor: const Color(0xFFFFFAEA),
                //               border: OutlineInputBorder(
                //                 borderRadius: BorderRadius.circular(20.0),
                //               )),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0,0.02 * height,0,0),
                          child: CarouselSlider(
                            options: CarouselOptions(
                                height: 0.2665625 * height,
                                viewportFraction: 1,
                                enlargeCenterPage: true,
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 2),
                                enableInfiniteScroll: false,
                                reverse: true),
                            items: list.map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      width: 0.888 * width,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: Image.network(i, fit: BoxFit.fill),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.055555 * width,
                              0.0359375 * height, 0.055555 * width, 0.0359375 * height),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 0.07 * height,
                                width: 0.4 * width,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  color: const Color(0xff004932),
                                  child: const Center(
                                    child: Text(
                                      "Saved outlets",
                                      style: TextStyle(color: Colors.white, fontSize: 17),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 0.07 * height,
                                width: 0.4 * width,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  color: const Color(0xffA3C2B3),
                                  child: const Center(
                                    child: Text(
                                      "Add outlet",
                                      style: TextStyle(color: Colors.black, fontSize: 17),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.transparent,
                          child: Card(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0.05 * width, vertical: 0.005 * height),
                                  child: Card(
                                      elevation: 5,
                                      shadowColor: Colors.black,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: SizedBox(
                                          width: width,
                                          height: 0.34125* height,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                  width: width,
                                                  height: 0.26625 * height,
                                                  child: Image.asset(
                                                    "assets/images/subway.jpeg",
                                                    fit: BoxFit.fill,
                                                  )),
                                              Align(
                                                alignment: AlignmentDirectional.centerStart,
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0.0277 * width, 0.01 * height, 0, 0),
                                                  child: const Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Nescafe",
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        "Jalandhar, punjab",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                              // const Expanded(
                                              //   child: Align(
                                              //     alignment: AlignmentDirectional.centerStart,
                                              //     child: Padding(
                                              //       padding: EdgeInsets.fromLTRB(9.0, 0, 0, 0),
                                              //       child: Text(
                                              //         "Domino's , India",
                                              //         style: TextStyle(
                                              //             fontSize: 20,
                                              //             fontFamily: "inter",
                                              //             fontWeight: FontWeight.w600),
                                              //       ),
                                              //     ),
                                              //   ),
                                              // )
                                            ],
                                          ),
                                        ),
                                      )),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0.05 * width, vertical: 0.005 * height),
                                  child: Card(
                                      elevation: 5,
                                      shadowColor: Colors.black,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: SizedBox(
                                          width: width,
                                          height: 0.34125* height,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                  width: width,
                                                  height: 0.26625 * height,
                                                  child: Image.asset(
                                                    "assets/images/subway.jpeg",
                                                    fit: BoxFit.fill,
                                                  )),
                                              Align(
                                                alignment: AlignmentDirectional.centerStart,
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0.0277 * width, 0.01 * height, 0, 0),
                                                  child: const Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Nescafe",
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        "Jalandhar, punjab",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                              // const Expanded(
                                              //   child: Align(
                                              //     alignment: AlignmentDirectional.centerStart,
                                              //     child: Padding(
                                              //       padding: EdgeInsets.fromLTRB(9.0, 0, 0, 0),
                                              //       child: Text(
                                              //         "Domino's , India",
                                              //         style: TextStyle(
                                              //             fontSize: 20,
                                              //             fontFamily: "inter",
                                              //             fontWeight: FontWeight.w600),
                                              //       ),
                                              //     ),
                                              //   ),
                                              // )
                                            ],
                                          ),
                                        ),
                                      )),
                                ),

                              ],
                            ),


                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(
                        //       horizontal: 0.05 * width, vertical: 0.005 * height),
                        //   child: Card(
                        //       elevation: 5,
                        //       shadowColor: Colors.black,
                        //       color: Colors.white,
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(10),
                        //       ),
                        //       child: ClipRRect(
                        //         borderRadius: BorderRadius.circular(10),
                        //         child: SizedBox(
                        //           width: width,
                        //           height: 0.34125 * height,
                        //           child: Column(
                        //             children: [
                        //               SizedBox(
                        //                   width: width,
                        //                   height: 0.26625 * height,
                        //                   child: Image.asset(
                        //                     "assets/images/subway.jpeg",
                        //                     fit: BoxFit.fill,
                        //                   )),
                        //               Align(
                        //                 alignment: AlignmentDirectional.centerStart,
                        //                 child: Padding(
                        //                   padding: EdgeInsets.fromLTRB(
                        //                       0.0277 * width, 0.01 * height, 0, 0),
                        //                   child: const Column(
                        //                     crossAxisAlignment:
                        //                     CrossAxisAlignment.start,
                        //                     children: [
                        //                       Text(
                        //                         "Nescafe",
                        //                         style: TextStyle(
                        //                           fontSize: 17,
                        //                           fontWeight: FontWeight.bold,
                        //                         ),
                        //                       ),
                        //                       Text(
                        //                         "Jalandhar, punjab",
                        //                         style: TextStyle(
                        //                           fontSize: 15,
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //               )
                        //               // const Expanded(
                        //               //   child: Align(
                        //               //     alignment: AlignmentDirectional.centerStart,
                        //               //     child: Padding(
                        //               //       padding: EdgeInsets.fromLTRB(9.0, 0, 0, 0),
                        //               //       child: Text(
                        //               //         "Domino's , India",
                        //               //         style: TextStyle(
                        //               //             fontSize: 20,
                        //               //             fontFamily: "inter",
                        //               //             fontWeight: FontWeight.w600),
                        //               //       ),
                        //               //     ),
                        //               //   ),
                        //               // )
                        //             ],
                        //           ),
                        //         ),
                        //       )),
                        // ),
                      ],
                    ),
                  ),
                ),
                // Frame(height: height, width: width)
              ],
            ),
          ),
        ),
      );

  }
}

class Frame extends StatelessWidget {
  const Frame({Key? key, required this.height, required this.width})
      : super(key: key);
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 0.05 * width, vertical: 0.005 * height),
      child: Card(
          elevation: 5,
          shadowColor: Colors.black,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: width,
              height: 0.25 * height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: width,
                      height: 0.20 * height,
                      child: Image.asset(
                        "assets/images/burger.jpg",
                        fit: BoxFit.fill,
                      )),
                  const Expanded(
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(9.0, 0, 0, 0),
                        child: Text(
                          "Domino's , India",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "inter",
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  )
                  // const Expanded(
                  //   child: Align(
                  //     alignment: AlignmentDirectional.centerStart,
                  //     child: Padding(
                  //       padding: EdgeInsets.fromLTRB(9.0, 0, 0, 0),
                  //       child: Text(
                  //         "Domino's , India",
                  //         style: TextStyle(
                  //             fontSize: 20,
                  //             fontFamily: "inter",
                  //             fontWeight: FontWeight.w600),
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          )),
    );
  }
}
