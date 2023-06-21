import 'dart:async';
import 'dart:collection';
import 'dart:developer';
import 'package:flavr/pages/cart/CartPage.dart';
import 'package:flavr/pages/cart/CartVariantData.dart';
import 'package:flavr/pages/outlet_menu/Categories.dart';
import 'package:flavr/pages/outlet_menu/Product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cart/Cart.dart';
import 'Outlet.dart';
import 'bloc/outlet_menu_bloc.dart';

//todo add loading pages
//todo profile button pending
//todo toggle for veg and non veg

class OutletMenu extends StatefulWidget {
  const OutletMenu({Key? key}) : super(key: key);

  @override
  State<OutletMenu> createState() => _OutletMenuState();
}

class _OutletMenuState extends State<OutletMenu> {
  final searchController = TextEditingController();
  String outletName = "Outlet";
  final selectedOutletStream = StreamController<String>();
  final productsListStream = StreamController<List<Product>>();
  final menuItemsStream = StreamController<List<Categories>>();
  List<Categories> refreshedMenuItems = [];
  String selectedCategory = "All";
  bool isSearchActive = false;
  Cart cart = Cart();
  int amount = 0;

  @override
  void dispose() {
    searchController.dispose();
    selectedOutletStream.close();
    productsListStream.close();
    menuItemsStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);
    final width = queryData.size.width;
    final height = queryData.size.height;

    late final OutletMenuBloc bloc;

