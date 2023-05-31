import 'dart:developer';
import 'package:flavr/pages/outlet_menu/Categories.dart';
import 'package:flavr/pages/outlet_menu/OutletMenuBloc.dart';
import 'package:flavr/pages/outlet_menu/Product.dart';
import 'package:flutter/material.dart';


//todo add higher quality images or vectors
//todo add loading pages
//todo add default image
//todo outlet button pending
//todo profile button pending
//todo toggle for veg and non veg
//todo change color of navigation and notification bars


class OutletMenu extends StatefulWidget {
  const OutletMenu({Key? key}) : super(key: key);

  @override
  State<OutletMenu> createState() => _OutletMenuState();
}

class _OutletMenuState extends State<OutletMenu> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
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

    // Navigator.pushNamed(context, "/login");

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
                (0.1 * width), (0.03875 * height), (0.1 * width), 0),
            child: Container(
              // color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    // color: Colors.red,
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Outlet",
                          style: TextStyle(
                              fontSize: 20,
                              decoration: TextDecoration.underline),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.expand_more),
                        )
                      ],
                    ),
                  ),
                  CircleAvatar(
                    maxRadius: 30,
                    backgroundColor: Colors.transparent,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 35,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                (0.05278 * width), (0.0225 * height), (0.05278 * width), 0),
            child: TextField(
              controller: searchController,
              onChanged: (String search){
                bloc.searchQuerySink.add(search);
              },
              // style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28.0),
                  ),
                  hintText: "Search in Menu",
                  hintStyle: const TextStyle(color: Colors.black),
                  suffixIcon: const Icon(
                    Icons.search,
                    size: 22,
                  ),
                  isDense: true,
                  prefixIconConstraints:
                      const BoxConstraints(minHeight: 0, minWidth: 0),
                  fillColor: const Color(0xFFFFFAEA),
                  // contentPadding: const EdgeInsets.symmetric(horizontal: 26),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28.0),
                  )),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.fromLTRB((0.0389 * width), (0.0225 * height), 0, 0),
            child: const Row(
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Icon(Icons.crop_square_sharp, color: Colors.green, size: 36,),
                    Icon(Icons.circle, color: Colors.green, size: 14),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                  child: Text(
                    "Veg",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(13.0, 0, 0, 0),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Icon(Icons.crop_square_sharp, color: Colors.red, size: 36,),
                      Icon(Icons.circle, color: Colors.red, size: 14),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                  child: Text(
                    "Non-Veg",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                EdgeInsets.fromLTRB((0.0389 * width), (0.01475 * height), 0, 0),
            child: const Row(
              children: [
                Text(
                  "Recommended for you",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      (0.0333 * width), (0.0175 * height), 0, 0),
                  child: SizedBox(
                    height: (0.08625 * height) + (0.0175 * height),
                    child: StreamBuilder(
                        stream: bloc.productsListStream,
                        builder:
                            (context, AsyncSnapshot<List<Product>> snapshot) {
                          if (snapshot.data != null) {
                            log("data${snapshot.data}");
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return RecommendedItemIcon(
                                    width: width,
                                    height: height,
                                    name: snapshot.data![index].name,
                                  );
                                });
                          } else {
                            return const Center(
                              child: Text("Something Went Wrong!"),
                            );
                          }
                        }),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB((0.013889 * width), 0, 0, 0),
                  child: Stack(
                    children: <Widget>[
                      // Stroked text as border.
                      Text(
                        "Let's Dive In",
                        style: TextStyle(
                            fontSize: 25,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 1
                              ..color =
                                  const Color(0xFF000000).withOpacity(0.3),
                            fontWeight: FontWeight.bold),
                      ),
                      // Solid text as fill.
                      const Text(
                        "Let's Dive In",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: bloc.menuItemsStream,
                    builder:
                        (context, AsyncSnapshot<List<Categories>> snapshot) {
                      if (snapshot.data != null) {
                        List<Widget> columnChild = [];

                        for (var i in snapshot.data!) {
                          List<Widget> menuItems = [];
                          for (var j in i.products) {
                            menuItems.add(
                              MenuItem(
                                width: width,
                                height: height,
                                product: j
                              ),
                            );
                          }
                          columnChild.add(
                            ExpansionTile(
                              title: Text(i.category),
                              children: menuItems
                            ),
                          );
                        }
                        return SingleChildScrollView(
                          child: Column(
                            children: columnChild,
                          ),
                        );
                      } else {
                        return const Text("Something Went Wrong");
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem(
      {Key? key,
      required  this.width,
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
        height: (0.12625 * height),
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
                        padding:
                            EdgeInsets.fromLTRB(0, (0.01375 * height), 0, 0),
                        child: Image.asset((product.veg)?"assets/images/veg_symbol.png" : "assets/images/non_veg_symbol.png"),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.fromLTRB(((0.033 * width)), 0, 0, 0),
                        child: SizedBox(
                          width: (0.51222*width),
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
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                              Text(
                                "₹ ${product.price}",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                product.description,
                                style: const TextStyle(fontSize: 14),
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
                        width: (0.28611 * width),
                        height: (0.1125 * height),
                        child: (product.productImage=="null")?
                        Image.asset("assets/images/google.png"):
                        Image.network(product.productImage),
                        // child: Container(
                        //   decoration: BoxDecoration(
                        //     border: Border.all(width: 1, color: Colors.transparent),
                        //     borderRadius:
                        //         const BorderRadius.all(Radius.circular(200)),
                        //   ),
                        //   child:
                        // ),
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8.0, 8, 8),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 5,
                    margin: EdgeInsets.zero,
                    clipBehavior: Clip.antiAlias,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
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
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecommendedItemIcon extends StatelessWidget {
  const RecommendedItemIcon(
      {Key? key, required this.width, required this.height, required this.name})
      : super(key: key);

  final double width;
  final double height;
  final String name;

  //todo add image and title parameter

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (0.201 * width),
      height: (0.08625 * height),
      child: Column(
        children: [
          SizedBox(
            width: (0.16111 * width),
            height: (0.05625 * height),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.transparent),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Image.asset(
                "assets/images/google.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 6.0, 0, 0),
            child: Text(
              name,
              style: const TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}