
import 'package:flemingo_pdfreader/screens/home_screen.dart';
import 'package:flemingo_pdfreader/utils/colors.dart';
import 'package:flemingo_pdfreader/widgets/rounded_buttons.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../utils/dimensions.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
            image: DecorationImage(fit: BoxFit.fill, image: AssetImage("assets/images/welcome_page.png"))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Expanded(child: Container()),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "flamin",
                    style: GoogleFonts.poppins(
                      color: Colors.brown.shade600,
                      fontSize: Dimensions.font34,
                    ),
                  ),
                  TextSpan(
                    text: "go.",
                    style: GoogleFonts.poppins(
                      color: MyColors.brown,
                      fontSize: Dimensions.font34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: Dimensions.width175,
              child: RoundedButton(
                text: "Start Reading",
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
