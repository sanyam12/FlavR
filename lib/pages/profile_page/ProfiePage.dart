import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavr/core/data_provider/core_storage_provider.dart';
import 'package:flavr/pages/profile_page/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'OrderData.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = "initial";
  bool isLoading = true;
  String email = "initial";
  String profilePicUrl = "null";
  List<OrderData> list = [];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final bloc = ProfileBloc();

    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) {
            bloc.add(GetProfileData());
            return bloc;
          },
          child: BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ShowSnackbar) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.messsage)));
              } else if (state is ProfileDataState) {
                setState(() {
                  isLoading = false;
                  userName = state.userName;
                  list = state.list;
                  email = state.email;
                  profilePicUrl = state.profilePicUrl;
                });
              }
            },
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 40, 0),
                      child: IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                    // Add some space between the icon and text
                    Center(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
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
                      padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
                      child: SizedBox(
                        height: 170,
                        width: 324,
                        child: Card(
                          color: Color(0xFFF8F8F8),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 20, 0, 4),
                                child: Icon(
                                  Icons.person_outline_rounded,
                                  size: 75,
                                ),
                              ),
                              Text(
                                "Sanyam Ratreja",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 4, 0, 20),
                                child: Text("sanyamratreja18@gmail.com"),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.1 * width, 36, 0, 0),
                  child: Row(
                    children: [
                      const Icon(Icons.shopping_cart),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.03 * width, 0, 0, 0),
                        child: const Text(
                          "Orders",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.5 * width, 0, 0, 0),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.1 * width, 36, 0, 0),
                  child: Row(
                    children: [
                      const Icon(Icons.person_outline_rounded),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.03 * width, 0, 0, 0),
                        child: const Text(
                          "Personal information",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.25 * width, 0, 0, 0),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.1 * width, 36, 0, 0),
                  child: Row(
                    children: [
                      const Icon(Icons.phone),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.03 * width, 0, 0, 0),
                        child: const Text(
                          "Contact Us",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.43 * width, 0, 0, 0),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.1 * width, 36, 0, 0),
                  child: Row(
                    children: [
                      const Icon(Icons.home_filled),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.03 * width, 0, 0, 0),
                        child: const Text(
                          "About Us",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.47 * width, 0, 0, 0),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0.2025 * height, 0, 0),
                  child: SizedBox(
                    width: 0.83 * width,
                    height: 0.0675 * height,
                    child: ElevatedButton(
                      onPressed: () async {
                        final SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.remove("savedOutlets");
                        await FirebaseAuth.instance.signOut();
                        await CoreStorageProvider().removeToken();
                        if(context.mounted){
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            "/signInWithGoogle",
                                (route) => false,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 11),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.power_settings_new, color: Colors.white,),
                            Padding(
                              padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                              child: Text(
                                "Log Out",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: Divider(
                    color: Color(0xff8B8B8B),
                    thickness: 1,
                    indent: 30, // Adjust the left indentation as needed
                    endIndent: 30, // Adjust the right indentation as needed
                  ),
                ),
                const Text(
                  "v1.0.0",
                  style: TextStyle(color: Color(0xff8B8B8B)),
                ),
                const Text(
                  "Made with 🖤 in India",
                  style: TextStyle(color: Color(0xff8B8B8B)),
                ),
                const Text(
                  "by Bistroverse",
                  style: TextStyle(color: Color(0xff8B8B8B)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class OrderCard extends StatelessWidget {
//   const OrderCard(
//       {super.key,
//       required this.width,
//       required this.height,
//       required this.orderData});
//
//   final double width;
//   final double height;
//   final OrderData orderData;
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => OrderDetails(
//                       orderId: orderData.id,
//                     )));
//       },
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 0.02278 * width),
//         child: SizedBox(
//           width: width,
//           height: 0.13625 * height,
//           child: Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     "Red Sauce Pasta",
//                   ),
//                   Card(
//                     child: Container(
//                       alignment: AlignmentDirectional.center,
//                       width: 0.24166 * width,
//                       height: 0.06625 * height,
//                       child: const Text("₹100"),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
