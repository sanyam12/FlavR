import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavr/core/components/heading.dart';
import 'package:flavr/core/data_provider/core_storage_provider.dart';
import 'package:flavr/features/profile_page/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/OrderData.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

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

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Heading(text: "Profile"),
      ),
      body: SafeArea(
        child: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ShowSnackBar) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
            if (state is ProfileDataState) {
              isLoading = false;
              userName = state.userName;
              list = state.list;
              email = state.email;
              profilePicUrl = state.profilePicUrl;
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0.03 * height, 0, 0),
                    child: SizedBox(
                      height: 0.2025 * height,
                      width: 0.9 * width,
                      child: Card(
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: const Color(0xFFF8F8F8),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(0, 0.02375 * height, 0, 4),
                              child: const Icon(
                                Icons.person_outline_rounded,
                                size: 75,
                              ),
                            ),
                            const Text(
                              "Sanyam Ratreja",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 0.01 * height),
                              child: const Text(
                                "sanyamratreja18@gmail.com",
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 0.1 * width,
                      right: 0.11389 * width,
                      top: 0.03*height,
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(
                            Icons.shopping_cart,
                            color: Colors.black,
                          ),
                          title: const Text(
                            "Orders",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          onTap: (){},
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.person_outline_rounded,
                            color: Colors.black,
                          ),
                          title: const Text(
                            "Edit Profile",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          ),
                          onTap: (){},
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.phone,
                            color: Colors.black,
                          ),
                          title: const Text(
                            "Contact Us",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          ),
                          onTap: (){},
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.home_filled,
                            color: Colors.black,
                          ),
                          title: const Text(
                            "About Us",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          ),
                          onTap: (){},
                        ),
                      ],
                    ),
                  ),

                ],
              ),
              Column(
                children: [
                  SizedBox(
                    width: 0.83 * width,
                    height: 0.0675 * height,
                    child: ElevatedButton(
                      onPressed: () async {
                        final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                        await prefs.remove("savedOutlets");
                        await FirebaseAuth.instance.signOut();
                        await CoreStorageProvider().removeToken();
                        if (context.mounted) {
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
                            Icon(
                              Icons.power_settings_new,
                              color: Colors.white,
                            ),
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
              )
            ],
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
