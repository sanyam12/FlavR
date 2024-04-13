import 'package:flavr/core/components/button.dart';
import 'package:flavr/core/components/button_types.dart';
import 'package:flavr/core/components/heading.dart';
import 'package:flavr/core/components/loading.dart';
import 'package:flavr/core/components/text_field.dart';
import 'package:flavr/features/login_page/presentation/widgets/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../otp_screen/presentation/screens/otp_screen.dart';
import '../../bloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final mailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);
    final width = queryData.size.width;
    final height = queryData.size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, LoginState state) {
            if (state is LoginSuccessful) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/outletList", (route) => false);
            }
            if (state is LoginFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
            if (state is VerificationPending) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return OtpScreen(email: mailController.text);
                  },
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is LoginLoading) {
              return const Center(
                child: CustomLoadingAnimation(),
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ImageComponent(
                    width: width,
                    height: height,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 0.02 * height,
                    bottom: 0.02 * height,
                  ),
                  child: const Heading(text: "Log In"),
                ),
                SizedBox(
                  width: 0.8694444444 * width,
                  child: Text(
                    "Hit us up with your email and password, and we’ll log you in",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 0.5,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.0225 * height),
                  child: TextFieldComponent(
                    width: width,
                    controller: mailController,
                    hintText: "Enter your email",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 0.01125 * height),
                  child: TextFieldComponent(
                    width: width,
                    controller: passwordController,
                    hintText: "Enter your password",
                  ),
                ),
                ButtonComponent(
                  text: "Log In",
                  onPressed: () {
                    context.read<LoginBloc>().add(
                          LoginButtonPressed(
                            email: mailController.text,
                            password: passwordController.text,
                          ),
                        );
                  },
                  width: width,
                  height: height,
                  type: ButtonType.LongButton,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).popAndPushNamed("/signUp");
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 0.0125 * height),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don’t have an account?"),
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 0.02*height),
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.poppins().fontFamily,
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

  _later(width, height) {
    return [
      Padding(
        padding: EdgeInsets.fromLTRB(0, 0.0175 * height, 0, 0),
        child: SizedBox(
          width: 0.75 * width,
          child: TextField(
            controller: passwordController,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFA3C2B3),
              hintText: "Enter Password",
              hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            obscureText: true,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(0, 0.01625 * height, 0, 0),
        child: SizedBox(
          width: 0.4 * width,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF004932),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
            onPressed: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 11),
              child: Text("Login"),
            ),
          ),
        ),
      )
    ];
  }
}
