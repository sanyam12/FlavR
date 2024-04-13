import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          Text(
            "Grand Total",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
          Row(
            children: [
              const Icon(
                Icons.currency_rupee,
                size: 17,
                color: Color(0xff004932),
              ),
              Text(
                grandTotal.toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff004932),
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
