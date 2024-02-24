import 'package:flutter/material.dart';

class GrandTotal extends StatelessWidget {
  const GrandTotal(
      {super.key,
        required this.width,
        required this.height,
        required this.grandTotal});

  final double width;
  final double height;
  final int grandTotal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          0, 0.0175 * height, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Grand Total",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
          Row(
            children: [
              const Icon(
                Icons.currency_rupee,
                size: 17,
                color: Color(0xff004932),
              ),
              Text(
                grandTotal.toString(),
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff004932),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}