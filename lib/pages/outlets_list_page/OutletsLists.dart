import 'dart:async';
import 'dart:developer';

import 'package:flavr/pages/outlets_list_page/outlet_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../outlet_menu/Outlet.dart';

class OutletsList extends StatefulWidget {
  const OutletsList({Key? key}) : super(key: key);

  @override
  State<OutletsList> createState() => _OutletsListState();
}

class _OutletsListState extends State<OutletsList> {
  final controller = TextEditingController();
  late final OutletListBloc _outletListBloc;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    StreamController<List<Outlet>> list = StreamController<List<Outlet>>();
    //List<Outlet> outletList = [];

    return Scaffold(
      body: SafeArea(
        child: BlocProvider<OutletListBloc>(
          create: (context) {
            _outletListBloc = OutletListBloc();
            _outletListBloc.add(GetAllOutletsList());
            return _outletListBloc;
          },
          child: BlocListener<OutletListBloc, OutletListState>(
            listener: (context, state) {
              if (state is NavigateToProfile) {
                Navigator.pushNamed(context, "/profile");
              }
              else if (state is ScanButtonClicked) {
                Navigator.pushNamed(context, "/outletList/addOutlet");
              }
              else if (state is GetAllOutletsListState) {
                setState(() {
                  list.add(state.list);
                  log(state.list.toString());
                  //outletList = state.list;
                });
              }
              else if (state is OutletSelected){
                Navigator.pop(context);
              }
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(7, 0, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Choose Outlet",
                        style: TextStyle(
                            fontFamily: "inter",
                            fontSize: 30,
                            fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                        child: IconButton(
                          onPressed: () {
                            _outletListBloc.add(OnScanQRCoreClick());
                          },
                          icon: const Icon(Icons.qr_code_scanner),
                          iconSize: 30,
                        ),
                      )
                    ],
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
                                      _outletListBloc
                                          .add(const OnProfileButtonClicked());
                                    },
                                    icon: const Icon(
                                        Icons.person_outline_rounded),
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
                Expanded(
                    child: StreamBuilder(
                        stream: list.stream,
                        builder:
                            (context, AsyncSnapshot<List<Outlet>> snapshot) {
                          if (snapshot.data != null) {
                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, count) {
                                return InkWell(
                                  onTap: (){
                                    _outletListBloc.add(
                                        OnOutletSelection(
                                            snapshot.data![count].id
                                        )
                                    );
                                  },
                                  child: Frame(
                                    width: width,
                                    height: height,
                                    name: snapshot.data![count].outletName,
                                    imageUrl: snapshot.data![count].imageUrl,
                                  ),
                                );
                              },
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator()
                            );
                          }
                        }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Frame extends StatelessWidget {
  const Frame(
      {Key? key,
      required this.height,
      required this.width,
      required this.name,
      required this.imageUrl})
      : super(key: key);
  final double height;
  final double width;
  final String name;
  final String? imageUrl;

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
                      child: (imageUrl=="null")? Image.asset(
                "assets/images/burger.jpg",
                fit: BoxFit.fill,
              ):Image.network(imageUrl!),
                  ),
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(9.0, 0, 0, 0),
                        child: Text(
                          name,
                          style: const TextStyle(
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
