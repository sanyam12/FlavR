import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ShimmerOutletCard extends StatelessWidget {
  const ShimmerOutletCard({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 0.010625 * height,
      ),
      child: Card(
          margin: EdgeInsets.zero,
          clipBehavior: Clip.antiAlias,
          elevation: 0,
          shadowColor: Colors.black,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              width: width,
              height: 0.2375 * height,
              child: Stack(
                children: [
                  SizedBox(
                    width: width,
                    height: 0.2375 * height,
                    child: Image.asset(
                      "assets/images/subway.jpeg",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color.fromARGB(178, 0, 0, 0),
                            Color.fromARGB(23, 0, 0, 0),
                            Colors.transparent,
                            // Color(0xFF00000000),
                          ],
                        )),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 0.0277 * width,
                        bottom: 0.01 * height,
                      ),
                      child: _getBottomRow(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 0.0277 * width,
                        bottom: 0.01 * height,
                      ),
                      child: _getTopRow(),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  _getBottomRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            Text(
              "Outlet Name",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
            SizedBox(
              width: 0.7 * width,
              child: Text(
                "Outlet Address",
                style: TextStyle(
                    fontSize: 15,
                    overflow: TextOverflow.ellipsis,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _getTopRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.star,
                color: Colors.yellowAccent,
              ),
              Text(
                "6.9",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                onPressed: () {
                },
                icon: const Icon(
                  Icons.favorite_border,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
