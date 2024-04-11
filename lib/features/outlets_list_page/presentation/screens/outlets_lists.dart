import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flavr/core/components/heading.dart';
import 'package:flavr/core/components/search_bar.dart';
import 'package:flavr/core/components/shimmer.dart';
import 'package:flavr/core/components/shimmer_loading.dart';
import 'package:flavr/core/constants.dart';
import 'package:flavr/features/outlets_list_page/presentation/widgets/button_row.dart';
import 'package:flavr/features/outlets_list_page/presentation/widgets/image_slider.dart';
import 'package:flavr/features/outlets_list_page/presentation/widgets/shimmer_outlet_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
  static const List<String> list = [
    "assets/images/Scene-43.webp",
    "assets/images/Scene-27.webp",
  ];
  List<Outlet> savedOutletList = [];
  List<Outlet> allOutletList = [];
  List<Outlet> searchSavedOutletList = [];
  List<Outlet> searchAllOutletList = [];
  bool isExpanded = false;
  String username = "";
  bool selectedTab = false;

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

  @override
  Widget build(BuildContext context) {
    final border = BorderRadius.circular(15);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return BlocListener<OutletListBloc, OutletListState>(
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
          Navigator.pushNamed(context, "/outletMenu");
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
        body: Shimmer(
          linearGradient: shimmerGradient,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 19.0 , vertical: 0.005*height),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
                    _getHeadRow(),
                    RichText(
                      text: TextSpan(
                        text:
                            "What are you waiting for? Select an outlet to order delicious food from...",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            fontFamily: GoogleFonts.poppins().fontFamily),
                      ),
                    ),
                  ClipRRect(
                      borderRadius: border,
                    child: CarouselSlider(
                        options: CarouselOptions(
                          height: 0.24 * height,
                          viewportFraction: 1,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 2),
                          enableInfiniteScroll: false,
                          reverse: true,
                        ),
                        items: list.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Card(
                                margin: EdgeInsets.zero,
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: border,
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Image.asset(
                                    i,
                                    fit: BoxFit.fitWidth,
                                    width: 0.9027777778 * width,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                    ),
                  ),

                      // _getButtonRow(width, height, ),
                      ButtonRow(
                          width: width,
                          height: height,
                          selectedTab: selectedTab,
                          onFirstPressed: () {
                            setState(() {
                              selectedTab = false;
                            });
                          },
                          onSecondPressed: () {
                            setState(() {
                              selectedTab = true;
                            });
                          }),
                      CustomSearchBar(
                        width: width,
                        height: height,
                        controller: controller,
                        onChanged: (value) {
                          context.read<OutletListBloc>().add(
                                OnSearchEvent(
                                  query: value,
                                  savedOutlets: savedOutletList,
                                  allOutlets: allOutletList,
                                ),
                              );
                        },
                      ),

                  if (selectedTab)
                      _savedOutletList(width, height)
                    else
                      _allList(width, height),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _savedOutletList(width, height) {
    return Column(
      children: [
        for (var i in searchSavedOutletList)
          OutletCard(
            width: width,
            height: height,
            outlet: i,
            selectOutlet: () {
              context.read<OutletListBloc>().add(OnOutletSelection(i.id));
            },
            addToFav: (id) {
              context.read<OutletListBloc>().add(
                    OnAddToFav(
                      id,
                      savedOutletList,
                      allOutletList,
                    ),
                  );
            },
          ),
      ],
    );
  }

  _allList(width, height) {
    return Column(
      children: [
        if (searchAllOutletList.isEmpty)
          for(int i=0; i<3; i++)
            ShimmerLoading(
              isLoading: true,
              child: ShimmerOutletCard(
                width: width,
                height: height,
              ),
            ),
        for (var i in searchAllOutletList)
          OutletCard(
            width: width,
            height: height,
            outlet: i,
            selectOutlet: () {
              log("on card click");
              context.read<OutletListBloc>().add(OnOutletSelection(i.id));
            },
            addToFav: (id) {
              context.read<OutletListBloc>().add(
                    OnAddToFav(
                      id,
                      savedOutletList,
                      allOutletList,
                    ),
                  );
            },
          ),
      ],
    );
  }

  _getHeadRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Heading(text: "Outlets"),
        GestureDetector(
          onTap: () {
            context.read<OutletListBloc>().add(const OnProfileButtonClicked());
          },
          child: const Icon(
            Icons.account_circle,
            size: 32,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
