import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShimmerMenuItem extends StatefulWidget {
  const ShimmerMenuItem({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  State<ShimmerMenuItem> createState() => _ShimmerMenuItemState();
}

class _ShimmerMenuItemState extends State<ShimmerMenuItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.9027777778 * widget.width,
      height: 0.16625 * widget.height,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      // child: Card(
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(20),
      //   ),
      //   color: Colors.white,
      //   elevation: 3,
      //   shadowColor: Colors.grey,
      //   child: ClipRRect(
      //     borderRadius: BorderRadius.circular(20),
      //     child: Container(
      //       width: 0.9027777778 * widget.width,
      //       height: 0.16625 * widget.height,
      //       color: Colors.white,
      //       child: Row(
      //         children: [
      //           _getImage(
      //             width: 0.3555555556 * widget.width,
      //             height: 0.1694444444 * widget.height,
      //           ),
      //           Expanded(
      //             child: Padding(
      //               padding: const EdgeInsets.only(
      //                 top: 12,
      //                 left: 12,
      //                 right: 20.0,
      //                 bottom: 15,
      //               ),
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Column(
      //                     children: [
      //                       Row(
      //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                         children: [
      //                           SizedBox(
      //                             width: 0.38 * widget.width,
      //                             child: Text(
      //                               "Product Name",
      //                               overflow: TextOverflow.ellipsis,
      //                               style: TextStyle(
      //                                 fontWeight: FontWeight.bold,
      //                                 fontFamily:
      //                                 GoogleFonts.poppins().fontFamily,
      //                               ),
      //                             ),
      //                           ),
      //                           _getVegIcon(),
      //                         ],
      //                       ),
      //                       RichText(
      //                         text: TextSpan(
      //                             text: "Product Description",
      //                             style:
      //                             GoogleFonts.poppins(color: Colors.black)),
      //                       ),
      //                     ],
      //                   ),
      //                   Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: [
      //                       Card(
      //                         color: const Color(0xFFF2F1F1),
      //                         child: Padding(
      //                           padding: const EdgeInsets.symmetric(
      //                             horizontal: 10.0,
      //                             vertical: 5,
      //                           ),
      //                           child: Text("₹ 600"),
      //                         ),
      //                       ),
      //                       ElevatedButton(
      //                         style: ElevatedButton.styleFrom(
      //                             backgroundColor: Colors.black,
      //                             shape: RoundedRectangleBorder(
      //                               borderRadius: BorderRadius.circular(7),
      //                             )),
      //                         onPressed: () {
      //                         },
      //                         child: RichText(
      //                           text: TextSpan(
      //                             text: "Add",
      //                             style: GoogleFonts.poppins(
      //                               color: Colors.white,
      //                               fontWeight: FontWeight.bold,
      //                             ),
      //                           ),
      //                         ),
      //                       ),
      //                     ],
      //                   )
      //                 ],
      //               ),
      //             ),
      //           )
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  _getImage({required double width, required double height}) {
    return Image.asset(
      "assets/images/pasta.jpeg",
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }

  _getVegIcon() {
    return SizedBox(
      width: 0.0654 * widget.width,
      child: Image.asset("assets/images/nonvegetarian48.png"),
    );
  }
}
