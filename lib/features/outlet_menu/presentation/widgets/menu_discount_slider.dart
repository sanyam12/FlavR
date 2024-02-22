import 'package:carousel_slider/carousel_slider.dart';
import 'package:flavr/features/outlets_list_page/presentation/widgets/image_slider.dart';
import 'package:flutter/material.dart';

class MenuDiscountSlider extends StatelessWidget {
  final double width;
  final double height;

  static const List<String> list = [
    "assets/images/discount.webp",
    "assets/images/disc.webp",
  ];

  const MenuDiscountSlider({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final border = BorderRadius.circular(15);
    return Padding(
      padding: EdgeInsets.only(
        top: 0.02 * height,
      ),
      child: ClipRRect(
        borderRadius: border,
        child: CarouselSlider(
          options: CarouselOptions(
            height: 0.1775 * height,
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
    );
  }
}
