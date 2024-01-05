
import 'package:flavr/pages/order_details/OrderDetails.dart';
import 'package:flavr/pages/profile_page/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../components/loading.dart';
import 'OrderData.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = "initial";
  bool isLoading = true;
  late Stream<List<OrderData>> list;

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
                });
              }

            },
            child: (isLoading)
                ? const Center(
                    child: CustomLoadingAnimation(),
                  )
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.arrow_back_ios),
                              ),
                              const Text(
                                "My Profile",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.edit,
                              color: Color(0xFFFDB703),
                            ),
                          )
                        ],
                      ),
                      CircleAvatar(
                        radius: 0.165 * width,
                      ),
                      Text(
                        userName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Row(
                        children: [
                          Text(
                            "Recent Orders",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          )
                        ],
                      ),
                      StreamBuilder(
                          stream: list,
                          builder: (context,
                              AsyncSnapshot<List<OrderData>> snapshot) {
                            if (snapshot.hasData) {
                              return Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      for (var i in snapshot.data!)
                                        OrderCard(
                                          width: width,
                                          height: height,
                                          orderData: i,
                                        )
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return const Center(
                                child: CustomLoadingAnimation(),
                              );
                            }
                          }),
                      ElevatedButton(
                          onPressed: ()async{
                            var service = const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));
                            await service.delete(key: "token");
                            if(context.mounted){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Logged Out!")));
                              Navigator.of(context).popAndPushNamed("/signInWithGoogle");
                            }
                          },
                          child: const Text("Log Out")
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  const OrderCard(
      {super.key,
      required this.width,
      required this.height,
      required this.orderData});

  final double width;
  final double height;
  final OrderData orderData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderDetails(
                      orderId: orderData.id,
                    )));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.02278 * width),
        child: SizedBox(
          width: width,
          height: 0.13625 * height,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Red Sauce Pasta",
                  ),
                  Card(
                    child: Container(
                      alignment: AlignmentDirectional.center,
                      width: 0.24166 * width,
                      height: 0.06625 * height,
                      child: const Text("₹100"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
