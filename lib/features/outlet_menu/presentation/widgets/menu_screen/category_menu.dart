import 'package:flavr/core/components/rule_text_component.dart';
import 'package:flavr/features/cart/data/models/Cart.dart';
import 'package:flavr/features/outlet_menu/presentation/widgets/menu_screen/menu_item.dart';
import 'package:flutter/material.dart';
import '../../../data/models/Categories.dart';

class CategoryMenu extends StatefulWidget {
  const CategoryMenu({
    super.key,
    required this.width,
    required this.height,
    required this.list,
    required this.cart,
    required this.amount,
  });

  final double width;
  final double height;
  final List<Categories> list;
  final Cart cart;

  final int amount;

  @override
  State<CategoryMenu> createState() => _CategoryMenuState();
}

class _CategoryMenuState extends State<CategoryMenu> {

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (var i in widget.list) {
      if (i.products.isNotEmpty && i.category != "All") {
        children.add(
          RuleTextComponent(
            width: widget.width,
            height: widget.height,
            text: i.category,
            horizontalPadding: 0.09722222222 * widget.width,
            verticalPadding: 11,
          ),
        );
      }
      for (var j in i.products) {
        children.add(
          MenuItem(
            width: widget.width,
            height: widget.height,
            product: j,
            cart: widget.cart,
          ),
        );
      }
    }

    return Column(
      children: children,
    );
  }
}
