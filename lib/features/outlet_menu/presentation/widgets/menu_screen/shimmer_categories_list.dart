import 'package:flavr/core/components/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShimmerCategoriesList extends StatefulWidget {
  final double width;
  final double height;

  const ShimmerCategoriesList({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  State<ShimmerCategoriesList> createState() => _ShimmerCategoriesListState();
}

class _ShimmerCategoriesListState extends State<ShimmerCategoriesList> {
  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      isLoading: true,
      child: Padding(
        padding: EdgeInsets.only(
          top: 0.01625 * widget.height,
        ),
        child: SizedBox(
          width: widget.width,
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              for (var i = 0; i < 4; i++)
                Card(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 3,
                  shadowColor: Colors.grey,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minWidth: 90),
                      child: Container(
                        color: Colors.black,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              "assets/images/Fast food.png",
                              width: 45,
                              height: 45,
                              fit: BoxFit.fill,
                            ),
                            Text(
                              "Category",
                              style: TextStyle(
                                color: Colors.white,
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
            ],
          ),
        ),
      ),
    );
  }
}
