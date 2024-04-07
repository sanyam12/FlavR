import 'package:flavr/core/CartChangeProvider.dart';
import 'package:flavr/features/cart/data/models/Cart.dart';
import 'package:flavr/features/cart/data/models/CartVariantData.dart';
import 'package:flavr/features/outlet_menu/bloc/menu_screen/outlet_menu_bloc.dart';
import 'package:flavr/features/outlet_menu/bloc/full_variant_list/variant_bloc.dart';
import 'package:flavr/features/outlet_menu/data/models/ProductVariantData.dart';
import 'package:flavr/features/outlet_menu/presentation/widgets/menu_screen/variant_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/models/Product.dart';

void showFullVariantsList({
  required BuildContext context,
  required double width,
  required double height,
  required Product product,
}) {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return SizedBox(
        height: 0.84875 * height,
        child: FullVariantsList(
          width: width,
          height: height,
          product: product,
        ),
      );
    },
  );
}

class FullVariantsList extends StatefulWidget {
  final double width;
  final double height;
  final Product product;

  const FullVariantsList({
    super.key,
    required this.width,
    required this.height,
    required this.product,
  });

  @override
  State<FullVariantsList> createState() => _FullVariantsListState();
}

class _FullVariantsListState extends State<FullVariantsList> {
  late ProductVariantData selectedVariant = ProductVariantData(
    "default",
    widget.product.price,
  );
  int currentCount = 0;

  int _calculateTotalProductItems(Product product, Cart cart) {
    int count = 0;
    for (var i in cart.items[product] ?? <CartVariantData>[]) {
      count += i.quantity;
    }
    return count;
  }

  sendEvent(OutletMenuEvent event) {
    context.read<OutletMenuBloc>().add(
          event,
        );
  }

  _incrementAmount(Product j, Cart cart) {
    if (j.variantList.isEmpty) {
      sendEvent(
        IncrementAmount(
          j,
          cart,
          ProductVariantData(
            "default",
            j.price,
          ),
        ),
      );
    } else {
      // _showBottomSheet(
      //   title: "Select Items to Add",
      //   product: j,
      //   callback: (name, price) {
      //     sendEvent(
      //       IncrementAmount(
      //         j,
      //         widget.cart,
      //         ProductVariantData(
      //           name,
      //           price,
      //         ),
      //       ),
      //     );
      //   },
      // );
    }
  }

  _decrementAmount(Product j, Cart cart) {
    if (j.variantList.isEmpty) {
      context.read<OutletMenuBloc>().add(
            DecrementAmount(
              j,
              cart,
              ProductVariantData("default", j.price),
            ),
          );
    } else {
      // _showBottomSheet(
      //   title: "Select Items to Remove",
      //   product: j,
      //   callback: (name, price) {
      //     sendEvent(
      //       DecrementAmount(
      //         j,
      //         widget.cart,
      //         ProductVariantData(
      //           name,
      //           price,
      //         ),
      //       ),
      //     );
      //   },
      // );
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<VariantBloc>().add(
          SelectedVariantUpdated(selectedVariant),
        );
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartChangeProvider>().cart;

    if (widget.product.variantList.isNotEmpty) {
      selectedVariant = widget.product.variantList[0];
      context.read<VariantBloc>().add(SelectedVariantUpdated(selectedVariant));
    }
    return BlocConsumer<VariantBloc, VariantState>(
      listener: (context, state) {
        if (state is VariantUpdate) {
          selectedVariant = state.selectedVariant;
        }
        if (state is VariantAmountUpdate) {
          currentCount = state.amount;
        }
      },
      builder: (context, state) {
        return SizedBox(
          height: 0.7875 * widget.height,
          child: Column(
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
              Expanded(
                child: SizedBox(
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 17.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: SizedBox(
                                  width: 0.9027777778 * widget.width,
                                  height: 0.25625 * widget.height,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: _getImage(
                                      width: 0.3555555556 * widget.width,
                                      height: 0.16625 * widget.height,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 18,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.product.name,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Image.asset("assets/images/veg_icon.png"),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: widget.product.description,
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              if (widget.product.variantList.isNotEmpty)
                                Text(
                                  "Variants",
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              SizedBox(
                                width: widget.width,
                                height: 0.115 * widget.height,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: widget.product.variantList.length,
                                  itemBuilder: (context, it) {
                                    final check =
                                        widget.product.variantList[it];
                                    return VariantCard(
                                      width: widget.width,
                                      height: widget.height,
                                      variantData: check,
                                      selectedVariant: selectedVariant,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 26.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    _customButton(
                                      const Icon(Icons.remove),
                                      () {
                                        if (currentCount > 0) {
                                          context.read<VariantBloc>().add(
                                                AmountUpdated(
                                                  currentCount - 1,
                                                ),
                                              );
                                        }
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 14.0,
                                      ),
                                      child: Text(currentCount.toString()),
                                    ),
                                    _customButton(
                                      const Icon(Icons.add),
                                      () {
                                        context.read<VariantBloc>().add(
                                              AmountUpdated(
                                                currentCount + 1,
                                              ),
                                            );
                                      },
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize:
                                        Size(0.4722222222 * widget.width, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor: Colors.black,
                                  ),
                                  onPressed: () {
                                    context.read<OutletMenuBloc>().add(
                                          AddToExistingCart(
                                            widget.product,
                                            cart,
                                            selectedVariant,
                                            currentCount,
                                          ),
                                        );
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Add Item ₹50",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  _getImage({required double width, required double height}) {
    return (widget.product.productImage != "null")
        ? Image.network(
            widget.product.productImage,
            width: width,
            height: height,
            fit: BoxFit.cover,
          )
        : Image.asset(
            "assets/images/pasta.jpeg",
            width: width,
            height: height,
            fit: BoxFit.cover,
          );
  }

  _customButton(Icon icon, void Function() onPressed) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 40,
        minHeight: 40,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: icon,
        ),
      ),
    );
  }
}
