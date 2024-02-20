import 'package:flavr/core/components/button.dart';
import 'package:flavr/core/components/button_types.dart';
import 'package:flavr/core/components/heading.dart';
import 'package:flavr/core/components/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_text_field.dart';
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
            return SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Image
                    SizedBox(
                      width: double.infinity,
                      child: Image.asset(
                        "assets/images/otp.png",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    //Heading
                    Padding(
                      padding: EdgeInsets.only(top: 0.035 * height),
                      child: const Heading(text: "OTP"),
                    ),
                    //Text + Email
                    Padding(
                      padding: EdgeInsets.only(
                        top: 0.03 * height,
                      ),
                      child: SizedBox(
                        width: 0.65833 * width,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text:
                                  "We just hooked you up with a One Time Password at your email ",
                              children: [
                                TextSpan(
                                  text: widget.email,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              )),
                        ),
                      ),
                    ),
                    //OTP Text Field
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0.05 * height, 0, 0),
                      child: OTPTextField(
                        length: 4,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 4),
                        fieldStyle: FieldStyle.box,
                        otpFieldStyle: OtpFieldStyle(
                          borderColor: const Color(0xff000000),
                          focusBorderColor: const Color(0xffA3C2B3),
                        ),
                        width: 0.6 * width,
                        fieldWidth: 43,
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        //TODO: Pending
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
                    //resend otp component
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0.02 * height, 0, 0),
                      child: Column(
                        children: [
                          const Text(
                            "Didn't receive the OTP?",
                            style: TextStyle(
                                fontSize: 13,
                            ),
                          ),
                          ResendOTP(
                            mail: widget.email,
                            width: width,
                            height: height,
                          )
                        ],
                      ),
                    ),
                    //Submit
                    ButtonComponent(
                      text: "Verify OTP",
                      //TODO: Pending
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Implementation Pending"),
                          ),
                        );
                        // var response = http.post(
                        //   Uri.parse("${}mail/verifyotp"),
                        //   body: jsonEncode({
                        //     "key": widget.email,
                        //     "otp": 2650,
                        //     "role": 1
                        //   })
                        // );
                      },
                      width: width,
                      height: height,
                      type: ButtonType.LongButton,
                      trailing: const Icon(Icons.arrow_circle_right, color: Colors.white,),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}