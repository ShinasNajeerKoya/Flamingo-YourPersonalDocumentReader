import 'package:flemingo_pdfreader/constants/size_configuration.dart';
import 'package:flemingo_pdfreader/screens/home_screen.dart';
import 'package:flemingo_pdfreader/utils/colors.dart';
import 'package:flemingo_pdfreader/widgets/rounded_buttons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/images/welcome_page.png"),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "flamin",
                    style: GoogleFonts.poppins(
                      color: Colors.brown.shade600,
                      fontSize: SizeConfig.textMultiplier * 5,
                    ),
                  ),
                  TextSpan(
                    text: "go.",
                    style: GoogleFonts.poppins(
                      color: MyColors.brown,
                      fontSize: SizeConfig.textMultiplier * 5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: SizeConfig.getProportionateScreenWidth(175), // Example for dynamic button width
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


