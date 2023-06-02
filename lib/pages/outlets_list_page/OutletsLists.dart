import 'package:flavr/pages/outlets_list_page/outlet_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OutletsList extends StatefulWidget {
  const OutletsList({Key? key}) : super(key: key);

  @override
  State<OutletsList> createState() => _OutletsListState();
}

class _OutletsListState extends State<OutletsList> {
  final controller = TextEditingController();
  final _outletListBloc = OutletListBloc();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return _outletListBloc;
        },
        child: BlocListener<OutletListBloc, OutletListState>(
          listener: (context, state) {
            if (state is NavigateToProfile) {
              Navigator.pushNamed(context, "/profile");
            }
          },
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(7, 0.05 * height, 0, 0),
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Choose Outlet",
                    style: TextStyle(
                        fontFamily: "inter",
                        fontSize: 30,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0.015 * height, 0, 0),
                child: Center(
                  child: SizedBox(
                    height: 0.065 * height,
                    width: 0.91111 * width,
                    child: Container(
                      // color: Colors.red,
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 0),
                            hintText: "Hinted search text",
                            hintStyle: const TextStyle(
                              color: Color(0xFFBBB7B7),
                              fontSize: 20,
                            ),
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 6),
                              child: CircleAvatar(
                                child: IconButton(
                                  onPressed: () {
                                    _outletListBloc.add(const OnProfileButtonClicked());
                                  },
                                  icon: const Icon(Icons.person_outline_rounded),
                                ),
                              ),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFFFFAEA),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            )),
                      ),
                    ),
                  ),
                ),
              ),
              Frame(height: height, width: width)
            ],
          ),
        ),
      ),
    );
  }
}

class Frame extends StatelessWidget {
  const Frame({Key? key, required this.height, required this.width})
      : super(key: key);
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 0.05 * width, vertical: 0.005 * height),
      child: Card(
          elevation: 5,
          shadowColor: Colors.black,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: width,
              height: 0.25 * height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: width,
                      height: 0.20 * height,
                      child: Image.asset(
                        "assets/images/burger.jpg",
                        fit: BoxFit.fill,
                      )),
                  const Expanded(
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(9.0, 0, 0, 0),
                        child: Text(
                          "Domino's , India",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "inter",
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
