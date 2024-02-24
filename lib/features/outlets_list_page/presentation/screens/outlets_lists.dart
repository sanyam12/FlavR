import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flavr/components/loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../outlet_menu/data/models/Outlet.dart';
import '../../bloc/outlet_list_bloc.dart';
import '../widgets/outlet_card.dart';

class OutletsList extends StatefulWidget {
  const OutletsList({Key? key}) : super(key: key);

  @override
  State<OutletsList> createState() => _OutletsListState();
}

class _OutletsListState extends State<OutletsList> {
  final controller = TextEditingController();
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
  void initState() {
    super.initState();
    context.read<OutletListBloc>().add(GetSavedOutletList());
    context.read<OutletListBloc>().add(GetAllOutletsList());
    context.read<OutletListBloc>().add(UsernameRequested());
  }

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

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final outletListBloc = context.read<OutletListBloc>();

    return BlocListener<OutletListBloc, OutletListState>(
      listener: (context, state) {
        // if (state is OutletListInitial) {
        //   log(
        //     "OutletMenuLoading or OutletMenuInitial state detected."
        //   );
          // showDialog(
          //   context: context,
          //   builder: (context) {
          //     return const Center(
          //       child: CustomLoadingAnimation(),
          //
          //     );
          //   },
          // );
        // }
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
          Navigator.of(context).pop(state.id);
        } else if (state is RefreshWidget) {
          setState(() {});
        } else if (state is GetSearchResultState) {
          setState(() {
            searchAllOutletList = state.allOutletList;
            searchSavedOutletList = state.savedOutletList;
          });
        } else if (state is UsernameFetchedState) {
          setState(() {
            username = state.username;
          });
        } else if (state is ErrorOccurred) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocBuilder<OutletListBloc, OutletListState>(
              builder: (context, state) {
                if (state is OutletListLoading || state is OutletListInitial) {
                  log("hello there");
                  return const Center(
                    // child: Text("youoyuoyiu")

                      child: CustomLoadingAnimation()
                  );
                }
            return Column(
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
                              outletListBloc.add(
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
                          decoration:
                              const InputDecoration(hintText: "Search Outlet"),
                          onChanged: (value) {
                            outletListBloc.add(
                              OnSearchEvent(
                                query: value,
                                savedOutlets: savedOutletList,
                                allOutlets: allOutletList,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              else
                Padding(
                  padding:
                      EdgeInsets.fromLTRB(0.04166 * width, 0, 0.03 * width, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
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
                              outletListBloc
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
                        padding: EdgeInsets.fromLTRB(0.0356 * width, 10, 0, 0),
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
                          ? const Text("Favourite Outlets List is Empty")
                          : Column(
                              children: [
                                for (var i in searchSavedOutletList)
                                  OutletCard(
                                    width: width,
                                    height: height,
                                    outlet: i,
                                    selectOutlet: () {
                                      outletListBloc
                                          .add(OnOutletSelection(i.id));
                                    },
                                    addToFav: (id) {
                                      outletListBloc.add(OnAddToFav(
                                          id, savedOutletList, allOutletList));
                                    },
                                  ),
                              ],
                            ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.0356 * width, 10, 0, 0),
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
                            outletListBloc.add(OnOutletSelection(i.id));
                          },
                          addToFav: (id) {
                            outletListBloc.add(
                                OnAddToFav(id, savedOutletList, allOutletList));
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
  },
),
        ),
      ),
    );
  }
}
