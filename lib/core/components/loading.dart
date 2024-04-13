import 'package:flutter/material.dart';

class CustomLoadingAnimation extends StatelessWidget {
  const CustomLoadingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Center(
        child: Image.asset("assets/gif/spinner.gif"),
      ),
    );
  }
}
