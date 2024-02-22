import 'package:flavr/features/google_sign_in/bloc/sign_in_with_google_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginText extends StatelessWidget {
  final double height;

  const LoginText({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<SignInWithGoogleBloc>().add(OnLoginClick());
      },
      child: RichText(
        text: TextSpan(
          text: "Already a food lover? ",
          style: TextStyle(
            color: Colors.black,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
          children: [
            TextSpan(
              text: "Login",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            )
          ],
        ),
      ),
    );
  }
}
