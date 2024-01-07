import 'package:flutter/material.dart';
import '../../data/models/Product.dart';

class MenuItem extends StatelessWidget {
  const MenuItem(
      {Key? key,
        required this.width,
        required this.height,
        required this.product})
      : super(key: key);

  final double width;
  final double height;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: (0.0388 * width)),
      child: SizedBox(
        height: (0.15625 * height),
        child: Card(
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            0.012 * width, (0.01375 * height), 0, 0),
                        child: (product.veg)
                            ? const Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Icon(
                              Icons.crop_square_sharp,
                              color: Colors.green,
                              size: 25,
                            ),
                            Icon(Icons.circle,
                                color: Colors.green, size: 10),
                          ],
                        )
                            : const Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Icon(
                              Icons.crop_square_sharp,
                              color: Colors.red,
                              size: 25,
                            ),
                            Icon(Icons.circle,
                                color: Colors.red, size: 10),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                        EdgeInsets.fromLTRB(((0.033 * width)), 0, 0, 0),
                        child: SizedBox(
                          width: (0.51222 * width),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    0, (0.01125 * height), 0, 0),
                                child: Text(
                                  product.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                                child: Text(
                                  "₹ ${product.price}",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                product.description,
                                style: const TextStyle(fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        width: (0.25 * width),
                        height: (0.3125 * height),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            (product.productImage == "null")
                                ? Image.asset(
                              "assets/images/hamburger.jpg",
                              fit: BoxFit.cover,
                            )
                                : Image.network(product.productImage),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 5,
                              margin: EdgeInsets.zero,
                              clipBehavior: Clip.antiAlias,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 34,
                                      height: 34,
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        onPressed: () {},
                                        icon: const Center(
                                          child: Icon(
                                            Icons.remove,
                                            size: 34,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Text("1"),
                                    SizedBox(
                                      width: 34,
                                      height: 34,
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        onPressed: () {},
                                        icon: const Center(
                                          child: Icon(
                                            Icons.add,
                                            size: 34,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
