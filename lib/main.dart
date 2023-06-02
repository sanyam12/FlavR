import 'package:flavr/pages/home_page/HomePage.dart';
import 'package:flavr/pages/login_page/LoginPage.dart';
import 'package:flavr/pages/outlet_menu/OutletMenu.dart';
import 'package:flavr/pages/outlets_list_page/OutletsLists.dart';
import 'package:flavr/pages/profile_page/ProfiePage.dart';
import 'package:flavr/pages/signup/SignUp.dart';
import 'package:flavr/pages/splashscreen/SplashScreen.dart';
import 'package:flutter/material.dart';

void main() {
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
        "/login": (context)=>const LoginPage(),
        "/signUp": (context)=>const SignUp(),
        "/outletList": (context)=> const OutletsList(),
        "/outletMenu": (context)=> const OutletMenu(),
        "/homePage": (context)=> const HomePage(),
        "/profile": (context)=> const ProfilePage()
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
