import 'package:flutter/material.dart';

class AddSpecialInstructions extends StatelessWidget {
  const AddSpecialInstructions(
      {super.key, required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.888 * width,
      height: 0.128 * height,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Color(0xffBDBDBC))),
        elevation: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              alignment: AlignmentDirectional.centerStart,
              child: Padding(
                padding:
                EdgeInsets.fromLTRB(0.033 * width, 0.01125 * height, 0, 0),
                child: const Text(
                  "Add Special Instructions",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 0.82 * width,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                    color: Color(0xffBDBDBC),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0194 * width, 0, 0, 0),
                      child: SizedBox(
                        height: 0.04625 * height,
                        child: const Center(
                          child: Text("Your instructions"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}