import 'package:flavr/pages/signup/signup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../login_page/LoginPage.dart';

//todo keep logged in pending

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _signupBlock = SignupBloc();
  final mailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);
    final width = queryData.size.width;
    final height = queryData.size.height;
    return BlocProvider(
      create: (context) {
        return _signupBlock;
      },
      child: BlocListener<SignupBloc, SignupState>(
        listener: (context, SignupState state) {
          if (state is SignupSuccessful) {
            Navigator.popAndPushNamed(context, "/outletMenu");
          } else if (state is SignupFailed) {
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
                      title: "Sign Up",
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
                              controller: nameController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Name",
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
                                  return "Enter Name";
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
                                _signupBlock.add(
                                  SignupButtonPressed(
                                      name: nameController.text,
                                      email: mailController.text,
                                      password: passwordController.text),
                                );
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6F5B48)),
                          child: const Text(
                            "Continue",
                            style: TextStyle(fontSize: 19),
                          )),
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