    try {
      bloc = OutletMenuBloc();
    } on Exception catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF9FFFD),
      body: SafeArea(
        child: BlocProvider(
          create: (context) {
            bloc.add(RefreshMenuEvent(cart));
            return bloc;
          },
          child: BlocListener<OutletMenuBloc, OutletMenuState>(
            listener: (context, state) {
              if (state is NavigateToOutletList) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.popAndPushNamed(context, "/outletList");
                });
              }
              else if (state is RefreshedOutletData) {
                menuItemsStream.add(state.menuList);
                productsListStream.add(state.productList);
                selectedOutletStream.add(state.outletName);
                refreshedMenuItems = state.menuList;
                cart = state.cart;
              }
              else if (state is SearchResultState) {
                setState(() {
                  menuItemsStream.add(state.menuList);
                });
              }
              else if (state is AmountUpdatedState) {
                amount = state.amount;
              }
              else if (state is ShowSnackbar) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
              else if (state is UpdatedCartState){
                log("outlet set state");
                setState(() {
                  log("cart state update");
                  cart = state.cart;
                });
              }
            },
            child: StreamBuilder(
              stream: selectedOutletStream.stream,
              builder: (context, AsyncSnapshot<String> snapshot) {
                if (!snapshot.hasData || snapshot.data! == "Outlet") {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return StreamBuilder(
                    stream: menuItemsStream.stream,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Categories>> categoryList) {
                      if (!categoryList.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return StreamBuilder(
                            stream: productsListStream.stream,
                            builder: (context,
                                AsyncSnapshot<List<Product>> productList) {
                              if (!productList.hasData) {
                                return const CircularProgressIndicator();
                              } else {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 19),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                                  snapshot.data!.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 15),
                                                ),
                                                const Icon(Icons.expand_more)
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                              onTap: (){
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
                                                    onTap: () {
                                                      setState(() {
                                                        selectedCategory =
                                                            "All";
                                                        menuItemsStream.add(
                                                            refreshedMenuItems);
                                                        isSearchActive = false;
                                                      });
                                                    },
                                                    child: const Icon(Icons
                                                        .arrow_back_ios_new)),
                                                SizedBox(
                                                  width: 0.80278 * width,
                                                  height: 0.045 * height,
                                                  child: TextField(
                                                    textAlign: TextAlign.start,
                                                    controller:
                                                        searchController,
                                                    decoration: InputDecoration(
                                                        fillColor: Colors.white,
                                                        border: OutlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Color(
                                                                        0xFFEAE3E3)),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        suffixIcon: const Icon(
                                                            Icons.search)),
                                                    onChanged: (s) {
                                                      final list = _searchResult(
                                                          s,
                                                          refreshedMenuItems);
                                                      if (list.isNotEmpty) {
                                                        selectedCategory =
                                                            list[0].category;
                                                      }
                                                      menuItemsStream.add(list);
                                                    },
                                                  ),
                                                )
                                              ],
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7),
                                                      ),
                                                      child: SizedBox(
                                                        width: 0.175 * width,
                                                        height: 0.03 * height,
                                                        child: const Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            VegetarianSymbol(
                                                              color:
                                                                  Colors.green,
                                                            ),
                                                            Text("Veg")
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7),
                                                      ),
                                                      child: SizedBox(
                                                        width: 0.24444 * width,
                                                        height: 0.03 * height,
                                                        child: const Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            VegetarianSymbol(
                                                                color:
                                                                    Colors.red),
                                                            Text("Non-Veg"),
                                                          ],
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
                                                  icon:
                                                      const Icon(Icons.search),
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
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount:
                                                      categoryList.data!.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          selectedCategory =
                                                              categoryList
                                                                  .data![index]
                                                                  .category;
                                                        });
                                                      },
                                                      child: Card(
                                                        color: (selectedCategory ==
                                                                categoryList
                                                                    .data![
                                                                        index]
                                                                    .category)
                                                            ? const Color(
                                                                0xFFA3C2B3)
                                                            : Colors.white,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: SizedBox(
                                                          height:
                                                              double.infinity,
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  horizontal:
                                                                      0.09166666667 *
                                                                          width,
                                                                  vertical:
                                                                      0.02125 *
                                                                          height,
                                                                ),
                                                                child:
                                                                    Image.asset(
                                                                  "assets/images/Fast food.png",
                                                                ),
                                                              ),
                                                              Text(
                                                                categoryList
                                                                    .data![
                                                                        index]
                                                                    .category,
                                                                style:
                                                                    TextStyle(
                                                                  color: (selectedCategory ==
                                                                          categoryList
                                                                              .data![
                                                                                  index]
                                                                              .category)
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
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
                                            if (!isSearchActive)
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                  0.03056 * width,
                                                  0.041667 * height,
                                                  0,
                                                  0,
                                                ),
                                                child: const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Recommended",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            if (!isSearchActive)
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                  0.02125 * height,
                                                  0.02778 * width,
                                                  0,
                                                  0,
                                                ),
                                                child: SizedBox(
                                                    width: width,
                                                    height: 0.3025 * height,
                                                    child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: productList
                                                          .data!.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return SizedBox(
                                                          width: 0.4944 * width,
                                                          height:
                                                              0.2625 * height,
                                                          child:
                                                              RecommendedItemIcon(
                                                            width: width,
                                                            height: height,
                                                            product: productList
                                                                .data![index],
                                                            bloc: bloc,
                                                            cart: cart,
                                                            updateParentState:
                                                                () {
                                                              setState(() {});
                                                            },
                                                          ),
                                                        );
                                                      },
                                                    )),
                                              ),
                                            if (selectedCategory == "All")
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0.052778 * width,
                                                    0.02 * height,
                                                    0,
                                                    0),
                                                child: const Row(
                                                  children: [
                                                    Text(
                                                      "All",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                  0),
                                              child: CategoryMenu(
                                                width: width,
                                                height: height,
                                                list: (selectedCategory ==
                                                        "All")
                                                    ? categoryList.data!
                                                    : categoryList.data!
                                                        .where((element) =>
                                                            element.category ==
                                                            selectedCategory)
                                                        .toList(),
                                                bloc: bloc,
                                                cart: cart,
                                                updateParentState: () {
                                                  setState(() {});
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 0.8888888889 * width,
                                      height: 0.08625 * height,
                                      child: GestureDetector(
                                        onTap: () async {

                                          final newCart =
                                              await Navigator.of(context)
                                                  .push<Cart>(
                                            MaterialPageRoute(
                                              builder: (context) => CartPage(
                                                initialCart: cart,
                                              ),
                                            )
                                          );
                                          if (newCart != null) {
                                            setState(() {
                                              cart = newCart;
                                            });
                                          }
                                        },
                                        child: Card(
                                          color: const Color(0xFFA3C2B3),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0.03 * width, 0, 0, 0),
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          Colors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10))),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pushNamed("/payment");
                                                  },
                                                  child: const Text(
                                                    "Place Order",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0,
                                                    0,
                                                    0.08333333333 * width,
                                                    0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      "Total Amount",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.currency_rupee,
                                                          color: Colors.white,
                                                        ),
                                                        Text(
                                                          amount.toString(),
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 24,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              }
                            });
                      }
                    },
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  List<Categories> _searchResult(
      String query, List<Categories> categoriesList) {
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
              .toList());
      if (temp.products.isNotEmpty) {
        list.add(temp);
      }
    }
    return list;
  }
}

