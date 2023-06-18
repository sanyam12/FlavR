import 'package:flavr/pages/cart/CartPage.dart';
import 'package:flavr/pages/google_signin/SignInWithGoogle.dart';
import 'package:flavr/pages/home_page/HomePage.dart';
import 'package:flavr/pages/login_page/LoginPage.dart';
import 'package:flavr/pages/ordernumber/OrderNumber.dart';
import 'package:flavr/pages/outlet_menu/OutletMenu.dart';
import 'package:flavr/pages/outlets_list_page/OutletsLists.dart';
import 'package:flavr/pages/outlets_list_page/scan_qr/ScanQR.dart';
import 'package:flavr/pages/payment/payment.dart';
import 'package:flavr/pages/profile_page/ProfiePage.dart';
import 'package:flavr/pages/signup/SignUp.dart';
import 'package:flavr/pages/splashscreen/SplashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        // useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/splashscreen",
      routes: {
        "/splashscreen": (context)=>const SplashScreen(),
        "/signInWithGoogle":(context)=>const SignInWithGoogle(),
        "/login": (context)=>const LoginPage(),
        "/signUp": (context)=>const SignUp(),
        "/outletList": (context)=> const OutletsList(),
        "/outletList/addOutlet": (context)=> const ScanQRCode(),
        "/outletMenu": (context)=> const OutletMenu(),
        "/homePage": (context)=> const HomePage(),
        // "/cart" : (context) => const CartPage(),
        "/profile": (context)=> const ProfilePage(),
        "/payment": (context)=> const Payment(),
        // "/ordernumber": (context)=> const OrderNumber()
      },
    );
  }
}


class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
