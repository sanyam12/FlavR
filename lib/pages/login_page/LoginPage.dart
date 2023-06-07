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
          backgroundColor: const Color(0xFFFFFFFF),
          body: SafeArea(
            child: SingleChildScrollView(
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
                            child: const Text(
                              "flavR",
                              style: TextStyle(
                                  fontSize: 50,
                                  color: Color(0xFF004932),
                                  fontFamily: "Jim Nightshade"),
                            ),
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
                              padding: EdgeInsets.fromLTRB(
                                  0, 0.01625 * height, 0, 0),
                              child: SizedBox(
                                width: 0.4 * width,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF004932),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                  onPressed: () {
                                    _loginPageBloc.add(
                                      LoginButtonPressed(
                                        email: mailController.text,
                                        password: passwordController.text,
                                      ),
                                    );
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 11),
                                    child: Text("Login"),
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
//                       title: "Login",
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
//                                 _loginPageBloc.add(
//                                     LoginButtonPressed(
//                                         email: mailController.text,
//                                         password: passwordController.text
//                                     ),
//                                 );
//                               });
//                             }
//                           },
//                           style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xFF6F5B48),
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
//                           ),
//                           child: const Text(
//                             "Continue",
//                             style: TextStyle(fontSize: 19),
//                           )),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
//                     child: SizedBox(
//                       width: (0.719444 * width),
//                       child: GestureDetector(
//                         onTap: (){
//                           Navigator.pushNamed(context, "/signUp");
//                         },
//                           child: const Text("Don’t have account? Sign Up"),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(0, (0.025 * height), 0, 0),
//                     child: RuledHeading(width: (0.35 * width), title: "or"),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text("Implementation Pending"),
//                         ),
//                       );
//                     },
//                     style:
//                         ElevatedButton.styleFrom(backgroundColor: Colors.white),
//                     child: SizedBox(
//                       width: (0.7194 * width),
//                       height: (0.0575 * height),
//                       child: Row(
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.fromLTRB(
//                                 (0.0972222 * width), 0, 0, 0),
//                             child: SizedBox(
//                               width: 25,
//                               height: 25,
//                               child: _riveArtboard == null
//                                   ? const SizedBox()
//                                   : Rive(artboard: _riveArtboard!),
//                             ),
//                           ),
//                           const Padding(
//                             padding: EdgeInsets.fromLTRB(8.0, 0, 0, 0),
//                             child: Text(
//                               "Continue with Google",
//                               style: TextStyle(color: Colors.black),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               )
