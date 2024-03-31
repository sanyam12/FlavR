part of 'outlet_menu_bloc.dart';

List<Categories> _filter(
  List<Categories> menuList,
    String vegSelection,
    String query
) {
  // String newSelection = "veg";
  // if(event.vegSelection=="veg"){
  //   newSelection = "normal";
  // }
  //
  // if (newSelection=="veg") {
  final list = <Categories>[Categories("All", [], "")];
  for (var i in menuList) {
    final category = Categories(
      i.category,
      i.products,
      i.iconUrl,
    );
    category.products = category.products.where((element) {
      return (_getVegFilterBool(vegSelection, element.veg) &&
          element.name.toLowerCase().contains(query.toLowerCase()));
    }).toList();
    if (category.products.isNotEmpty) {
      list.add(category);
    }
  }
  return list;
  // emit(
  //   FilterResultState(
  //     menuList: list,
  //     vegSelection: event.vegSelection,
  //   ),
  // );
  // } else {
  //   emit(VegFilterTriggered(event.menuList, newSelection));
  // }
}

bool _getVegFilterBool(String vegSelection, bool veg) {
  if (vegSelection == "normal") {
    return true;
  } else if (vegSelection == "veg") {
    return veg == true;
  } else {
    return veg == false;
  }
}
