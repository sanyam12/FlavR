import 'package:flavr/core/components/button.dart';
import 'package:flavr/core/components/button_types.dart';
import 'package:flavr/core/components/heading.dart';
import 'package:flavr/features/google_sign_in/presentation/widgets/google_button.dart';
import 'package:flavr/features/google_sign_in/presentation/widgets/image_collection.dart';
import 'package:flavr/features/google_sign_in/presentation/widgets/login_text.dart';
import 'package:flavr/features/google_sign_in/presentation/widgets/or_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/sign_in_with_google_bloc.dart';

class SignInWithGoogle extends StatefulWidget {
  const SignInWithGoogle({super.key});

  @override
  State<SignInWithGoogle> createState() => _SignInWithGoogleState();
}

class _SignInWithGoogleState extends State<SignInWithGoogle> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocListener<SignInWithGoogleBloc, SignInWithGoogleState>(
      listener: (context, SignInWithGoogleState state) {
        if (state is GoogleButtonClicked) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Implementation Pending")));
        }
        if (state is SignUpClicked) {
          Navigator.of(context).pushNamed("/signUp");
        }
        if (state is LoginClicked) {
          Navigator.of(context).pushNamed("/login");
        }
        if (state is ShowSnackbar) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
        if (state is GoogleLoginSuccess) {
          Navigator.of(context).popAndPushNamed("/outletMenu");
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ImageCollection(
                  width: width,
                  height: height,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.04375 * height),
                  child: SizedBox(
                    width: 0.75 * width,
                    child: const FittedBox(
                      child: Heading(text: "Good food is just a click away"),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 0.0375 * height),
                  child: ButtonComponent(
                    text: "Sign Up",
                    onPressed: () {
                      context.read<SignInWithGoogleBloc>().add(OnSignUpClick());
                    },
                    height: height,
                    width: width,
                    type: ButtonType.ShortButton,
                  ),
                ),
                LoginText(
                  height: height,
                ),
                OrComponent(
                  width: width,
                  height: height,
                ),
                const GoogleButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
