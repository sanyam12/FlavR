import 'package:flutter/material.dart';

class YourDetails extends StatelessWidget {
  const YourDetails({super.key, required this.width, required this.height});

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
                  "Your details",
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
                    side: const BorderSide(color: Color(0xffBDBDBC))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0194 * width, 0, 0, 0),
                      child: const Text("akshita , 62849xxxxx"),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/profile");
                        },
                        icon: const Icon(Icons.arrow_forward_ios))
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