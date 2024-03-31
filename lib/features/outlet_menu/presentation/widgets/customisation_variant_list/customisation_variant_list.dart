import 'package:flavr/core/components/button.dart';
import 'package:flavr/core/components/button_types.dart';
import 'package:flavr/features/cart/data/models/Cart.dart';
import 'package:flavr/features/outlet_menu/bloc/menu_screen/outlet_menu_bloc.dart';
import 'package:flavr/features/outlet_menu/data/models/Product.dart';
import 'package:flavr/features/outlet_menu/presentation/widgets/full_variant_list/full_variant_list.dart';
import 'package:flavr/features/outlet_menu/presentation/widgets/customisation_variant_list/variant_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showCustomisationVariantsList({
  required BuildContext context,
  required double width,
  required double height,
  required Product product,
  required Cart cart,
  required bool allowNewVariantButton,
}) {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return CustomisationVariantsList(
        width: width,
        height: height,
        product: product,
        cart: cart,
        allowNewVariantButton: allowNewVariantButton,
      );
    },
  );
}

class CustomisationVariantsList extends StatefulWidget {
  final double width;
  final double height;
  final Product product;
  final bool allowNewVariantButton;
  final Cart cart;

  const CustomisationVariantsList({
    super.key,
    required this.width,
    required this.height,
    required this.product,
    required this.cart,
    required this.allowNewVariantButton,
  });

  @override
  State<CustomisationVariantsList> createState() =>
      _CustomisationVariantsListState();
}

class _CustomisationVariantsListState extends State<CustomisationVariantsList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OutletMenuBloc, OutletMenuState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 9.0,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const CircleAvatar(
                  backgroundColor: Color(0xFFF2F1F1),
                  child: Icon(
                    Icons.close,
                    size: 20,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: widget.width,
              child: Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    25,
                  ),
                ),
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 17.0, vertical: 0.02625 * widget.height),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text(
                              "Found a variant of the item in the cart, wanna repeat the same?"),
                          ..._getList(),
                          if (widget.allowNewVariantButton)
                            ButtonComponent(
                              text: "Add New Variant",
                              width: widget.width,
                              height: widget.height,
                              type: ButtonType.LongButton,
                              onPressed: () {
                                Navigator.pop(context);
                                showFullVariantsList(
                                  context: context,
                                  width: widget.width,
                                  height: widget.height,
                                  product: widget.product,
                                );
                              },
                            ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  _getList() {
    final List<Widget> list = [];
    if (widget.cart.items[widget.product] != null) {
      for (var i in widget.cart.items[widget.product]!) {
        if (i.quantity != 0) {
          list.add(
            VariantItem(
              product: widget.product,
              variantData: i,
              cart: widget.cart,
            ),
          );
        }
      }
    }
    return list;
  }
}
