import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:lottie/lottie.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    final height= MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return  Scaffold(
      body: SafeArea(
          child: Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0,0.03*height,0,0),
                    child: Row(
                      children: [
                        Container(
                          alignment: AlignmentDirectional.topStart,
                          child: IconButton(
                            onPressed:(){ Navigator.of(context).pop();},
                            icon: const Icon(CupertinoIcons.back),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.25*width,0,0,0),
                          child: const Text("Enter OTP",
                            style: TextStyle(
                                fontFamily: "inter",
                                fontSize: 20
                            ),),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0,0.02*height,0,0),
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: LottieBuilder(lottie: AssetLottie(
                        "assets/animations/otp.json",
                      )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.108*width,0.03*height,0,0),
                    child: const Row(children: [
                      Text("OTP sent to "),
                      Text("sejal27bansal@gmail.com" , style:
                      TextStyle(
                        fontSize: 14,
                        fontFamily: "inter",
                      ),
                      )
                    ]
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0,0.055*height,0,0),
                    child: OtpTextField(
                      numberOfFields: 4,
                      borderColor:const Color(0xff000000) ,
                      focusedBorderColor: const Color(0xffA3C2B3),
                      cursorColor: const Color(0xff004932),
                      showFieldAsBox: true,
                      onCodeChanged: (String code){},
                      onSubmit: (String verificationCode){
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0,0.02*height,0,0),
                    child: const Column(
                      children: [
                        Text("Didn't receive code?" , style:
                          TextStyle(
                            color: Color(0xffC2BBBB),
                            fontSize: 12
                          ),),
                        Text("Request again in 120 sec" , style:
                          TextStyle(
                            color: Color(0xff004932),
                            fontSize: 10
                          ),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0,0.03*height,0,0),
                    child: ElevatedButton(
                        onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff004932),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                      ),
                        child: const Text("Confirm" ),
                    ),
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}
