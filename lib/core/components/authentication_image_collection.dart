import 'package:flutter/cupertino.dart';

class AuthenticationImageCollection {
  static List<Widget> build(double width, double height) {
    return <Widget>[
      Positioned(
        top: (-0.10875 * height),
        left: (-0.080556 * width),
        child: Image.asset(
          "assets/images/pizza.jpg",
          width: (0.6527777778 * width),
        ),
      ),
      Positioned(
        top: (-0.10875 * height),
        left: (0.5722222222 * width),
        child: Transform.rotate(
          angle: 86.84,
          child: Image.asset(
            "assets/images/noodles.jpeg",
            width: (0.655556 * width),
            height: (0.19625 * height),
          ),
        ),
      ),
      Positioned(
        top: 0.2675 * height,
        left: -0.3333 * width,
        child: Image.asset(
          "assets/images/pasta.jpeg",
          width: (0.83333 * width),
        ),
      ),
      Positioned(
        top: 0.2204 * height,
        left: 0.62588889 * width,
        child: Transform.rotate(
          angle: -3.55,
          child: Image.asset(
            "assets/images/sandwich.jpeg",
            width: (0.6555555556 * width),
          ),
        ),
      ),
      SizedBox(
        width: width,
        height: height,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Positioned(
              top: 0.18 * height,
              child: SizedBox(
                width: 0.26667 * width,
                // height: 0.03*height,
                child: Image.asset(
                  "assets/images/flavr-logo.png",
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }
}
