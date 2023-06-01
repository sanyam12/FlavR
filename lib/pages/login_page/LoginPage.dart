import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';

import 'login_bloc.dart';

//todo store token
//todo google sign in
//todo keep logged in using splash and checking stored for stored token

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final mailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formState = GlobalKey<FormState>();
  final _loginPageBloc = LoginBloc();
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
    final queryData = MediaQuery.of(context);
    final width = queryData.size.width;
    final height = queryData.size.height;

    return BlocProvider(
      create: (context) {
        return _loginPageBloc;
      },
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, LoginState state) {
          if (state is LoginSuccessful) {
            Navigator.popAndPushNamed(context, "/outletMenu");
          } else if (state is LoginFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: _formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: (0.45 * height),
                    child: Lottie.asset(
                        "assets/animations/login_page_animation.json"),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 7, 0, 0),
                    child: SizedBox(
                      width: (0.45556 * width),
                      height: (0.06375 * height),
                      child: Image.asset("assets/images/brand_image.png"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, (0.0475 * height), 0, 0),
                    child: RuledHeading(
                      width: (0.230556 * width),
                      title: "Login",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, (0.025 * height), 0, 0),
                    child: SizedBox(
                      width: (0.719444 * width),
                      height: (0.0575 * height),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(13, 0, 0, 0),
                          child: Center(
                            child: TextFormField(
                              controller: mailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Email",
                                hintStyle: TextStyle(
                                  fontSize: 18,
                                ),
                                isDense: true,
                                prefixIconConstraints:
                                    BoxConstraints(minHeight: 0, minWidth: 0),
                                // contentPadding: EdgeInsets.fromLTRB(170, 0, 0, 0)
                              ),
                              validator: (s) {
                                if (s == null || s.isEmpty) {
                                  return "Enter Email";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: SizedBox(
                      width: (0.719444 * width),
                      height: (0.0575 * height),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(13, 0, 0, 0),
                          child: Center(
                            child: TextFormField(
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Password",
                                hintStyle: TextStyle(
                                  fontSize: 18,
                                ),
                                isDense: true,
                                prefixIconConstraints:
                                    BoxConstraints(minHeight: 0, minWidth: 0),
                                // contentPadding: EdgeInsets.fromLTRB(170, 0, 0, 0)
                              ),
                              validator: (s) {
                                if (s == null || s.isEmpty) {
                                  return "Enter Password";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, (0.02 * height), 0, 0),
                    child: SizedBox(
                      width: (0.7194 * width),
                      height: (0.0575 * height),
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formState.currentState!.validate()) {
                              setState(() {
                                _loginPageBloc.add(
                                    LoginButtonPressed(
                                        email: mailController.text,
                                        password: passwordController.text
                                    ),
                                );
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6F5B48),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                          ),
                          child: const Text(
                            "Continue",
                            style: TextStyle(fontSize: 19),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                    child: SizedBox(
                      width: (0.719444 * width),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, "/signUp");
                        },
                          child: const Text("Don’t have account? Sign Up"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, (0.025 * height), 0, 0),
                    child: RuledHeading(width: (0.35 * width), title: "or"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Implementation Pending"),
                        ),
                      );
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    child: SizedBox(
                      width: (0.7194 * width),
                      height: (0.0575 * height),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                (0.0972222 * width), 0, 0, 0),
                            child: SizedBox(
                              width: 25,
                              height: 25,
                              child: _riveArtboard == null
                                  ? const SizedBox()
                                  : Rive(artboard: _riveArtboard!),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                            child: Text(
                              "Continue with Google",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RuledHeading extends StatelessWidget {
  const RuledHeading({Key? key, required this.width, required this.title})
      : super(key: key);
  final double width;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: const Color(0xFF4B4848),
          width: width,
          height: 1,
        ),
        Text(
          title,
          style: const TextStyle(color: Color(0xFF4B4848), fontSize: 12),
        ),
        Container(
          color: const Color(0xFF4B4848),
          width: width,
          height: 1,
        ),
      ],
    );
  }
}