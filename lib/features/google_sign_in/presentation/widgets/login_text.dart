import 'package:flavr/features/google_sign_in/bloc/sign_in_with_google_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        text: const TextSpan(
          text: "Already a food lover? ",
          style: TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: "Login",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
