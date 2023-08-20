import 'dart:developer';

import 'package:flavr/pages/signup/signup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../login_page/LoginPage.dart';
import '../otp_screen/OtpScreen.dart';

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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpScreen(
                  email: mailController.text,
                ),
              ),
            );
          }
          else if (state is SignupFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
          else if (state is VerificationPending) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message))
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpScreen(
                  email: mailController.text,
                ),
              ),
            );
          }
          else if (state is UserAlreadyExists){
            Navigator.popAndPushNamed(context, "/login");
          }
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: _formState,
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
                          ),
                          // child: const Text(
                          //   "flavR",
                          //   style: TextStyle(
                          //       fontSize: 50,
                          //       color: Color(0xFF004932),
                          //       fontFamily: "Jim Nightshade"),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 0.75 * width,
                            child: TextField(
                              controller: nameController,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color(0xFFA3C2B3),
                                  hintText: "Enter Name",
                                  hintStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  )),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(0, 0.0175 * height, 0, 0),
                            child: SizedBox(
                              width: 0.75 * width,
                              child: TextField(
                                controller: mailController,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xFFA3C2B3),
                                    hintText: "Enter Mail",
                                    hintStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    )),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(0, 0.0175 * height, 0, 0),
                            child: SizedBox(
                              width: 0.75 * width,
                              child: TextField(
                                controller: passwordController,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color(0xFFA3C2B3),
                                  hintText: "Enter Password",
                                  hintStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                obscureText: true,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(0, 0.01625 * height, 0, 0),
                            child: SizedBox(
                              width: 0.4 * width,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF004932),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                onPressed: () {
                                  log("on Pressed");
                                  _signupBlock.add(
                                    SignupButtonPressed(
                                      name: nameController.text,
                                      email: mailController.text,
                                      password: passwordController.text,
                                    ),
                                  );
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 11),
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
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
      ),
    );
  }
}

//Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     width: double.infinity,
//                     height: (0.45 * height),
//                     child: Lottie.asset(
//                         "assets/animations/login_page_animation.json"),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(0, 7, 0, 0),
//                     child: SizedBox(
//                       width: (0.45556 * width),
//                       height: (0.06375 * height),
//                       child: Image.asset("assets/images/brand_image.png"),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(0, (0.0475 * height), 0, 0),
//                     child: RuledHeading(
//                       width: (0.230556 * width),
//                       title: "Sign Up",
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(0, (0.025 * height), 0, 0),
//                     child: SizedBox(
//                       width: (0.719444 * width),
//                       height: (0.0575 * height),
//                       child: Card(
//                         elevation: 4,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.fromLTRB(13, 0, 0, 0),
//                           child: Center(
//                             child: TextFormField(
//                               controller: nameController,
//                               keyboardType: TextInputType.text,
//                               decoration: const InputDecoration(
//                                 border: InputBorder.none,
//                                 hintText: "Enter Name",
//                                 hintStyle: TextStyle(
//                                   fontSize: 18,
//                                 ),
//                                 isDense: true,
//                                 prefixIconConstraints:
//                                     BoxConstraints(minHeight: 0, minWidth: 0),
//                                 // contentPadding: EdgeInsets.fromLTRB(170, 0, 0, 0)
//                               ),
//                               validator: (s) {
//                                 if (s == null || s.isEmpty) {
//                                   return "Enter Name";
//                                 } else {
//                                   return null;
//                                 }
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
//                     child: SizedBox(
//                       width: (0.719444 * width),
//                       height: (0.0575 * height),
//                       child: Card(
//                         elevation: 4,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.fromLTRB(13, 0, 0, 0),
//                           child: Center(
//                             child: TextFormField(
//                               controller: mailController,
//                               keyboardType: TextInputType.emailAddress,
//                               decoration: const InputDecoration(
//                                 border: InputBorder.none,
//                                 hintText: "Enter Email",
//                                 hintStyle: TextStyle(
//                                   fontSize: 18,
//                                 ),
//                                 isDense: true,
//                                 prefixIconConstraints:
//                                     BoxConstraints(minHeight: 0, minWidth: 0),
//                                 // contentPadding: EdgeInsets.fromLTRB(170, 0, 0, 0)
//                               ),
//                               validator: (s) {
//                                 if (s == null || s.isEmpty) {
//                                   return "Enter Email";
//                                 } else {
//                                   return null;
//                                 }
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
//                     child: SizedBox(
//                       width: (0.719444 * width),
//                       height: (0.0575 * height),
//                       child: Card(
//                         elevation: 4,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                         child: Padding(
//                           padding: const EdgeInsets.fromLTRB(13, 0, 0, 0),
//                           child: Center(
//                             child: TextFormField(
//                               controller: passwordController,
//                               keyboardType: TextInputType.visiblePassword,
//                               obscureText: true,
//                               decoration: const InputDecoration(
//                                 border: InputBorder.none,
//                                 hintText: "Enter Password",
//                                 hintStyle: TextStyle(
//                                   fontSize: 18,
//                                 ),
//                                 isDense: true,
//                                 prefixIconConstraints:
//                                     BoxConstraints(minHeight: 0, minWidth: 0),
//                                 // contentPadding: EdgeInsets.fromLTRB(170, 0, 0, 0)
//                               ),
//                               validator: (s) {
//                                 if (s == null || s.isEmpty) {
//                                   return "Enter Password";
//                                 } else {
//                                   return null;
//                                 }
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(0, (0.02 * height), 0, 0),
//                     child: SizedBox(
//                       width: (0.7194 * width),
//                       height: (0.0575 * height),
//                       child: ElevatedButton(
//                           onPressed: () {
//                             if (_formState.currentState!.validate()) {
//                               setState(() {
//                                 _signupBlock.add(
//                                   SignupButtonPressed(
//                                       name: nameController.text,
//                                       email: mailController.text,
//                                       password: passwordController.text),
//                                 );
//                               });
//                             }
//                           },
//                           style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xFF6F5B48),
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
//                           ),
//                           child: const Text(
//                             "Continue",
//                             style: TextStyle(fontSize: 19),
//                           )),
//                     ),
//                   ),
//                 ],
//               ),
