import 'package:flutter/material.dart';

class OutletsList extends StatefulWidget {
  const OutletsList({Key? key}) : super(key: key);

  @override
  State<OutletsList> createState() => _OutletsListState();
}

class _OutletsListState extends State<OutletsList> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(7, 0.05*height , 0 ,0),
            child: Container(
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: const Text(
                "Choose Outlet",
                style: TextStyle(
                  fontFamily:"inter",
                  fontSize: 30,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0 , 0.015*height , 0 ,0),
            child: Center(
              child: SizedBox(
                height: 0.065*height,
                width: 0.91111*width,
                child: TextField(
                  controller: controller,
                  decoration:  InputDecoration(
                    hintText: "Hinted search text",
                    hintStyle: const  TextStyle(
                      color:  Color(0xFFBBB7B7),
                      fontSize: 20,
                    ),
                    prefixIcon:  const Icon(
                      Icons.search
                    ),
                    suffixIcon: const Icon(
                      Icons.person_outline_rounded
                    ),
                    filled: true,
                    fillColor:  const Color(0xFFFFFAEA),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )
                  ),
                ),
              ),
            ),
          ),
           Frame(height:height, width: width)
        ],
      ),
    );
  }
}
class Frame extends StatelessWidget {
  const Frame({Key? key , required this.height ,required this.width}) : super(key: key);
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.symmetric(horizontal: 0.05*width , vertical: 0.03*height),
      child: Card(
          elevation: 5 ,
          shadowColor: Colors.black,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: width,
              height: 0.25*height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width:  width,
                      height:0.20*height,
                      child: Image.asset("assets/images/burger.jpg" , fit: BoxFit.fill,)),
                  const Text("Domino's , India")
                ],
              ),
            ),
          )
      ),
    );
  }
}
