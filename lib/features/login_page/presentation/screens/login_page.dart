import 'package:flavr/components/authentication_image_collection.dart';
import 'package:flavr/components/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final loginPageBloc = context.read<LoginBloc>();

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, LoginState state) {
          if (state is LoginSuccessful) {
            Navigator.popAndPushNamed(context, "/outletMenu");
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
        builder: (context, state){
          if(state is LoginLoading){
            return const Center(
              child: CustomLoadingAnimation(),
            );
          }
          return SingleChildScrollView(
            child: Stack(
              children: [
                ...AuthenticationImageCollection.build(width, height),
                Positioned(
                  top: 0.675 * height,
                  child: SizedBox(
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
                                loginPageBloc.add(
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
          );
        },
      ),
    );
  }
}
