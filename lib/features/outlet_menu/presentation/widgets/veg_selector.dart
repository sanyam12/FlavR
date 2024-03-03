import 'package:flavr/features/outlet_menu/bloc/outlet_menu_bloc.dart';
import 'package:flavr/features/outlet_menu/data/models/Categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VegSelector extends StatelessWidget {
  final double width;
  final double height;
  final List<Categories> menuList;
  final bool isVegClicked;
  final bool isNonVegClicked;

  const VegSelector({
    super.key,
    required this.width,
    required this.height,
    required this.menuList,
    required this.isNonVegClicked,
    required this.isVegClicked,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(10);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              context
                  .read<OutletMenuBloc>()
                  .add(OnVegClicked(menuList, !isVegClicked));
            },
            child: Container(
              decoration: BoxDecoration(
                color: isVegClicked ? const Color(0xFFF2EFEF) : Colors.white,
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                ),
                borderRadius: borderRadius,
              ),
              child: Card(
                color: isVegClicked ? const Color(0xFFF2EFEF) : Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: borderRadius,
                ),
                child: SizedBox(
                  height: 0.03 * height,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6.0, right: 7),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: GestureDetector(
              onTap: () {
                context
                    .read<OutletMenuBloc>()
                    .add(OnNonVegClicked(menuList, !isNonVegClicked));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isNonVegClicked ? const Color(0xFFF2EFEF) : Colors.white,
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: borderRadius,
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: borderRadius,
                  ),
                  color: isNonVegClicked ? const Color(0xFFF2EFEF) : Colors.white,
                  elevation: 0,
                  child: SizedBox(
                    height: 0.03 * height,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6.0, right: 7),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // VegetarianSymbol(
                          //     color: Colors.red),
                          Image.asset("assets/images/nonvegetarian48.png"),
                          const Text("Non-Veg"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: isNonVegClicked ? const Color(0xFFF2EFEF) : Colors.white,
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: borderRadius,
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: borderRadius,
                  ),
                  color: isNonVegClicked ? const Color(0xFFF2EFEF) : Colors.white,
                  elevation: 0,
                  child: SizedBox(
                    height: 0.03 * height,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 6.0, right: 7),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Price - Low to High",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: isNonVegClicked ? const Color(0xFFF2EFEF) : Colors.white,
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: borderRadius,
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: borderRadius,
                  ),
                  color: isNonVegClicked ? const Color(0xFFF2EFEF) : Colors.white,
                  elevation: 0,
                  child: SizedBox(
                    height: 0.03 * height,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 6.0, right: 7),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Price - High to Low",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
