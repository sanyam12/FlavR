import 'package:flutter/material.dart';

class ImageComponent extends StatelessWidget {
  final double width;
  final double height;

  const ImageComponent({super.key, required this.width, required this.height,});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(200),
          bottomRight: Radius.circular(100)
      ),
      child: SizedBox(
        width: width,
        child: Image.asset(
          "assets/images/login_page_image.png",
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
