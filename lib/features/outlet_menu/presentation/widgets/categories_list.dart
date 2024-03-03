import 'package:flavr/features/outlet_menu/data/models/Categories.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesList extends StatefulWidget {
  final double width;
  final double height;
  final List<Categories> filteredMenuList;
  final String selectedCategory;
  final void Function(int) onTap;

  const CategoriesList({
    super.key,
    required this.width,
    required this.height,
    required this.filteredMenuList,
    required this.selectedCategory,
    required this.onTap,
  });

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 0.01625 * widget.height,
      ),
      child: SizedBox(
        width: widget.width,
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.filteredMenuList.length,
          itemBuilder: (context, index) {
            // return const Text("Pending 1");
            return InkWell(
              onTap: () {
                widget.onTap(index);
              },
              child: Card(
                color: (widget.selectedCategory ==
                        widget.filteredMenuList[index].category)
                    ? Colors.black
                    : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
                shadowColor: Colors.grey,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 90
                    ),
                    child: Container(
                      color: (widget.selectedCategory ==
                          widget.filteredMenuList[index].category)
                          ? Colors.black
                          : Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          (widget.filteredMenuList[index].iconUrl.isEmpty)
                              ? Image.asset(
                                  "assets/images/Fast food.png",
                                  width: 45,
                                  height: 45,
                                  fit: BoxFit.fill,
                                )
                              : Image.network(
                                  widget.filteredMenuList[index].iconUrl,
                                  width: 45,
                                  height: 45,
                                  fit: BoxFit.fill,
                                ),
                          Text(
                            widget.filteredMenuList[index].category,
                            style: TextStyle(
                              color: (widget.selectedCategory ==
                                      widget.filteredMenuList[index].category)
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
