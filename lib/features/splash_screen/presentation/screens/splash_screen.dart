import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/splash_screen_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SplashScreenBloc>().add(TimerTriggered());
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocListener<SplashScreenBloc, SplashScreenState>(
      listener: (context, state) {
        if (state is SplashScreenSignedIn) {
          Navigator.popAndPushNamed(context, "/outletMenu");
        }
        if (state is SplashScreenNotSignedIn) {
          Navigator.popAndPushNamed(context, "/signInWithGoogle");
        }
        if (state is SplashScreenErrorOccurred) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Decoding failed")),
          );
        }
      },
      child: Scaffold(
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
                    Text(
                      "Made with ❤️ in India By",
                      style: TextStyle(
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      width: 0.2444 * width,
                      child: Image.asset("assets/images/bistroverse.png"),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
