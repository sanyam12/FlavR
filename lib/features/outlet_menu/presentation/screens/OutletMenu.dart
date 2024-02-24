import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flavr/core/CartChangeProvider.dart';
import 'package:flavr/core/components/heading.dart';
import 'package:flavr/core/components/loading.dart';
import 'package:flavr/core/components/search_bar.dart';
import 'package:flavr/features/cart/presentation/screens/CartPage.dart';
import 'package:flavr/features/outlet_menu/presentation/widgets/categories_list.dart';
import 'package:flavr/features/outlet_menu/presentation/widgets/menu_discount_slider.dart';
import 'package:flavr/features/outlet_menu/presentation/widgets/menu_search_bar.dart';
import 'package:flavr/features/outlet_menu/presentation/widgets/top_row.dart';
import 'package:flavr/features/outlet_menu/presentation/widgets/veg_selector.dart';
import 'package:flavr/pages/ordernumber/OrderNumber.dart';
import 'package:flavr/pages/profile_page/OrderData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../cart/data/models/Cart.dart';
import '../../data/models/Categories.dart';
import '../../bloc/outlet_menu_bloc.dart';
import '../widgets/category_menu.dart';


//TODO price filters business logic pending
class OutletMenu extends StatefulWidget {
  const OutletMenu({Key? key}) : super(key: key);

  @override
  State<OutletMenu> createState() => _OutletMenuState();
}

class _OutletMenuState extends State<OutletMenu> {
  final searchController = TextEditingController();
  String outletName = "Outlet";
  late Cart cart;
  List<Categories> menuList = [];
  List<Categories> filteredMenuList = [];
  List<OrderData> incompleteOrders = [];
  String selectedCategory = "All";
  bool isVegClicked = false;
  bool isNonVegClicked = false;

  int _calculateTotalItems() {
    int cnt = 0;
    for (var i in cart.items.entries) {
      for (var j in i.value) {
        cnt += j.quantity;
      }
    }
    return cnt;
  }

