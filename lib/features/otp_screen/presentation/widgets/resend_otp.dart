import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/otp_screen_bloc.dart';

class ResendOTP extends StatefulWidget {
  final String mail;

  const ResendOTP({super.key, required this.mail});

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
          const Text(
            "Request again in ",
            style: TextStyle(color: Color(0xff004932), fontSize: 10),
          ),
          Text(
            seconds.toString(),
            style: const TextStyle(
              color: Color(0xff004932),
              fontSize: 10,
            ),
          ),
        ],
      );
    } else {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff004932),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        child: const Text(
          "Resend Code",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: () {
          // sendOTP();
          context.read<OtpScreenBloc>().add(OtpRequested(widget.mail));
        },
      );
    }
  }
}
