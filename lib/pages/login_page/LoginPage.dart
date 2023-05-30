import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final controller = TextEditingController();
  final _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);
    final width = queryData.size.width;
    final height = queryData.size.height;

    return Scaffold(
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
                    "assets/animations/login_page_animation.json"
                ),
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
                padding:
                EdgeInsets.fromLTRB(0, (0.0675 * height), 0, 0),
                child: RuledHeading(
                  width: (0.230556 * width),
                  title: "Login or Sign Up",
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
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(13, 0, 0, 0),
                      child: Center(
                        child: TextFormField(
                          controller: controller,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Phone Number",
                              hintStyle: TextStyle(
                                fontSize: 18,
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 7.0, 0),
                                child: Text(
                                  "+91",
                                  style: TextStyle(
                                      fontSize: 18
                                  ),
                                ),
                              ),
                              isDense: true,
                              prefixIconConstraints: BoxConstraints(
                                  minHeight: 0, minWidth: 0),
                              contentPadding: EdgeInsets.fromLTRB(170, 0, 0, 0)
                          ),
                          validator: (s){
                            if(s==null || s.isEmpty) {
                                return "Enter Phone No.";
                            }else{
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
                  width: (0.719444 * width),
                  height: (0.0575 * height),
                  child: ElevatedButton(
                      onPressed: () {
                       if( _formState.currentState!.validate()){
                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Logging you In")));
                       }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6F5B48)
                      ),
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                            fontSize: 19
                        ),
                      )
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(0, (0.025 * height), 0, 0),
                child: RuledHeading(
                    width: (0.35 * width),
                    title: "or"
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(0, 28, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 66,
                      height: 66,
                      child: IconButton(
                          onPressed: (){
                            Navigator.pushNamed(context, "/homePage");
                          },
                          icon: Image.asset(
                            "assets/images/google.png",
                            fit: BoxFit.cover,
                          ),
                      ),
                    ),

                    SizedBox(
                      width: 66,
                      height: 66,
                      child: IconButton(
                        onPressed: (){},
                        icon: Image.asset(
                          "assets/images/facebook.png",
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
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
