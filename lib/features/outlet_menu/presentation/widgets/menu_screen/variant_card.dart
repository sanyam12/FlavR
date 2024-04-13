import 'package:flavr/features/outlet_menu/bloc/full_variant_list/variant_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/ProductVariantData.dart';

class VariantCard extends StatelessWidget {
  final double width;
  final double height;
  final ProductVariantData variantData;
  final ProductVariantData selectedVariant;

  const VariantCard({
    super.key,
    required this.width,
    required this.height,
    required this.variantData,
    required this.selectedVariant,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VariantBloc, VariantState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<VariantBloc>().add(
              SelectedVariantUpdated(variantData),
            );
          },
          child: Card(
            color: (variantData.variantName == selectedVariant.variantName)
                ? Colors.grey
                : Colors.white,
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
                    Align(
                      alignment: AlignmentDirectional.bottomStart,
                      child: Wrap(
                        children: [
                          Column(
                            children: [
                              Text(
                                variantData.variantName,
                              ),
                              Text(
                                variantData.price.toString(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
