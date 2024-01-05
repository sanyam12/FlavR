import 'package:flutter/material.dart';

import '../../../outlet_menu/Outlet.dart';



class OutletCard extends StatelessWidget {
  const OutletCard(
      {super.key,
        required this.width,
        required this.height,
        required this.outlet,
        required this.selectOutlet,
        required this.addToFav});

  final double width;
  final double height;
  final Outlet outlet;
  final void Function() selectOutlet;
  final void Function(Outlet) addToFav;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 0.05 * width, vertical: 0.005 * height),
      child: InkWell(
        onTap: () {
          selectOutlet();
        },
        child: Card(
            elevation: 5,
            shadowColor: Colors.black,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: width,
                height: 0.34125 * height,
                child: Column(
                  children: [
                    SizedBox(
                      width: width,
                      height: 0.26625 * height,
                      child:
                      (outlet.imageUrl != null && outlet.imageUrl != 'null')
                          ? Image.network(
                        outlet.imageUrl!,
                        fit: BoxFit.fill,
                      )
                          : Image.asset(
                        "assets/images/subway.jpeg",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            0.0277 * width, 0.01 * height, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  outlet.outletName,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 0.7 * width,
                                  child: Text(
                                    outlet.address,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                addToFav(outlet);
                              },
                              icon: (outlet.isFavourite)
                                  ? const Icon(Icons.favorite)
                                  : const Icon(Icons.favorite_border),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}