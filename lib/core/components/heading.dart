import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Heading extends StatelessWidget {
  final String text;

  const Heading({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style: GoogleFonts.ebGaramond(
          textStyle: const TextStyle(
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
            fontSize: 32,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
