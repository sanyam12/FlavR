import 'package:flutter/material.dart';

class EdittProfile extends StatefulWidget {
  const EdittProfile({Key? key}) : super(key: key);
  @override
  State<EdittProfile> createState() => _EdittProfile();
}

class _EdittProfile extends State<EdittProfile> {
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
                    padding: EdgeInsets.fromLTRB(15,10,40,0),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                  // Add some space between the icon and text
                  Center(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(25,10,0,0),
                      child: Text(
                        "Edit Profile",
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
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0,20,0,4),
                            child: Icon(
                              Icons.person_outline_rounded,
                              size: 100,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0,0.0125*height,0,0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.09*width,0,0,0),
                          child: const Text(
                            "Full Name",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold

                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.58*width,0,0,0),
                          child: const Icon(
                            Icons.edit,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0,0.006*height,0,0),
                      child: SizedBox(
                        width: 0.9 * width,
                        height: 0.06*height,
                        child:
                           Padding(
                             padding: EdgeInsets.fromLTRB(0.03*width,0.01*height,0.03*width,0),
                             child:  TextField(
                               decoration: InputDecoration(
                                 hintText: "Akshita Goyal",
                                 border: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(10)
                                 )
                               ),


                             ),
                           )
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0,0.0125*height,0,0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.09*width,0,0,0),
                          child: const Text(
                            "Email",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold

                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.66*width,0,0,0),
                          child: const Icon(
                            Icons.edit,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0,0.006*height,0,0),
                      child: SizedBox(
                          width: 0.9 * width,
                          height: 0.06*height,
                          child:
                          Padding(
                            padding: EdgeInsets.fromLTRB(0.03*width,0.01*height,0.03*width,0),
                            child:  TextField(
                              decoration: InputDecoration(
                                  hintText: "Akshita@gmail.com",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  )
                              ),


                            ),
                          )
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0,0.0125*height,0,0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.09*width,0,0,0),
                          child: const Text(
                            "Phone",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold

                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.643*width,0,0,0),
                          child: const Icon(
                            Icons.edit,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0,0.006*height,0,0),
                      child: SizedBox(
                          width: 0.9 * width,
                          height: 0.06*height,
                          child:
                          Padding(
                            padding: EdgeInsets.fromLTRB(0.03*width,0.01*height,0.03*width,0),
                            child:  TextField(
                              decoration: InputDecoration(
                                  hintText: "1234567890",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  )
                              ),


                            ),
                          )
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0,0.0125*height,0,0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.09*width,0,0,0),
                          child: const Text(
                            "Gender",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold

                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.63*width,0,0,0),
                          child: const Icon(
                            Icons.edit,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0,0.006*height,0,0),
                      child: SizedBox(
                          width: 0.9 * width,
                          height: 0.06*height,
                          child:
                          Padding(
                            padding: EdgeInsets.fromLTRB(0.03*width,0.01*height,0.03*width,0),
                            child:  TextField(
                              decoration: InputDecoration(
                                  hintText: "Female",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  )
                              ),


                            ),
                          )
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0,0.13*height,0,0),
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
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(6,0,0,0),
                          child: Text(
                            "Save",
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

            ],
          )),
    );
  }
}
