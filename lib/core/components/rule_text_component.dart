import 'package:flutter/material.dart';

class RuleTextComponent extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final double? horizontalPadding;
  final double? verticalPadding;

  const RuleTextComponent({
    super.key,
    required this.width,
    required this.height,
    required this.text,
    this.horizontalPadding,
    this.verticalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding??0,
        vertical: verticalPadding??0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              // width: 0.3111 * width,
              height: 1,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Text(text),
          ),
          Expanded(
            child: Container(
              // width: 0.3111 * width,
              height: 1,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
