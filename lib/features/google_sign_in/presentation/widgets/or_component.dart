import 'package:flutter/material.dart';

class OrComponent extends StatelessWidget {
  final double width;
  final double height;

  const OrComponent({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 0.02125 * height,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 0.3111 * width,
            height: 2,
            color: Colors.black,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0),
            child: Text("OR"),
          ),
          Container(
            width: 0.3111 * width,
            height: 2,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
