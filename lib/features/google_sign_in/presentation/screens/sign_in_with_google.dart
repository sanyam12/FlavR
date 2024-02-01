
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

import '../../../../components/authentication_image_collection.dart';
import '../../bloc/sign_in_with_google_bloc.dart';


class SignInWithGoogle extends StatefulWidget {
  const SignInWithGoogle({super.key});

  @override
  State<SignInWithGoogle> createState() => _SignInWithGoogleState();
}

class _SignInWithGoogleState extends State<SignInWithGoogle> {
  Artboard? _riveArtboard;
  RiveAnimationController? _controller;

  @override
  void initState() {
    super.initState();
    rootBundle.load("assets/rive/google.riv").then(
      (value) async {
        final file = RiveFile.import(value);
        final artboard = file.mainArtboard;
        artboard.addController(_controller = SimpleAnimation("idle"));
        setState(() {
          _riveArtboard = artboard;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final SignInWithGoogleBloc _signInWithGoogleBloc =
        context.read<SignInWithGoogleBloc>();
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
        body: Stack(
          children: [
            ...AuthenticationImageCollection.build(width, height),
            Positioned(
              top: 0.675 * height,
              child: SizedBox(
                width: width,
                child: Column(
                  children: [
                    const Text(
                      "Savor the flavors, indulge in delight",
                      style:
                          TextStyle(color: Color(0xFF004932), fontSize: 15),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0.02 * height, 0, 0),
                      child: SizedBox(
                        width: 0.4 * width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(width: 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () async {
                            _signInWithGoogleBloc.add(OnGoogleButtonClick());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _riveArtboard == null
                                  ? const SizedBox()
                                  : SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Rive(
                                        artboard: _riveArtboard!,
                                      ),
                                    ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Text(
                                  "Continue",
                                  style: TextStyle(color: Colors.black),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0.01875 * height, 0, 0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF004932),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          _signInWithGoogleBloc.add(OnSignUpClick());
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            "Sign up with email",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0.02 * height, 0, 0),
                      child: InkWell(
                        onTap: () {
                          _signInWithGoogleBloc.add(OnLoginClick());
                        },
                        child: RichText(
                          text: const TextSpan(
                            text: "Already a food lover? ",
                            style: TextStyle(color: Color(0xFF004932)),
                            children: [
                              TextSpan(
                                text: "Login",
                                style: TextStyle(
                                    color: Color(0xFF004932),
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}