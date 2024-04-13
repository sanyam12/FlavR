import 'package:flavr/core/components/search_bar.dart';
import 'package:flavr/features/outlet_menu/data/models/Categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/menu_screen/outlet_menu_bloc.dart';

class MenuSearchBar extends StatelessWidget {
  final double width;
  final double height;
  final TextEditingController controller;
  final List<Categories> menuList;
  final String vegSelection;

  const MenuSearchBar({
    super.key,
    required this.width,
    required this.height,
    required this.controller,
    required this.menuList,
    required this.vegSelection,
  });

  @override
  Widget build(BuildContext context) {
    return CustomSearchBar(
      width: width,
      height: height,
      controller: controller,
      onChanged: (s) {
        context.read<OutletMenuBloc>().add(SearchQueryEvent(
              menuList,
              vegSelection,
              s,
            ));
      },
    );
  }
}
