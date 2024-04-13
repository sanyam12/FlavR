import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddOtherInstructions extends StatelessWidget {
  const AddOtherInstructions(
      {super.key,
      required this.width,
      required this.height,
      required this.valuefirst,
      required this.onChanged});

  final double width;
  final double height;
  final bool? valuefirst;
  final void Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.888 * width,
      height: 0.2 * height,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 0.01 * height, 0, 0),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Color(0xffBDBDBC))),
          elevation: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                alignment: AlignmentDirectional.centerStart,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      0.025 * width, 0.01125 * height, 0, 0),
                  child: Text(
                    "Add Order Instructions",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.027 * width, 0, 0, 0),
                child: Container(
                  alignment: AlignmentDirectional.centerStart,
                  child: SizedBox(
                    width: 0.29444 * width,
                    height: 0.11375 * height,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Color(0xffBDBDBC))),
                      elevation: 3,
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(0, 0.01 * height, 0, 0),
                            child: Text(
                              "Pack the order",
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Icon(Icons.backpack),
                              Checkbox(
                                value: valuefirst,
                                onChanged: (bool? value) {
                                  onChanged(value);
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
