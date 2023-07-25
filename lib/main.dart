import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flavr/pages/cart/CartPage.dart';
import 'package:flavr/pages/edit_profile/EditProfile.dart';
import 'package:flavr/pages/google_signin/SignInWithGoogle.dart';
import 'package:flavr/pages/home_page/HomePage.dart';
import 'package:flavr/pages/login_page/LoginPage.dart';
import 'package:flavr/pages/ordernumber/OrderNumber.dart';
import 'package:flavr/pages/otp_screen/OtpScreen.dart';
import 'package:flavr/pages/outlet_menu/OutletMenu.dart';
import 'package:flavr/pages/outlets_list_page/OutletsLists.dart';
import 'package:flavr/pages/outlets_list_page/scan_qr/ScanQR.dart';
import 'package:flavr/pages/payment/payment.dart';
import 'package:flavr/pages/profile_page/ProfiePage.dart';
import 'package:flavr/pages/signup/SignUp.dart';
import 'package:flavr/pages/splashscreen/SplashScreen.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main()async{
  // debugPaintSizeEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

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
      // home: const OrderNumber(orderId: "649fb75aed043cb1e1c0da1f"),
      routes: {
        "/splashscreen": (context)=>const SplashScreen(),
        "/signInWithGoogle":(context)=>const SignInWithGoogle(),
        "/login": (context)=>const LoginPage(),
        "/signUp": (context)=>const SignUp(),
        "/outletList": (context)=> const OutletsList(),
        "/outletList/addOutlet": (context)=> const ScanQRCode(),
        "/outletMenu": (context)=> const OutletMenu(),
        "/homePage": (context)=> const HomePage(),
        //"/cart" : (context) => const CartPage(),
        "/profile": (context)=> const ProfilePage(),
        "/payment": (context)=> const Payment(),
        //"/ordernumber": (context)=> const OrderNumber(),
        "/edit_profile": (context)=> const EditProfile(),
        // "/otp_screen": (context)=> const OtpScreen(),
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
