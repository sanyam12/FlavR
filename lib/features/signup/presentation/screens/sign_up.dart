import 'package:flavr/components/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../components/authentication_image_collection.dart';
import '../../../otp_screen/presentation/screens/otp_screen.dart';
import '../../bloc/signup_bloc.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final mailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    mailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _signupBlock = context.read<SignupBloc>();
    final queryData = MediaQuery.of(context);
    final width = queryData.size.width;
    final height = queryData.size.height;
    return Scaffold(
      body: BlocConsumer<SignupBloc, SignupState>(
        listener: (context, SignupState state) {
          if (state is SignupSuccessful) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    OtpScreen(
                      email: mailController.text,
                    ),
              ),
            );
          }
          if (state is SignupFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
          if (state is VerificationPending) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message))
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    OtpScreen(
                      email: mailController.text,
                    ),
              ),
            );
          }
          if (state is UserAlreadyExists) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("User Already Exists, Please login"),
              ),
            );
            Navigator.popAndPushNamed(context, "/login");
          }
        },
        builder: (context, state) {
          if(state is SignupLoading){
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
                                  BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: () {
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
          );
        },
      ),
    );
  }
}