import 'package:flutter/material.dart';

import '../../data/models/ProductVariantData.dart';

class VariantCard extends StatelessWidget {
  final double width;
  final double height;
  final ProductVariantData variantData;

  const VariantCard({
    super.key,
    required this.width,
    required this.height,
    required this.variantData,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, bottom: 12),
        child: SizedBox(
          width: 0.225 * width,
          height: 0.115 * height,
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 14.0,
                    right: 12,
                  ),
                  child: Image.asset(
                    "assets/images/burger_icon.png",
                  ),
                ),
              ),
              const Align(
                alignment: AlignmentDirectional.bottomStart,
                child: Wrap(
                  children: [
                    Column(
                      children: [Text("Regular"), Text("50")],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
