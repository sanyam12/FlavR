import 'package:flavr/core/components/button.dart';
import 'package:flavr/core/components/button_types.dart';
import 'package:flavr/core/components/heading.dart';
import 'package:flavr/core/components/loading.dart';
import 'package:flavr/core/components/text_field.dart';
import 'package:flavr/features/signup/presentation/widgets/image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
  final confirmPasswordController = TextEditingController();
  bool isChecked = false;
  final String lorem =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin iaculis congue tellus nec mattis. Proin a velit at erat bibendum venenatis quis vitae nisi. Quisque non fermentum libero. Duis sed mollis lorem, vel fermentum nibh. Maecenas posuere mauris dignissim volutpat suscipit. Duis eu ex nulla. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Duis nec eros porttitor, malesuada sem vel, interdum lacus. Pellentesque lacinia faucibus ipsum, non condimentum elit venenatis nec. Cras bibendum quam nulla, ac elementum dui placerat facilisis. Cras tristique egestas ultricies. Aenean quam lacus, aliquam non consequat id, feugiat sollicitudin odio. \n Donec sed nulla nisi. In id dui suscipit, molestie diam et, venenatis dui. In metus felis, sagittis vitae placerat eu, elementum eu nulla. Nam consequat porta libero in aliquam. Sed pretium nibh orci, vitae scelerisque neque finibus id. Maecenas a ullamcorper ante. Quisque porttitor fermentum interdum. Praesent ultricies tincidunt dolor.\nNullam vitae diam nisi. Praesent congue nunc non nisl interdum imperdiet. Quisque elementum, ex quis dictum dapibus, ex lorem iaculis sem, in sollicitudin dui leo in augue. Nulla lacinia a est quis lobortis. Quisque aliquet ante ante. Mauris consequat nibh non nisi rutrum, eu faucibus ligula rhoncus. Morbi elementum ipsum diam, quis sagittis diam elementum tempor. Fusce cursus hendrerit vehicula.\n Sed elementum nulla lorem, non consectetur felis ullamcorper ac. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Aliquam dapibus ullamcorper ex vitae congue. Curabitur at metus mattis, mattis tellus eget, mollis est. Morbi blandit eu ex nec luctus. Maecenas eget nunc feugiat, consequat quam ac, accumsan massa. Nunc elementum sit amet leo vel vehicula. Cras ipsum mauris, condimentum eu interdum scelerisque, finibus in orci. Nunc venenatis nibh quis tellus congue maximus.\nFusce viverra tellus nisl, sit amet porttitor tortor posuere ac. Etiam vestibulum placerat dui nec vehicula. Sed mi tellus, facilisis nec vehicula vitae, cursus non elit. Proin faucibus vel nisi in feugiat. Duis a ipsum nunc. Aliquam faucibus justo nec dolor vestibulum, lacinia finibus erat varius. Aliquam vehicula efficitur varius.";
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    mailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  _navigateToOTP(){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => OtpScreen(
          email: mailController.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);
    final width = queryData.size.width;
    final height = queryData.size.height;
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<SignupBloc, SignupState>(
          listener: (context, SignupState state) {
            if (state is SignupSuccessful) {
              _navigateToOTP();
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
                SnackBar(
                  content: Text(state.message),
                ),
              );
              _navigateToOTP();
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
            if (state is SignupLoading) {
              return const Center(
                child: CustomLoadingAnimation(),
              );
            }
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                      child: ImageCollection(width: width, height: height)),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.0175 * height),
                    child: const Heading(text: "Sign Up"),
                  ),
                  SizedBox(
                    width: 0.711 * width,
                    child: const Text(
                      "Before we begin, we require some of your information",
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TextFieldComponent(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    width: width,
                    controller: nameController,
                    hintText: "Enter your full name",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your Name";
                      }
                      return null;
                    },
                  ),
                  TextFieldComponent(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    width: width,
                    controller: mailController,
                    hintText: "Enter your email",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      }
                      return null;
                    },
                  ),
                  TextFieldComponent(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    width: width,
                    controller: passwordController,
                    hintText: "Enter your password",
                    obsecureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      }
                      if (passwordController.text !=
                          confirmPasswordController.text) {
                        return "Password doesn't match";
                      }
                      return null;
                    },
                  ),
                  TextFieldComponent(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    width: width,
                    controller: confirmPasswordController,
                    hintText: "Confirm Password",
                    obsecureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      }
                      if (passwordController.text !=
                          confirmPasswordController.text) {
                        return "Password doesn't match";
                      }
                      return null;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value ?? false;
                          });
                        },
                      ),
                      SizedBox(
                        width: 0.6805555556 * width,
                        child: RichText(
                          text: TextSpan(
                            text: "By creating an account you agree to the ",
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: "Terms of Use",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    _showLegal(
                                      heading: "Terms of Use",
                                      content: lorem,
                                    );
                                  },
                              ),
                              const TextSpan(text: " and "),
                              TextSpan(
                                text: "Privacy Policy",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    _showLegal(
                                      heading: "Privacy Policy",
                                      content: lorem,
                                    );
                                  },
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  //TODO: Add larger width option
                  ButtonComponent(
                    text: "Sign Up",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<SignupBloc>().add(
                              SignupButtonPressed(
                                name: nameController.text,
                                email: mailController.text,
                                password: passwordController.text,
                              ),
                            );
                      }
                    },
                    width: width,
                    height: height,
                    disabled: isChecked,
                    type: ButtonType.LongButton,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _showLegal({required String heading, required String content}) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Heading(text: heading),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.close,
                            size: 32,
                          ),
                        ),
                      ],
                    ),
                    RichText(
                        text: TextSpan(
                      text: content,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    )),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _later(width, height) {
    return [
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
        padding: EdgeInsets.fromLTRB(0, 0.0175 * height, 0, 0),
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
        padding: EdgeInsets.fromLTRB(0, 0.0175 * height, 0, 0),
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
        padding: EdgeInsets.fromLTRB(0, 0.01625 * height, 0, 0),
        child: SizedBox(
          width: 0.4 * width,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF004932),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 11),
              child: Text(
                "Sign Up",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),
            ),
          ),
        ),
      )
    ];
  }
}
