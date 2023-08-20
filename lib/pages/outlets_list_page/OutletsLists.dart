import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flavr/pages/outlets_list_page/outlet_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  List<Outlet> savedOutletList = [];
  List<Outlet> allOutletList = [];
  List<Outlet> searchSavedOutletList = [];
  List<Outlet> searchAllOutletList = [];
  bool isExpanded = false;
  String username = "";

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String greeting() {
    final currentTime = DateTime.now();
    if (currentTime.hour < 12) {
      return "Good Morning";
    } else if (currentTime.hour < 18) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }

  void getUsername() async {
    const secure = FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true));
    final token = await secure.read(key: "token");
    http.Response response = await http.get(
        Uri.parse("https://flavr.tech/user/userprofile"),
        headers: {"Authorization": "Bearer $token"});

    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);
      username = (json["user"][0]["userName"]).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // StreamController<List<Outlet>> list = StreamController<List<Outlet>>();
    //List<Outlet> outletList = [];

    getUsername();

    return BlocProvider(
      create: (context) {
        _outletListBloc.add(GetSavedOutletList());
        _outletListBloc.add(GetAllOutletsList());
        return _outletListBloc;
      },
      child: BlocListener<OutletListBloc, OutletListState>(
        listener: (context, state) {
          if (state is NavigateToProfile) {
            Navigator.pushNamed(context, "/profile");
          } else if (state is GetSavedOutletListState) {
            setState(() {
              savedOutletList = state.list;
              searchSavedOutletList = state.list;
            });
          } else if (state is GetAllOutletsListState) {
            setState(() {
              allOutletList = state.list;
              searchAllOutletList = state.list;
            });
          } else if (state is OutletSelected) {
            Navigator.of(context).pushNamed("/outletMenu");
          } else if (state is RefreshWidget) {
            setState(() {});
          } else if (state is GetSearchResultState) {
            setState(() {
              searchAllOutletList = state.allOutletList;
              searchSavedOutletList = state.savedOutletList;
            });
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                if (isExpanded)
                  SizedBox(
                    width: width,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (isExpanded) {
                                controller.text = "";
                                log("check");
                                _outletListBloc.add(
                                  OnSearchEvent(
                                    query: "",
                                    savedOutlets: savedOutletList,
                                    allOutlets: allOutletList,
                                  ),
                                );
                              }
                              isExpanded = !isExpanded;
                            });
                          },
                          icon: const Icon(Icons.arrow_back_ios),
                        ),
                        Expanded(
                          child: TextField(
                            controller: controller,
                            decoration: const InputDecoration(
                                hintText: "Search Outlet"),
                            onChanged: (value) {
                              log("on changed");
                              _outletListBloc.add(
                                OnSearchEvent(
                                    query: value,
                                    savedOutlets: savedOutletList,
                                    allOutlets: allOutletList),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        0.04166 * width, 0, 0.03 * width, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          // color: Colors.red,
                          // width: 0.21667 * width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(greeting(),
                                  style: const TextStyle(
                                    color: Color(0xff004932),
                                    fontFamily: "inter",
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  )),
                              Text(
                                username,
                                style: const TextStyle(
                                  color: Color(0xff004932),
                                  fontFamily: "inter",
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Expanded(child: Container(color: Colors.green, child: Text("sfds"),)),
                        Row(
                          children: [
                            IconButton(
                              // constraints: const BoxConstraints(),
                              // padding: EdgeInsets.zero,
                              onPressed: () {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
                              icon: const Icon(
                                Icons.search,
                                color: Color(0xff004932),
                                size: 30,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                _outletListBloc
                                    .add(const OnProfileButtonClicked());
                              },
                              icon: const Icon(
                                Icons.person,
                                color: Color(0xff004932),
                                size: 30,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0.02 * height, 0, 0),
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
                          padding:
                              EdgeInsets.fromLTRB(0.0356 * width, 10, 0, 0),
                          child: const SizedBox(
                            width: double.infinity,
                            child: Text(
                              "Favourite Outlets",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF004932)),
                            ),
                          ),
                        ),
                        (savedOutletList.isEmpty)
                            ? Container(
                                child: const Text(
                                    "Favourite Outlets List is Empty"),
                              )
                            : Column(
                                children: [
                                  for (var i in searchSavedOutletList)
                                    OutletCard(
                                      width: width,
                                      height: height,
                                      outlet: i,
                                      selectOutlet: () {
                                        _outletListBloc
                                            .add(OnOutletSelection(i.id));
                                      },
                                      addToFav: (id) {
                                        _outletListBloc.add(OnAddToFav(id,
                                            savedOutletList, allOutletList));
                                      },
                                    ),
                                ],
                              ),
                        Padding(
                          padding:
                              EdgeInsets.fromLTRB(0.0356 * width, 10, 0, 0),
                          child: const SizedBox(
                            width: double.infinity,
                            child: Text(
                              "All Outlets",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF004932)),
                            ),
                          ),
                        ),
                        for (var i in searchAllOutletList)
                          OutletCard(
                            width: width,
                            height: height,
                            outlet: i,
                            selectOutlet: () {
                              _outletListBloc.add(OnOutletSelection(i.id));
                            },
                            addToFav: (id) {
                              _outletListBloc.add(OnAddToFav(
                                  id, savedOutletList, allOutletList));
                            },
                          ),
                      ],
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

class OutletCard extends StatelessWidget {
  const OutletCard(
      {super.key,
      required this.width,
      required this.height,
      required this.outlet,
      required this.selectOutlet,
      required this.addToFav});

  final double width;
  final double height;
  final Outlet outlet;
  final void Function() selectOutlet;
  final void Function(Outlet) addToFav;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 0.05 * width, vertical: 0.005 * height),
      child: InkWell(
        onTap: () {
          selectOutlet();
        },
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
                height: 0.34125 * height,
                child: Column(
                  children: [
                    SizedBox(
                      width: width,
                      height: 0.26625 * height,
                      child:
                          (outlet.imageUrl != null && outlet.imageUrl != 'null')
                              ? Image.network(
                                  outlet.imageUrl!,
                                  fit: BoxFit.fill,
                                )
                              : Image.asset(
                                  "assets/images/subway.jpeg",
                                  fit: BoxFit.fill,
                                ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            0.0277 * width, 0.01 * height, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  outlet.outletName,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 0.7 * width,
                                  child: Text(
                                    outlet.address,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                addToFav(outlet);
                              },
                              icon: (outlet.isFavourite)
                                  ? const Icon(Icons.favorite)
                                  : const Icon(Icons.favorite_border),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
