import 'dart:async';
import 'package:flavr/core/components/button.dart';
import 'package:flavr/core/components/button_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/otp_screen_bloc.dart';

class ResendOTP extends StatefulWidget {
  final String mail;
  final double width;
  final double height;

  const ResendOTP({
    super.key,
    required this.mail,
    required this.width,
    required this.height,
  });

  @override
  State<ResendOTP> createState() => _ResendOTPState();
}

class _ResendOTPState extends State<ResendOTP> {
  Timer? _timer;
  int seconds = 120;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (seconds > 0) {
          setState(() {
            seconds--;
          });
        } else {
          _timer?.cancel();
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (seconds > 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Request again in ",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
          Text(
            seconds.toString(),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ButtonComponent(
          text: "Resend Code",
          onPressed: () {
            context.read<OtpScreenBloc>().add(OtpRequested(widget.mail));
          },
          width: widget.width,
          height: widget.height,
          type: ButtonType.ShortButton,
        ),
      );
      // return ElevatedButton(
      //   style: ElevatedButton.styleFrom(
      //       backgroundColor: const Color(0xff004932),
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(10),
      //       )),
      //   child: const Text(
      //     "Resend Code",
      //     style: TextStyle(
      //       color: Colors.white,
      //     ),
      //   ),
      //   onPressed: () {
      //     context.read<OtpScreenBloc>().add(OtpRequested(widget.mail));
      //   },
      // );
    }
  }
}
