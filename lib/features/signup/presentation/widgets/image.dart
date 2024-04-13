import 'package:flutter/material.dart';

class ImageCollection extends StatelessWidget {
  final double width;
  final double height;

  const ImageCollection({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(width / 2),
        bottomLeft: Radius.circular(width / 2),
      ),
      child: SizedBox(
        width: width,
        child: Image.asset(
          "assets/images/signup_page_image.webp",
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
