import 'package:flutter/material.dart';

class AddMoreItems extends StatelessWidget {
  const AddMoreItems(
      {super.key,
        required this.width,
        required this.height,
        required this.onTap});

  final double width;
  final double height;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 0.888 * width,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Color(0xffBDBDBC))),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.025 * width, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Add more items",
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: "inter",
                  ),
                ),
                IconButton(
                  onPressed: () {
                  },
                  icon: const Icon(Icons.arrow_forward_ios),
                  iconSize: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}