  int _calculateCartAmount() {
    int cnt = 0;
    for (var i in cart.items.entries) {
      for (var j in i.value) {
        cnt += (j.quantity * j.price);
      }
    }
    return cnt;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    cart = context
        .read<CartChangeProvider>()
        .cart;
    context.read<OutletMenuBloc>().add(const RefreshMenuEvent());
  }

  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);
    final width = queryData.size.width;
    final height = queryData.size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<OutletMenuBloc, OutletMenuState>(
          listener: (context, state) async {
            if (state is ShowSnackBar) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
            if (state is UpdatedCartState) {
              cart = state.cart;
              context.read<CartChangeProvider>().updateCart(state.cart);
            }
            if (state is RefreshedOutletData) {
              outletName = state.outletName;
              cart = state.cart;
              menuList = state.menuList;
              filteredMenuList = state.menuList;
              incompleteOrders = state.incompleteOrders;

              context.read<CartChangeProvider>().updateCart(state.cart);
            }
            if (state is NavigateToOutletList) {
              await Navigator.of(context).pushNamed("/outletList");
              if (context.mounted) {
                context.read<OutletMenuBloc>().add(
                  const RefreshMenuEvent(),
                );
              }
            }
            if (state is SearchResultState) {
              filteredMenuList = state.menuList;
            }
            if (state is FetchCart) {
              if (context.mounted) {
                cart = context
                    .read<CartChangeProvider>()
                    .cart;
              }
            }
            if (state is VegFilterTriggered) {
              filteredMenuList = state.menuList;
              if (state.toggled) {
                isNonVegClicked = false;
                isVegClicked = true;
              } else {
                isVegClicked = false;
              }
            }
            if (state is NonVegFilterTriggered) {
              filteredMenuList = state.menuList;
              if (state.toggled) {
                isVegClicked = false;
                isNonVegClicked = true;
              } else {
                isNonVegClicked = false;
              }
            }
          },
          builder: (context, state) {
            if (state is OutletMenuLoading || state is OutletMenuInitial) {
              return const Center(child: CustomLoadingAnimation());
            }
            final List<Widget> stackList = incompleteOrders
                .map((e) =>
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderNumber(orderId: e.id),
                      ),
                    );
                  },
                  child: Card(
                      color: const Color(0xFFA3C2B3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 28.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Center(
                                child: (e.orderNumber != null)
                                    ? Text(
                                    "Order Number:\n${e.orderNumber
                                        .toString()}",
                                    textAlign: TextAlign.center)
                                    : const Text(
                                    "Order Number:\nNot Assigned",
                                    textAlign: TextAlign.center)),
                            Center(
                                child: Text(
                                  "Price:\n${e.totalPrice.toString()}",
                                  textAlign: TextAlign.center,
                                )),
                          ],
                        ),
                      )),
                ))
                .toList();
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Stack(
                children:[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TopRow(
                        width: width,
                        outletName: outletName,
                      ),
                      MenuSearchBar(
                        width: width,
                        height: height,
                        controller: searchController,
                        menuList: menuList,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MenuDiscountSlider(
                                width: width,
                                height: height,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 6.0),
                                child: Heading(text: "Categories"),
                              ),
                              CategoriesList(
                                width: width,
                                height: height,
                                filteredMenuList: filteredMenuList,
                                selectedCategory: selectedCategory,
                                onTap: (index) {
                                  setState(() {
                                    selectedCategory =
                                        filteredMenuList[index].category;
                                  });
                                },
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 5.0),
                                child: Heading(text: "Products"),
                              ),
                              VegSelector(width: width,
                                height: height,
                                menuList: menuList,
                                isNonVegClicked: isNonVegClicked,
                                isVegClicked: isVegClicked,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 0.01125 * height,
                                ),
                                child: CategoryMenu(
                                  key: UniqueKey(),
                                  width: width,
                                  height: height,
                                  list: (selectedCategory == "All")
                                      ? filteredMenuList
                                      : filteredMenuList
                                      .where((element) =>
                                  element.category ==
                                      selectedCategory)
                                      .toList(),
                                  cart: cart,
                                  // productList: productList.data!,
                                  // updateParentState: () {
                                  //   setState(() {});
                                  // },
                                  amount: _calculateCartAmount(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 0.01625*width),
                      child: SizedBox(
                        height: 0.08*height,
                        child: CarouselSlider(
                          items: [
                            GestureDetector(
                              onTap: () async {
                                await Navigator.of(context).push<Cart>(
                                  MaterialPageRoute(
                                    builder: (context) => CartPage(list: menuList),
                                  ),
                                );
                                log("fetch cart event");
                                if (context.mounted) {
                                  context.read<OutletMenuBloc>().add(UpdateCart());
                                }
                              },
                              child: Card(
                                color: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              0.03333 * width,
                                              0,
                                              0.02778 * width,
                                              0),
                                          child: const Icon(
                                            Icons.shopping_cart,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          "${_calculateTotalItems()} Items Added",
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          0, 5, 0.038889 * width, 5),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        color: Colors.white,
                                        child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                            minWidth: 0.2166666667*width,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 7.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.currency_rupee,
                                                  size: 14,
                                                ),
                                                Text(
                                                  "${_calculateCartAmount()}",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                    GoogleFonts
                                                        .poppins()
                                                        .fontFamily,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ...stackList
                          ],
                          options: CarouselOptions(
                            height: 0.2665625 * height,
                            viewportFraction: 1,
                            enlargeCenterPage: true,
                            autoPlay: false,
                            autoPlayInterval: const Duration(seconds: 2),
                            enableInfiniteScroll: false,
                            reverse: false,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<Categories> _searchResult(String query,
      List<Categories> categoriesList,) {
    List<Categories> list = [];
    if (query.isEmpty) {
      return categoriesList;
    }
    for (var i in categoriesList) {
      var temp = Categories(
          i.category,
          i.products
              .where((element) =>
              element.name.toLowerCase().contains(query.toLowerCase()))
              .toList(),
          i.iconUrl);
      if (temp.products.isNotEmpty) {
        list.add(temp);
      }
    }
    return list;
  }
}
