import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/outlet_menu_bloc.dart';

class TopRow extends StatelessWidget {
  final double width;
  final String outletName;

  const TopRow({
    super.key,
    required this.width,
    required this.outletName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            context.read<OutletMenuBloc>().add(OutletListClicked());
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Delivery In",
                style: GoogleFonts.poppins(),
              ),
              Text(
                "20 minutes",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Row(
                children: [
                  Text(
                    outletName,
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),
                  const Icon(Icons.expand_more)
                ],
              ),
            ],
          ),
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 0.03 * width),
              child: SvgPicture.asset(
                "assets/svg/skillet.svg",
                width: 32,
                height: 32,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, "/profile");
              },
              child: const Icon(
                Icons.account_circle,
                size: 32,
              ),
            ),
          ],
        )
      ],
    );
  }
}
