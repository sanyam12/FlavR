import 'package:flavr/core/components/shimmer_loading.dart';
import 'package:flavr/features/outlet_menu/presentation/widgets/shimmer_menu_item.dart';
import 'package:flutter/material.dart';

class ShimmerCategoryMenu extends StatefulWidget {
  const ShimmerCategoryMenu({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  State<ShimmerCategoryMenu> createState() => _ShimmerCategoryMenuState();
}

class _ShimmerCategoryMenuState extends State<ShimmerCategoryMenu> {
  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      isLoading: true,
      child: Column(
        children: [
          for (int i = 0; i < 6; i++)
            ShimmerMenuItem(
              width: widget.width,
              height: widget.height,
            ),
        ],
      ),
    );
  }
}
