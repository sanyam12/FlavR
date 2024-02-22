import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSearchBar extends StatelessWidget {
  final double width;
  final double height;
  final TextEditingController controller;
  final void Function(String) onChanged;

  const CustomSearchBar({
    super.key,
    required this.width,
    required this.height,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Card(
        color: Colors.white,
        elevation: 3,
        surfaceTintColor: Colors.white,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Search Outlet",
            hintStyle: GoogleFonts.poppins(),
            prefixIcon: const Icon(Icons.search),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
