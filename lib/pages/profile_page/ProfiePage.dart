import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // my profile
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0.045 * height, 0, 0),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back_ios)),
                    const Text(
                      "My Profile",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.411 * width, 0, 0, 0),
                      child: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/edit_profile");
                          },
                          icon: const Icon(Icons.edit)),
                    )
                  ],
                ),
              ),

              // profile
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0.019 * height, 0, 0),
                child: const Icon(
                  Icons.account_circle_rounded,
                  size: 80,
                ),
              ),

              //akshita goyal
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0.015 * height, 0, 0),
                child: const Text(
                  "Akshita Goyal",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                  ),
                ),
              ),

              //recent order
              Padding(
                padding:
                    EdgeInsets.fromLTRB(0.05277 * width, 0.03375 * height, 0, 0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Recent Orders",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),

              //card
              Padding(
                padding: EdgeInsets.fromLTRB(0,0.02*height,0,0),
                child: SizedBox(
                  width: 0.9416*width,
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Color(0xffBDBDBC))
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0,0.015*height,0,0),
                          child: SizedBox(
                            height:0.13625*height ,
                            width: 0.8861*width,
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),

                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0.044*width,0.04*height,0,0),
                                    child: SizedBox(
                                      width: 0.25*width,
                                      height: 0.08125*height,
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: 65,
                                            height: 65,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: AssetImage('assets/images/hamburger.jpg'),
                                                  fit: BoxFit.fill
                                              ),
                                            ),
                                          ),
                                          // Container(
                                          //   width: 65,
                                          //   height: 65,
                                          //   decoration: const BoxDecoration(
                                          //     shape: BoxShape.circle,
                                          //     image: DecorationImage(
                                          //         image: AssetImage('assets/images/hamburger.jpg'),
                                          //         fit: BoxFit.fill
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],


                    )

                  ),
                ),
              )
        ],
      ),
    ));
  }
}
