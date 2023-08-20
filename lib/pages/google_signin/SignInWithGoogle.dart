import 'dart:developer';

import 'package:flavr/pages/google_signin/sign_in_with_google_bloc.dart';
import 'package:flavr/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

class SignInWithGoogle extends StatefulWidget {
  const SignInWithGoogle({super.key});

  @override
  State<SignInWithGoogle> createState() => _SignInWithGoogleState();
}

class _SignInWithGoogleState extends State<SignInWithGoogle> {
  Artboard? _riveArtboard;
  RiveAnimationController? _controller;
  final SignInWithGoogleBloc _signInWithGoogleBloc = SignInWithGoogleBloc();

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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) {
        return _signInWithGoogleBloc;
      },
      child: BlocListener<SignInWithGoogleBloc, SignInWithGoogleState>(
        listener: (context, SignInWithGoogleState state) {
          if (state is GoogleButtonClicked) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Implementation Pending")));
          }
          else if (state is SignUpClicked) {
            Navigator.of(context).pushNamed("/signUp");
          }
          else if (state is LoginClicked) {
            Navigator.of(context).pushNamed("/login");
          }
          else if (state is ShowSnackbar) {;
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
          else if (state is GoogleLoginSuccess) {
            Navigator.of(context).popAndPushNamed("/outletMenu");
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFFFFFFF),
          body: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  top: (-0.10875 * height),
                  left: (-0.080556 * width),
                  child: Image.asset(
                    "assets/images/pizza.jpg",
                    width: (0.6527777778 * width),
                  ),
                ),
                Positioned(
                    top: (-0.10875 * height),
                    left: (0.5722222222 * width),
                    child: Transform.rotate(
                      angle: 86.84,
                      child: Image.asset(
                        "assets/images/noodles.jpeg",
                        width: (0.655556 * width),
                        height: (0.19625 * height),
                      ),
                    )),
                Positioned(
                    top: 0.2675 * height,
                    left: -0.3333 * width,
                    child: Image.asset(
                      "assets/images/pasta.jpeg",
                      width: (0.83333 * width),
                    )),
                Positioned(
                    top: 0.2204 * height,
                    left: 0.62588889 * width,
                    child: Transform.rotate(
                      angle: -3.55,
                      child: Image.asset(
                        "assets/images/sandwich.jpeg",
                        width: (0.6555555556 * width),
                      ),
                    )),
                Container(
                  width: width,
                  height: height,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Positioned(
                        top: 0.18 * height,
                        child: SizedBox(
                          width: 0.26667*width,
                            // height: 0.03*height,
                            child: Image.asset("assets/images/flavr-logo.png")
                        )
                        // child: const Text(
                        //   "flavR",
                        //   style: TextStyle(
                        //       fontSize: 50,
                        //       color: Color(0xFF004932),
                        //       fontFamily: "Jim Nightshade",
                        //   ),
                        // ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0.675 * height,
                  child: Container(
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
                                      borderRadius: BorderRadius.circular(15))),
                              onPressed: () async {
                                _signInWithGoogleBloc.add(OnGoogleButtonClick());
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                          padding:
                              EdgeInsets.fromLTRB(0, 0.01875 * height, 0, 0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF004932),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            onPressed: () {
                              _signInWithGoogleBloc.add(OnSignUpClick());
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Text("Sign up with email"),
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
                                          fontWeight: FontWeight.bold))
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
        ),
      ),
    );
  }
}
