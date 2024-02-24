import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(15,0,40,0),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                  // Add some space between the icon and text
                  Center(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(50,0,0,0),
                      child: Text(
                        "Profile",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "inter",
                          fontSize: 32,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0,24,0,0),
                    child: SizedBox(
                      height: 170,
                      width: 324,
                      child: Card(
                        color: Color(0xFFF8F8F8),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0,20,0,4),
                              child: Icon(
                                Icons.person_outline_rounded,
                                size: 75,
                              ),
                            ),
                            Text(
                              "Mridul Verma",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0,4,0,20),
                              child: Text(
                                "mridulverma478@gmail.com"
                              ),
                            )
                          ],
                        ) ,
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.1*width,36,0,0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.shopping_cart
                    ),
                     Padding(
                      padding: EdgeInsets.fromLTRB(0.03*width,0,0,0),
                      child: const Text(
                        "Orders",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.5*width,0,0,0),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.1*width,36,0,0),
                child: Row(
                  children: [
                    const Icon(
                        Icons.person_outline_rounded
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.03*width,0,0,0),
                      child: const Text(
                        "Personal information",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.21*width,0,0,0),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.1*width,36,0,0),
                child: Row(
                  children: [
                    const Icon(
                        Icons.phone
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.03*width,0,0,0),
                      child: const Text(
                        "Contact Us",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.41*width,0,0,0),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.1*width,36,0,0),
                child: Row(
                  children: [
                    const Icon(
                        Icons.home_filled
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.03*width,0,0,0),
                      child: const Text(
                        "About Us",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.44*width,0,0,0),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0,0.2025*height,0,0),
                child: SizedBox(
                  width: 0.83 * width,
                  height: 0.0675*height,
                  child: ElevatedButton(
                    onPressed: (){
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(15),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 11),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.power_settings_new
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(6,0,0,0),
                            child: Text(
                              "Log Out",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0,16,0,0),
                child: Divider(
                  color: Color(0xff8B8B8B),
                  thickness: 1,
                  indent: 30, // Adjust the left indentation as needed
                  endIndent: 30, // Adjust the right indentation as needed
                ),
              ),
              const Text("v1.0.0",
              style: TextStyle(
                color: Color(0xff8B8B8B)
              ),
              ),
              const Text("Made with 🖤 in India",
                style: TextStyle(
                    color: Color(0xff8B8B8B)
                ),),
              const Text("by Bistroverse",
                style: TextStyle(
                    color: Color(0xff8B8B8B)
                ),),
        ],
      )),
    );
  }
}
