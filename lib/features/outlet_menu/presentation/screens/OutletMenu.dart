import 'dart:collection';
import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flavr/components/loading.dart';
import 'package:flavr/core/CartChangeProvider.dart';
import 'package:flavr/features/outlet_menu/data/models/Product.dart';
import 'package:flavr/features/cart/CartPage.dart';
import 'package:flavr/features/cart/CartVariantData.dart';
import 'package:flavr/pages/ordernumber/OrderNumber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../features/cart/Cart.dart';
import '../../../../pages/profile_page/OrderData.dart';
import '../../data/models/Categories.dart';
import '../../bloc/outlet_menu_bloc.dart';
import '../widgets/category_menu.dart';

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
  String selectedCategory = "All";
  bool isSearchActive = false;

  int _calculateTotalItems(){
    int cnt = 0;
    for(var i in cart.items.entries){
      for(var j in i.value){
        cnt+=j.quantity;
      }
    }
    return cnt;
  }

  int _calculateCartAmount(){
    int cnt = 0;
    for(var i in cart.items.entries){
      for(var j in i.value){
        cnt+=(j.quantity*j.price);
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
    cart = context.read<CartChangeProvider>().cart;
    context.read<OutletMenuBloc>().add(const RefreshMenuEvent());
  }

  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);
    final width = queryData.size.width;
    final height = queryData.size.height;

    //TODO: Add incomplete list
    final List<Widget> stackList = []; // incompleteOrders
    // .map(
    //   (e) => GestureDetector(
    //     onTap: () {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => OrderNumber(orderId: e.id),
    //         ),
    //       );
    //     },
    //     child: Card(
    //         color: const Color(0xFFA3C2B3),
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(10),
    //         ),
    //         child: Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 28.0),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               Center(
    //                   child: (e.orderNumber != null)
    //                       ? Text(
    //                           "Order Number:\n${e.orderNumber.toString()}",
    //                           textAlign: TextAlign.center)
    //                       : const Text("Order Number:\nNot Assigned",
    //                           textAlign: TextAlign.center)),
    //               Center(
    //                   child: Text(
    //                 "Price:\n${e.totalPrice.toString()}",
    //                 textAlign: TextAlign.center,
    //               )),
    //             ],
    //           ),
    //         )),
    //   ),
    // )
    // .toList();

    // TODO: Add current cart's total amount
    // stackList.insert(
    //   0,
    //   ,
    // );

    return Scaffold(
      backgroundColor: const Color(0xFFF9FFFD),
      body: SafeArea(
        child: BlocConsumer<OutletMenuBloc, OutletMenuState>(
          listener: (context, state) {
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
              context.read<CartChangeProvider>().updateCart(state.cart);
            }
          },
          builder: (context, state) {
            if (state is OutletMenuLoading || state is OutletMenuInitial) {
              return const Center(child: CustomLoadingAnimation());
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            "/outletList",
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                              outletName,
                              style: const TextStyle(fontSize: 15),
                            ),
                            const Icon(Icons.expand_more)
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/profile");
                        },
                        child: const Icon(Icons.person),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    0.033333 * width,
                    0,
                    0.033333 * width,
                    0,
                  ),
                  child: (isSearchActive)
                      ? Row(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: const Icon(Icons.arrow_back_ios_new),
                            ),
                            SizedBox(
                              width: 0.80278 * width,
                              height: 0.045 * height,
                              child: TextField(
                                textAlign: TextAlign.start,
                                controller: searchController,
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xFFEAE3E3),
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    suffixIcon: const Icon(Icons.search)),
                                onChanged: (s) {},
                              ),
                            )
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: SizedBox(
                                    width: 0.175 * width,
                                    height: 0.03 * height,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8.0, 0, 0, 0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/images/vegetarian48.png",
                                          ),
                                          // VegetarianSymbol(
                                          //   color: Colors.green,
                                          // ),
                                          const Text("Veg")
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: SizedBox(
                                    width: 0.24444 * width,
                                    height: 0.03 * height,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8.0, 0, 0, 0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          // VegetarianSymbol(
                                          //     color: Colors.red),
                                          Image.asset(
                                              "assets/images/nonvegetarian48.png"),
                                          const Text("Non-Veg"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  isSearchActive = true;
                                });
                              },
                              icon: const Icon(Icons.search),
                            )
                          ],
                        ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      children: [
                        // if(isSearchActive)
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                            0.03333 * width,
                            0.01625 * height,
                            0,
                            0,
                          ),
                          child: SizedBox(
                            width: width,
                            height: 0.13 * height,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: menuList.length,
                              itemBuilder: (context, index) {
                                // return const Text("Pending 1");
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      //TODO theek crow
                                      selectedCategory =
                                          menuList[index].category;
                                    });
                                  },
                                  child: Card(
                                    color: (selectedCategory ==
                                            menuList[index].category)
                                        ? const Color(0xFFA3C2B3)
                                        : Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: SizedBox(
                                      height: double.infinity,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 0.09166666667 * width,
                                              vertical: 0.02125 * height,
                                            ),
                                            child: (menuList[index]
                                                    .iconUrl
                                                    .isEmpty)
                                                ? Image.asset(
                                                    "assets/images/Fast food.png",
                                                  )
                                                : Image.network(
                                                    menuList[index].iconUrl,
                                                    width: 35,
                                                    height: 35,
                                                  ),
                                          ),
                                          Text(
                                            menuList[index].category,
                                            style: TextStyle(
                                              color: (selectedCategory ==
                                                      menuList[index].category)
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        if (selectedCategory == "All")
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                0.052778 * width, 0.02 * height, 0, 0),
                            child: const Row(
                              children: [
                                Text(
                                  "All",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                ),
                              ],
                            ),
                          ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                            0.05278 * width,
                            0.01125 * height,
                            0,
                            0,
                          ),
                          // child: const Text("Category Menu"),
                          child: CategoryMenu(
                            key: UniqueKey(),
                            width: width,
                            height: height,
                            list: (selectedCategory == "All")
                                ? menuList
                                : menuList
                                    .where((element) =>
                                        element.category == selectedCategory)
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
                SizedBox(
                  width: 0.8888888889 * width,
                  height: 0.08625 * height,
                  child: CarouselSlider(
                    items: [
                      GestureDetector(
                        onTap: () async {
                          Navigator.of(context).push<Cart>(
                            MaterialPageRoute(
                              builder: (context) =>
                                  CartPage(list: menuList),
                            ),
                          );
                          // if (newCart != null) {
                          //   setState(() {
                          //     cart = newCart;
                          //   });
                          // }
                        },
                        child: Card(
                          color: const Color(0xFFA3C2B3),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        0.03333 * width, 0, 0.02778 * width, 0),
                                    child: const Icon(
                                      Icons.shopping_cart,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "${_calculateTotalItems()} Items Added",
                                    style: const TextStyle(
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
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.currency_rupee,
                                            size: 14,
                                          ),
                                          Text(
                                            "${_calculateCartAmount()}",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                      const Text(
                                        "Total Amount",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
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
                )
              ],
            );
          },
        ),
      ),
    );
  }

  List<Categories> _searchResult(
    String query,
    List<Categories> categoriesList,
  ) {
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
