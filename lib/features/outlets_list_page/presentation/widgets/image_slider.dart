import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatelessWidget {
  final double width;
  final double height;
  final List<String> list;

  const ImageSlider({
    super.key,
    required this.width,
    required this.height,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 0.02 * height,
      ),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 0.2665625 * height,
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
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Image.asset(i, fit: BoxFit.fill),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
