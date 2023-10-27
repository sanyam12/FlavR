import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:developer';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key, required this.email}) : super(key: key);

  final String email;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  Timer? timer;
  int seconds = 120;

  void setCountDown() {
    setState(() {
      if (seconds <= 0) {
        // timer!.cancel();
      } else {
        seconds--;
      }
    });
  }

  void sendOTP() async {

    setState(() {
      seconds = 120;
    });
    var response = await http.post(
      Uri.parse("https://flavr.tech/mail/resendotp"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {"key": widget.email, "role": 0},
      ),
    );
    if (response.statusCode == 201) {
      var json = jsonDecode(response.body);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(json["message"]),
          ),
        );
      }
    }
    log(response.body);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setCountDown();
    });
    sendOTP();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              // child: Text("Hello World"),
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
                            padding: EdgeInsets.fromLTRB(0.25 * width, 0, 0, 0),
                            child: const Text(
                              "Enter OTP",
                              style:
                                  TextStyle(fontFamily: "inter", fontSize: 20),
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
                        )),
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
                      padding: EdgeInsets.fromLTRB(0, 0.055 * height, 0, 0),
                      child: OtpTextField(
                        numberOfFields: 4,
                        borderColor: const Color(0xff000000),
                        focusedBorderColor: const Color(0xffA3C2B3),
                        cursorColor: const Color(0xff004932),
                        showFieldAsBox: true,
                        onCodeChanged: (String code) {},
                        onSubmit: (String verificationCode) async {
                          log("checking on submit");
                          int check = int.parse(verificationCode);
                          log("check ${check}");
                          String body = jsonEncode(
                              {"key": widget.email, "otp": check, "role": 0});

                          final response = await http.post(
                              Uri.parse("https://flavr.tech/mail/verifyotp"),
                              body: body,
                              headers: {"Content-Type": "application/json"}
                          );
                          final json = jsonDecode(response.body);
                          if (json["message"] ==
                              "OTP Verified, you can log in now.") {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text(json["message"].toString())));
                              Navigator.popAndPushNamed(context, "/login");
                            }
                          } else {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(json["message"].toString()),
                                ),
                              );
                            }
                          }
                          log(body.toString());
                          log(response.body);
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
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
                          if (seconds > 0)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Request again in ",
                                  style: TextStyle(
                                      color: Color(0xff004932), fontSize: 10),
                                ),
                                Text(
                                  seconds.toString(),
                                  style: const TextStyle(
                                    color: Color(0xff004932),
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            )
                          else
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff004932),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              child: const Text("Resend Code"),
                              onPressed: () {
                                sendOTP();
                              },
                            )
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
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
                          )),
                      child: const Text("Confirm"),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
