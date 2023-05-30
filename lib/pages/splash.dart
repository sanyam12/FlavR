import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DecoratedBox(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/coffee.png"),
                  fit: BoxFit.cover)
          ),
          child: Expanded(
            child: Container(),
          ),
        ),
    );
  }
}
