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
    return SizedBox(
      height: 0.52125 * height,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0.555*width),
            ),
            child: SizedBox(
              width: 0.4972 * width,
              height: 0.52125 * height,
              child: Image.asset(
                "assets/images/google_signin_image_1.webp",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: 0.475 * width,
                  height: 0.34375 * height,
                  child: Image.asset(
                    "assets/images/google_signin_image_2.webp",
                    fit: BoxFit.cover,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(0.204167*width),
                  ),
                  child: SizedBox(
                    width: 0.475 * width,
                    height: 0.16375 * height,
                    child: Image.asset(
                      "assets/images/google_signin_image_2.webp",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
