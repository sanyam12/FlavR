import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavr/core/components/heading.dart';
import 'package:flavr/features/orders_list/bloc/orders_list_bloc.dart';
import 'package:flavr/features/orders_list/presentation/widgets/order_details_overlay.dart';
import 'package:flavr/features/outlets_list_page/bloc/outlet_list_bloc.dart';
import 'package:flavr/pages/profile_page/OrderData.dart';
import 'package:flavr/pages/profile_page/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersList extends StatefulWidget {
  const OrdersList({super.key});

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  List<OrderData> list = [];
  String userName = "initial";
  bool isLoading = true;
  String email = "initial";
  String profilePicUrl = "null";

  @override
  void initState() {
    super.initState();
    context.read<OrdersListBloc>().add(GetProfileData());
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: BlocListener<OrdersListBloc, OrdersListState>(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0.0225 * height, 0, 0),
              child: Row(
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
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            0.18 * width, 0, 0, 0),
                        child: const Heading(
                          text: "Live Orders",
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/profile");
                    },
                    icon: const Icon(
                      Icons.person_2_rounded,
                      color: Color(0xFF004932),
                      size: 32,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  0.05 * width, 0.00875 * height, 0, 0),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Almost there! We're whipping up your favorites",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "with a dash of joy...",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  0.05 * width, 0.00875 * height, 0, 0),
              child: Text(
                "Pending Order : ${list.length}",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var i in list)
                        OrderCard(
                            width: width,
                            height: height,
                            data: i,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
),
      ),
    );
  }
}
