import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();

    Timer(
      const Duration(seconds: 3),
      ()async {
        var service =const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));
        String? check = await service.read(key: "token");
        if(check==null){
          if(context.mounted){
            Navigator.popAndPushNamed(context, "/login");
          }
        }else{
          if(context.mounted){
            Navigator.popAndPushNamed(context, "/outletMenu");
          }
        }

      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/coffee.png"), fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            const Center(
              child: Image(image: AssetImage("assets/images/nescafe.png")),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0.0525 * height),
                child: const Text(
                  "It all starts with nescafe",
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
