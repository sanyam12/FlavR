import 'package:flavr/features/orders_list/presentation/widgets/order_details_overlay.dart';
import 'package:flavr/features/profile_page/data/models/OrderData.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatefulWidget {
  final double width;
  final double height;
  final OrderData data;

  const OrderCard(
      {super.key,
      required this.width,
      required this.height,
      required this.data});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool isShowMoreRequired = false;

  String _formatDate(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd MMM, yyyy');
    return formatter.format(dateTime);
  }

  String _formatTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('hh:mm a');
    return formatter.format(dateTime);
  }

  List<Widget> checklist(double width) {
    int count = 0;
    List<Widget> list = [];
    for (var i in widget.data.products) {
      if (count < 2 && i.quantity != 0) {
        count++;
        list.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: "${i.quantity} x ${i.productName}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff000000),
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(
                    Icons.currency_rupee,
                    size: 12,
                    color: Color(0xff004932),
                  ),
                  Text(
                    "${i.price}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff000000),
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }
      if (count >= 2) {
        list.add(
          Text(
            "+ ${widget.data.products.length-1} more items...",
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF004932),
            ),
          ),
        );
        break;
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: widget.width * 0.886111,
          color: Colors.black,
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) {
                  return OrderDetailsOverlay(data: widget.data);
                },
              );
            },
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0.013889 * widget.width,
                      0.00625 * widget.height,
                      0.013889 * widget.width,
                      0.00625 * widget.height),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDate(widget.data.createdAt),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                        overflow: TextOverflow.clip,
                      ),
                      Text(
                        //TODO: Outlet name
                        "data.outlet",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                      Text(
                        _formatTime(widget.data.createdAt),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                        overflow: TextOverflow.clip,
                      ),
                    ],
                  ),
                ),
                Card(
                  margin: EdgeInsets.zero,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            0.013889 * widget.width,
                            0.00625 * widget.height,
                            0.013889 * widget.width,
                            0.00625 * widget.height),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Order #",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff000000),
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                  ),
                                ),
                                Text(
                                  widget.data.orderNumber?.toString() ?? "NA",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xffff0000),
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.currency_rupee,
                                  color: Color(0xff004932),
                                  size: 16,
                                ),
                                Text(
                                  widget.data.totalPrice.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff000000),
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          0.013889 * widget.width,
                          0.00625 * widget.height,
                          0.013889 * widget.width,
                          0.00625 * widget.height,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 0.3333333333*width,
                              child: Stack(
                                children: [
                                  if (widget.data.products.length >= 3)
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                        0.1112 * widget.width,
                                        0,
                                        0.0556 * widget.width,
                                        0,
                                      ),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 32,
                                        child: ClipOval(
                                          child: Image.network(
                                              widget.data.products[2].imageUrl),
                                        ),
                                      ),
                                    ),
                                  if (widget.data.products.length >= 2)
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                        0.0556 * widget.width,
                                        0,
                                        0.0556 * widget.width,
                                        0,
                                      ),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 32,
                                        child: ClipOval(
                                          child: Image.network(
                                              widget.data.products[1].imageUrl),
                                        ),
                                      ),
                                    ),
                                  if (widget.data.products.isNotEmpty)
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 32,
                                      child: ClipOval(
                                        child: Image.network(
                                          widget.data.products[0].imageUrl,
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 0.05889 * width,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: checklist(width),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          0.013889 * widget.width,
                          0.00625 * widget.height,
                          0.013889 * widget.width,
                          0.00625 * widget.height,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.data.status,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff004932),
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                            Text(
                              _formatTime(widget.data.createdAt),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff004932),
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
