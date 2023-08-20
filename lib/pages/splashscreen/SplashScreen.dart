import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 3),
      ()async {

        var service = const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));
        String? token = await service.read(key: "token");
        if(token==null){
          if(context.mounted){
            Navigator.popAndPushNamed(context, "/signInWithGoogle");
          }
        }
        else{
          try {
            bool hasExpired = JwtDecoder.isExpired(token);
            if(!hasExpired){
              if(context.mounted){
                Navigator.popAndPushNamed(context, "/outletMenu");
              }
            }else{
              log("token expired");
              if(context.mounted){
                Navigator.popAndPushNamed(context, "/signInWithGoogle");
              }
            }
          } catch (e) {
            if(context.mounted){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Decoding failed")));
            }
          }


        }

      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              width: 0.45556 * width,
              child: Image.asset("assets/images/flavr-logo.png"),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0.035 * height),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text("By"),
                  const Text(
                    "Made with ❤️ in India By",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  Container(
                    width: 0.2444 * width,
                    child: Image.asset("assets/images/bistroverse.png"),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

//return Scaffold(
//       body: DecoratedBox(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage("assets/images/coffee.png"), fit: BoxFit.cover),
//         ),
//         child: Stack(
//           children: [
//             const Center(
//               child: Image(image: AssetImage("assets/images/nescafe.png")),
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Padding(
//                 padding: EdgeInsets.fromLTRB(0, 0, 0, 0.0525 * height),
//                 child: const Text(
//                   "It all starts with nescafe",
//                   style: TextStyle(
//                       fontSize: 23,
//                       fontWeight: FontWeight.bold,
//                       fontStyle: FontStyle.italic,
//                       color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
