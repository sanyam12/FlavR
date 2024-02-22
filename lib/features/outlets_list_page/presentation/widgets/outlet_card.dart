import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../outlet_menu/data/models/Outlet.dart';

class OutletCard extends StatelessWidget {
  const OutletCard({
    super.key,
    required this.width,
    required this.height,
    required this.outlet,
    required this.selectOutlet,
    required this.addToFav,
  });

  final double width;
  final double height;
  final Outlet outlet;
  final void Function() selectOutlet;
  final void Function(Outlet) addToFav;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 0.010625 * height,
      ),
      child: InkWell(
        onTap: () {
          selectOutlet();
        },
        child: Card(
            margin: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            elevation: 5,
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
                      child:
                          (outlet.imageUrl != null && outlet.imageUrl != 'null')
                              ? Image.network(
                                  outlet.imageUrl!,
                                  fit: BoxFit.fill,
                                )
                              : Image.asset(
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
      ),
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
              outlet.outletName,
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
                outlet.address,
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
                  addToFav(outlet);
                },
                icon: (outlet.isFavourite)
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : const Icon(
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