class CategoryMenu extends StatefulWidget {
  const CategoryMenu(
      {super.key,
      required this.width,
      required this.height,
      required this.list,
      required this.bloc,
      required this.cart,
      required this.updateParentState});

  final double width;
  final double height;
  final List<Categories> list;
  final OutletMenuBloc bloc;
  final Cart cart;
  final void Function() updateParentState;

  @override
  State<CategoryMenu> createState() => _CategoryMenuState();
}

class _CategoryMenuState extends State<CategoryMenu> {
  String itemCounter(HashMap<String, CartVariantData> list){
    int count = 0;
    list.forEach((key, value) {
      count+=value.quantity;
    });
    return count.toString();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    bool check = (widget.list.length > 1);
    for (var i in widget.list) {
      if (check && i.category != "All") {
        children.add(
          Row(
            children: [
              Text(
                i.category,
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        );
      }
      for (var j in i.products) {
        children.add(
          SizedBox(
            width: 0.8888 * widget.width,
            height: 0.1575 * widget.height,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  width: 0.8888 * widget.width,
                  height: 0.1575 * widget.height,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 0.2861 * widget.width,
                          height: 0.1275 * widget.height,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: SizedBox(
                                      width: 0.2861 * widget.width,
                                      height: 0.1025 * widget.height,
                                      child: (j.productImage != "null")
                                          ? Image.network(j.productImage)
                                          : Image.asset(
                                              "assets/images/pasta.jpeg",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: SizedBox(
                                  width: 0.205556 * widget.width,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: Color(0xFF004932), width: 1),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 0.06777 * widget.width,
                                            height: 0.03125 * widget.height,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color(0xFFD6EAE1),
                                                  padding: EdgeInsets.zero),
                                              onPressed: () {
                                                setState(() {
                                                  if(j.variantList.isNotEmpty){
                                                    showBottomSheet(
                                                        context: context,
                                                        backgroundColor: const Color(0xFFA3C2B3),
                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                        builder: (context){
                                                          final List<Widget> list = [];
                                                          list.add(
                                                              ListTile(
                                                                title: Title(color: Colors.black, child: const Text("Select Items to Remove")),
                                                              )
                                                          );
                                                          for(var variant in j.variantList){
                                                            list.add(
                                                                ListTile(
                                                                  title: Text(variant.variantName),
                                                                  trailing: Text(variant.price.toString()),
                                                                  onTap: (){
                                                                    if(widget.cart.items[j.id] != null && widget.cart.items[j.id]![variant.variantName] != null && widget.cart.items[j.id]![variant.variantName]!.quantity>0){
                                                                      widget.cart.items[j.id]![variant.variantName]!.quantity--;
                                                                    }
                                                                    widget.bloc.add(
                                                                      UpdateCartEvent(
                                                                        j,
                                                                        widget.cart,
                                                                      ),
                                                                    );
                                                                    widget.updateParentState();
                                                                    Navigator.pop(context);
                                                                  },
                                                                )
                                                            );
                                                          }
                                                          return Wrap(
                                                            children: list,
                                                          );
                                                        }
                                                    );
                                                  }
                                                  else{
                                                    if(widget.cart.items[j.id] != null && widget.cart.items[j.id]!["default"] != null && widget.cart.items[j.id]!["default"]!.quantity>0){
                                                      widget.cart.items[j.id]!["default"]!.quantity--;
                                                    }
                                                    widget.bloc.add(
                                                      UpdateCartEvent(
                                                        j,
                                                        widget.cart,
                                                      ),
                                                    );
                                                    widget.updateParentState();
                                                  }

                                                });
                                              },
                                              child: const Icon(
                                                Icons.remove,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Text((widget.cart.items[j.id] == null)
                                              ? "0"
                                              : itemCounter(widget.cart.items[j.id]!)
                                          ),
                                          SizedBox(
                                            width: 0.06777 * widget.width,
                                            height: 0.03125 * widget.height,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color(0xFFD6EAE1),
                                                  padding: EdgeInsets.zero),
                                              onPressed: () {
                                                setState(() {
                                                  if(j.variantList.isNotEmpty){
                                                    showBottomSheet(
                                                        context: context,
                                                        backgroundColor: const Color(0xFFA3C2B3),
                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                        builder: (context){
                                                          final List<Widget> list = [];
                                                          for(var variant in j.variantList){
                                                            list.add(
                                                                ListTile(
                                                                  title: Text(variant.variantName),
                                                                  trailing: Text(variant.price.toString()),
                                                                  onTap: (){
                                                                    if(widget.cart.items[j.id]!=null){
                                                                      if(widget.cart.items[j.id]![variant.variantName]!=null){
                                                                        widget.cart.items[j.id]![variant.variantName]!.quantity++;
                                                                      }else{
                                                                        widget.cart.items[j.id]![variant.variantName] = CartVariantData(variant.variantName, 1);
                                                                      }
                                                                    }else{
                                                                      final temp = HashMap<String, CartVariantData>();
                                                                      temp[variant.variantName] = CartVariantData(variant.variantName, 1);
                                                                      widget.cart.items[j.id] = temp;
                                                                    }
                                                                    widget.bloc.add(
                                                                      UpdateCartEvent(
                                                                        j,
                                                                        widget.cart,
                                                                      ),
                                                                    );
                                                                    widget.updateParentState();
                                                                    Navigator.pop(context);
                                                                  },
                                                                )
                                                            );
                                                          }
                                                          return Wrap(
                                                            children: list,
                                                          );
                                                        }
                                                    );
                                                  }
                                                  else{
                                                    if(widget.cart.items[j.id]!=null){
                                                      if(widget.cart.items[j.id]!["default"]!=null){
                                                        widget.cart.items[j.id]!["default"]!.quantity++;
                                                      }else{
                                                        widget.cart.items[j.id]!["default"] = CartVariantData("default", 1);
                                                      }
                                                    } else{
                                                      final temp = HashMap<String, CartVariantData>();
                                                      temp["default"] = CartVariantData("default", 1);
                                                      widget.cart.items[j.id] = temp;
                                                    }
                                                    widget.bloc.add(
                                                      UpdateCartEvent(
                                                        j,
                                                        widget.cart,
                                                      ),
                                                    );
                                                    widget.updateParentState();
                                                  }
                                                });
                                              },
                                              child: const Icon(
                                                Icons.add,
                                                color: Colors.black,
                                              ),
                                            ),
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
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              0.0611 * widget.width, 0, 0, 0),
                          child: SizedBox(
                            width: 0.456 * widget.width,
                            height: 0.08625 * widget.height,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    VegetarianSymbol(
                                        color:
                                            j.veg ? Colors.green : Colors.red),
                                    SizedBox(
                                      width: 0.38 * widget.width,
                                      child: Text(
                                        j.name,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.fromLTRB(
                                          0.0566 * widget.width, 0, 0, 0),
                                      width: 0.4 * widget.width,
                                      child: Text(
                                        "₹${j.price}",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 0.4 * widget.width,
                                      padding: EdgeInsets.fromLTRB(
                                          0.0566 * widget.width, 0, 0, 0),
                                      child: Text(
                                        j.description,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }
    }

    return Column(
      children: children,
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem(
      {Key? key,
      required this.width,
      required this.height,
      required this.product})
      : super(key: key);

  final double width;
  final double height;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: (0.0388 * width)),
      child: SizedBox(
        height: (0.15625 * height),
        child: Card(
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            0.012 * width, (0.01375 * height), 0, 0),
                        child: (product.veg)
                            ? const Stack(
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
                              )
                            : const Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  Icon(
                                    Icons.crop_square_sharp,
                                    color: Colors.red,
                                    size: 25,
                                  ),
                                  Icon(Icons.circle,
                                      color: Colors.red, size: 10),
                                ],
                              ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.fromLTRB(((0.033 * width)), 0, 0, 0),
                        child: SizedBox(
                          width: (0.51222 * width),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    0, (0.01125 * height), 0, 0),
                                child: Text(
                                  product.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                                child: Text(
                                  "₹ ${product.price}",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                product.description,
                                style: const TextStyle(fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        width: (0.25 * width),
                        height: (0.3125 * height),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            (product.productImage == "null")
                                ? Image.asset(
                                    "assets/images/hamburger.jpg",
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(product.productImage),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 5,
                              margin: EdgeInsets.zero,
                              clipBehavior: Clip.antiAlias,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 34,
                                      height: 34,
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        onPressed: () {},
                                        icon: const Center(
                                          child: Icon(
                                            Icons.remove,
                                            size: 34,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Text("1"),
                                    SizedBox(
                                      width: 34,
                                      height: 34,
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        onPressed: () {},
                                        icon: const Center(
                                          child: Icon(
                                            Icons.add,
                                            size: 34,
                                          ),
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
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VegetarianSymbol extends StatelessWidget {
  const VegetarianSymbol({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Icon(
          Icons.crop_square_sharp,
          color: color,
          size: 30,
        ),
        Icon(
          Icons.circle,
          color: color,
          size: 10,
        ),
      ],
    );
  }
}

class RecommendedItemIcon extends StatefulWidget {
  const RecommendedItemIcon(
      {Key? key,
      required this.width,
      required this.height,
      required this.product,
      required this.cart,
      required this.bloc,
      required this.updateParentState})
      : super(key: key);

  final double width;
  final double height;
  final Product product;
  final Cart cart;
  final OutletMenuBloc bloc;
  final void Function() updateParentState;

  @override
  State<RecommendedItemIcon> createState() => _RecommendedItemIconState();
}

class _RecommendedItemIconState extends State<RecommendedItemIcon> {
  //todo add image and title parameter
  String itemCounter(HashMap<String, CartVariantData> list){
    int count = 0;
    list.forEach((key, value) {
      count+=value.quantity;
    });
    return count.toString();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SizedBox(
        width: 0.4944 * widget.width,
        height: 0.2625 * widget.height,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0.03125 * widget.height, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const VegetarianSymbol(color: Colors.green),
                  SizedBox(
                    width: 0.4 * widget.width,
                    child: Text(
                      widget.product.name,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
            const Text("₹ 40"),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0.0125 * widget.height, 0, 0),
              child: SizedBox(
                width: 0.2861 * widget.width,
                height: 0.1125 * widget.height,
                child: Image.asset("assets/images/pasta.jpeg"),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Color(0xFF004932), width: 1),
                  borderRadius: BorderRadius.circular(5)),
              child: SizedBox(
                width: 0.20556 * widget.width,
                height: 0.03125 * widget.height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 0.07778 * widget.width,
                      height: double.infinity,
                      child: ElevatedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: const Color(0xFFD6EAE1),
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            elevation: 0),
                        onPressed: () {
                          setState(() {
                            if(widget.product.variantList.isNotEmpty){
                              showBottomSheet(
                                  context: context,
                                  backgroundColor: const Color(0xFFA3C2B3),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  builder: (context){
                                    final List<Widget> list = [];
                                    for(var variant in widget.product.variantList){
                                      list.add(
                                          ListTile(
                                            title: Text(variant.variantName),
                                            trailing: Text(variant.price.toString()),
                                            onTap: (){
                                              if(widget.cart.items[widget.product.id] != null && widget.cart.items[widget.product.id]![variant.variantName] != null && widget.cart.items[widget.product.id]![variant.variantName]!.quantity>0){
                                                widget.cart.items[widget.product.id]![variant.variantName]!.quantity--;
                                              }
                                              widget.bloc.add(
                                                UpdateCartEvent(
                                                  widget.product,
                                                  widget.cart,
                                                ),
                                              );
                                              widget.updateParentState();
                                              Navigator.pop(context);
                                            },
                                          )
                                      );
                                    }
                                    return Wrap(
                                      children: list,
                                    );
                                  }
                              );
                            } else{
                              if(widget.cart.items[widget.product.id] != null && widget.cart.items[widget.product.id]!["default"] != null && widget.cart.items[widget.product.id]!["default"]!.quantity>0){
                                widget.cart.items[widget.product.id]!["default"]!.quantity--;
                              }
                              widget.bloc.add(
                                UpdateCartEvent(
                                  widget.product,
                                  widget.cart,
                                ),
                              );
                              widget.updateParentState();
                            }
                          });
                        },
                        child: const Center(
                          child: Icon(
                            Icons.remove,
                            size: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Text((widget.cart.items[widget.product.id] == null)
                        ? "0"
                        : itemCounter(widget.cart.items[widget.product.id]!),
                    ),
                    SizedBox(
                      width: 0.07778 * widget.width,
                      height: double.infinity,
                      child: ElevatedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: const Color(0xFFD6EAE1),
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            elevation: 0),
                        onPressed: () {
                          setState(() {
                            if(widget.product.variantList.isNotEmpty){
                              showBottomSheet(
                                  context: context,
                                  backgroundColor: const Color(0xFFA3C2B3),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  builder: (context){
                                    final List<Widget> list = [];
                                    for(var variant in widget.product.variantList){
                                      list.add(
                                          ListTile(
                                            title: Text(variant.variantName),
                                            trailing: Text(variant.price.toString()),
                                            onTap: (){
                                              if(widget.cart.items[widget.product.id]!=null){
                                                if(widget.cart.items[widget.product.id]![variant.variantName]!=null){
                                                  widget.cart.items[widget.product.id]![variant.variantName]!.quantity++;
                                                }else{
                                                  widget.cart.items[widget.product.id]![variant.variantName] = CartVariantData(variant.variantName, 1);
                                                }
                                              }else{
                                                final temp = HashMap<String, CartVariantData>();
                                                temp[variant.variantName] = CartVariantData(variant.variantName, 1);
                                                widget.cart.items[widget.product.id] = temp;
                                              }
                                              widget.bloc.add(
                                                UpdateCartEvent(
                                                  widget.product,
                                                  widget.cart,
                                                ),
                                              );
                                              widget.updateParentState();
                                              Navigator.pop(context);
                                            },
                                          )
                                      );
                                    }
                                    return Wrap(
                                      children: list,
                                    );
                                  }
                              );
                            }
                            else{
                              log("else check add");
                              if(widget.cart.items[widget.product.id]!=null){
                                if(widget.cart.items[widget.product.id]!["default"]!=null){
                                  widget.cart.items[widget.product.id]!["default"]!.quantity++;
                                }else{
                                  widget.cart.items[widget.product.id]!["default"] = CartVariantData("default", 1);
                                }
                              }else{
                                final temp = HashMap<String, CartVariantData>();
                                temp["default"] = CartVariantData("default", 1);
                                widget.cart.items[widget.product.id] = temp;
                              }
                              widget.bloc.add(
                                UpdateCartEvent(
                                  widget.product,
                                  widget.cart,
                                ),
                              );
                              widget.updateParentState();
                            }
                          });
                        },
                        child: const Icon(
                          Icons.add,
                          size: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//StreamBuilder(
//               stream: selectedOutletStream.stream,
//               builder: (context, AsyncSnapshot<String> snapshot) {
//                 if (!snapshot.hasData) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (snapshot.data! == "Outlet") {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else {
//                   outletName = snapshot.data!;
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(
//                             (0.05 * width), (0 * height), (0.05 * width), 0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             InkWell(
//                               onTap: () {
//                                 Navigator.of(context).pushNamed("/outletList");
//                               },
//                               child: Row(
//                                 // crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     outletName,
//                                     style: const TextStyle(
//                                       fontSize: 20,
//                                       decoration: TextDecoration.underline,
//                                     ),
//                                   ),
//                                   Icon(Icons.expand_more)
//                                 ],
//                               ),
//                             ),
//                             CircleAvatar(
//                               maxRadius: 30,
//                               backgroundColor: Colors.transparent,
//                               child: IconButton(
//                                 onPressed: () {},
//                                 icon: const Icon(
//                                   Icons.person,
//                                   color: Colors.black,
//                                   size: 35,
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.fromLTRB((0.05278 * width),
//                             (0.012 * height), (0.05278 * width), 0),
//                         child: TextField(
//                           controller: searchController,
//                           onChanged: (String search) {
//                             bloc.add(SearchQueryEvent(search));
//                           },
//                           decoration: InputDecoration(
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(28.0),
//                               ),
//                               hintText: "Search in Menu",
//                               hintStyle: const TextStyle(color: Colors.black),
//                               suffixIcon: const Icon(
//                                 Icons.search,
//                                 size: 22,
//                               ),
//                               isDense: true,
//                               prefixIconConstraints: const BoxConstraints(
//                                   minHeight: 0, minWidth: 0),
//                               fillColor: const Color(0xFFFFFAEA),
//                               // contentPadding: const EdgeInsets.symmetric(horizontal: 26),
//                               filled: true,
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(28.0),
//                               )),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(
//                             (0.0389 * width), (0.0225 * height), 0, 0),
//                         child: const Row(
//                           children: [
//                             Stack(
//                               alignment: AlignmentDirectional.center,
//                               children: [
//                                 Icon(
//                                   Icons.crop_square_sharp,
//                                   color: Colors.green,
//                                   size: 30,
//                                 ),
//                                 Icon(Icons.circle,
//                                     color: Colors.green, size: 10),
//                               ],
//                             ),
//                             Padding(
//                               padding: EdgeInsets.fromLTRB(8.0, 0, 0, 0),
//                               child: Text(
//                                 "Veg",
//                                 style: TextStyle(fontSize: 14),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.fromLTRB(13.0, 0, 0, 0),
//                               child: Stack(
//                                 alignment: AlignmentDirectional.center,
//                                 children: [
//                                   Icon(
//                                     Icons.crop_square_sharp,
//                                     color: Colors.red,
//                                     size: 30,
//                                   ),
//                                   Icon(Icons.circle,
//                                       color: Colors.red, size: 10),
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.fromLTRB(8.0, 0, 0, 0),
//                               child: Text(
//                                 "Non-Veg",
//                                 style: TextStyle(fontSize: 14),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(
//                             (0.0389 * width), (0.01475 * height), 0, 0),
//                         child: const Row(
//                           children: [
//                             Text(
//                               "Recommended for you",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 18),
//                             )
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.fromLTRB(
//                                   (0.0333 * width), (0.0175 * height), 0, 0),
//                               child: SizedBox(
//                                 height: (0.08625 * height) + (0.0175 * height),
//                                 child: StreamBuilder(
//                                     stream: productsListStream.stream,
//                                     builder: (context,
//                                         AsyncSnapshot<List<Product>> snapshot) {
//                                       if (snapshot.data != null) {
//                                         return ListView.builder(
//                                             scrollDirection: Axis.horizontal,
//                                             itemCount: snapshot.data!.length,
//                                             itemBuilder: (context, index) {
//                                               return RecommendedItemIcon(
//                                                 width: width,
//                                                 height: height,
//                                                 name:
//                                                     snapshot.data![index].name,
//                                               );
//                                             });
//                                       } else {
//                                         return const Center(
//                                           child: Text("Something Went Wrong!"),
//                                         );
//                                       }
//                                     }),
//                               ),
//                             ),
//                             Padding(
//                               padding:
//                                   EdgeInsets.fromLTRB((0.05 * width), 0, 0, 0),
//                               child: Stack(
//                                 children: <Widget>[
//                                   // Stroked text as border.
//                                   Text(
//                                     "Let's Dive In",
//                                     style: TextStyle(
//                                         fontSize: 25,
//                                         foreground: Paint()
//                                           ..style = PaintingStyle.stroke
//                                           ..strokeWidth = 1
//                                           ..color = const Color(0xFF000000)
//                                               .withOpacity(0.3),
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   // Solid text as fill.
//                                   const Text(
//                                     "Let's Dive In",
//                                     style: TextStyle(
//                                         fontSize: 25,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Expanded(
//                               child: StreamBuilder(
//                                 stream: menuItemsStream.stream,
//                                 builder: (context,
//                                     AsyncSnapshot<List<Categories>> snapshot) {
//                                   if (snapshot.data != null) {
//                                     List<Widget> columnChild = [];
//
//                                     for (var i in snapshot.data!) {
//                                       List<Widget> menuItems = [];
//                                       for (var j in i.products) {
//                                         menuItems.add(
//                                           MenuItem(
//                                               width: width,
//                                               height: height,
//                                               product: j),
//                                         );
//                                       }
//                                       columnChild.add(
//                                         Theme(
//                                           data: Theme.of(context).copyWith(
//                                               dividerColor: Colors.transparent),
//                                           child: ExpansionTile(
//                                               initiallyExpanded: true,
//                                               textColor: Colors.black,
//                                               collapsedTextColor: Colors.black,
//                                               collapsedIconColor: Colors.black,
//                                               iconColor: Colors.black,
//                                               title: Text(i.category),
//                                               children: menuItems),
//                                         ),
//                                       );
//                                     }
//                                     return SingleChildScrollView(
//                                       child: Column(
//                                         children: columnChild,
//                                       ),
//                                     );
//                                   } else {
//                                     return const Text("Something Went Wrong");
//                                   }
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   );
//                 }
//               },
//             )
