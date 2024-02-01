import 'package:flutter/material.dart';

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
          size: 36 * 0.75,
        ),
        Icon(
          Icons.circle,
          color: color,
          size: 14 * 0.75,
        ),
      ],
    );
  }
}
