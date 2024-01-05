import 'dart:convert';
import 'dart:developer';
import 'package:flavr/components/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:otp_text_field/style.dart';

import '../../bloc/otp_screen_bloc.dart';
import '../widgets/resend_otp.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key, required this.email}) : super(key: key);

  final String email;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otp = "";
  @override
  void initState() {
    super.initState();
    context.read<OtpScreenBloc>().add(OtpRequested(widget.email));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<OtpScreenBloc, OtpScreenState>(
          listener: (context, state) {
            if (state is OtpShowSnackBar) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is! OtpShowSnackBar) {
              return const Center(
                child: CustomLoadingAnimation(),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0.03 * height, 0, 0),
                          child: Row(
                            children: [
                              Container(
                                alignment: AlignmentDirectional.topStart,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: const Icon(CupertinoIcons.back),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(0.25 * width, 0, 0, 0),
                                child: const Text(
                                  "Enter OTP",
                                  style: TextStyle(
                                      fontFamily: "inter", fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0.02 * height, 0, 0),
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: LottieBuilder(
                              lottie: AssetLottie(
                                "assets/animations/otp.json",
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              0.108 * width, 0.03 * height, 0, 0),
                          child: Row(children: [
                            const Text("OTP sent to "),
                            Text(
                              widget.email,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: "inter",
                              ),
                            )
                          ]),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0.05 * height, 0, 0),
                          child: OTPTextField(
                            length: 4,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                            fieldStyle: FieldStyle.box,
                            otpFieldStyle: OtpFieldStyle(
                              borderColor: const Color(0xff000000),
                              focusBorderColor: const Color(0xffA3C2B3),
                            ),
                            width: 0.6*width,
                            textFieldAlignment: MainAxisAlignment.spaceAround,
                            // showFieldAsBox: true,
                            // onSubmit: (String verificationCode) async {
                            //   context.read<OtpScreenBloc>().add(
                            //         OtpSubmitted(
                            //           widget.email,
                            //           verificationCode,
                            //         ),
                            //       );
                            // },
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0.02 * height, 0, 0),
                          child: Column(
                            children: [
                              const Text(
                                "Didn't receive code?",
                                style: TextStyle(
                                    color: Color(0xffC2BBBB), fontSize: 12),
                              ),
                              ResendOTP(
                                mail: widget.email,
                              )
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            log(otp);
                            // var response = http.post(
                            //   Uri.parse("https://flavr.tech/mail/verifyotp"),
                            //   body: jsonEncode({
                            //     "key": widget.email,
                            //     "otp": 2650,
                            //     "role": 1
                            //   })
                            // );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff004932),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Confirm",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
