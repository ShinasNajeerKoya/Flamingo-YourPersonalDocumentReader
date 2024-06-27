import 'package:flemingo_pdfreader/constants/colors.dart';
import 'package:flemingo_pdfreader/constants/size_configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flemingo_pdfreader/constants/error_enum.dart';

class ErrorScreen extends StatelessWidget {
  final ErrorType errorType;

  const ErrorScreen({
    super.key,
    required this.errorType,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize SizeConfig
    SizeConfig().init(context);

    String svgIconPath;
    String errorHeader;
    String errorBody;
    Widget? actionButton;

    switch (errorType) {
      case ErrorType.noInternet:
        svgIconPath = "assets/svg_icons/no-internet.svg";
        errorHeader = "No Internet Connection";
        errorBody = "Please connect to the internet.";
        actionButton = _customErrorButton("Try again!!", () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Try Again Button Function yet to be updated"),
          ));
        });
        break;
      case ErrorType.notFound404:
        svgIconPath = "assets/svg_icons/404-page-not-found-2.svg";
        errorHeader = "404 - Page Not Found";
        errorBody = "Invalid format selected. Please select a PDF file.";
        actionButton = _customErrorButton("Go back!!", () {
          Navigator.pop(context);
        });
        break;
    }

    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: const AssetImage("assets/images/welcome_page.png"),
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.1),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Ooopss...!",
              style: GoogleFonts.poppins(
                fontSize: SizeConfig.getProportionateScreenHeight(50),
                fontWeight: FontWeight.w700,
                color: MyColors.darkGreen,
              ),
            ),
            SvgPicture.asset(
              height: SizeConfig.getProportionateScreenHeight(340),
              svgIconPath,
            ),
            const SizedBox(height: 40),
            Text(
              errorHeader,
              style: GoogleFonts.poppins(
                fontSize: SizeConfig.getProportionateScreenHeight(23),
                fontWeight: FontWeight.w700,
                color: MyColors.darkGreen,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "We're sorry,",
              style: GoogleFonts.poppins(
                fontSize: SizeConfig.getProportionateScreenHeight(16),
                fontWeight: FontWeight.w500,
                color: MyColors.darkGreen,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              errorBody,
              style: GoogleFonts.poppins(
                fontSize: SizeConfig.getProportionateScreenHeight(14),
                fontWeight: FontWeight.w400,
                color: MyColors.darkGreen,
              ),
            ),
            const SizedBox(height: 80),
            actionButton,
          ],
        ),
      ),
    );
  }

  GestureDetector _customErrorButton(String title, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.getProportionateScreenWidth(25),
          vertical: SizeConfig.getProportionateScreenHeight(13),
        ),
        decoration: BoxDecoration(
          color: MyColors.darkGreen,
          borderRadius: BorderRadius.circular(SizeConfig.getProportionateScreenWidth(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade600,
              offset: const Offset(0.0, 10.0),
              blurRadius: 10.0,
              spreadRadius: -5.0,
            ),
          ],
        ),
        child: Text(
          title,
          style: TextStyle(
            color: MyColors.backgroundColor,
            fontSize: SizeConfig.getProportionateScreenHeight(19),
          ),
        ),
      ),
    );
  }
}
