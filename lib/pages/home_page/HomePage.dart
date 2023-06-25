import 'dart:developer';
import 'package:flavr/pages/cart/CartPage.dart';
import 'package:flavr/pages/order_history/OrderHistory.dart';
import 'package:flavr/pages/outlet_menu/OutletMenu.dart';
import 'package:flavr/pages/profile_page/ProfiePage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetList = <Widget>[
    OutletMenu(),
    OrderHistory(),
    // CartPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetList.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.home), label: "Menu"),
          BottomNavigationBarItem(
              icon: Image.asset("assets/images/purchase_order.png"),
              label: "Order History"),
          BottomNavigationBarItem(
              icon: _selectedIndex == 2
                  ? const Icon(Icons.shopping_cart)
                  : const Icon(Icons.shopping_cart_outlined),
              label: "Cart"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "Profile")
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            log(_selectedIndex.toString());
          });
        },
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: const Color(0xFF6F5B48),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
