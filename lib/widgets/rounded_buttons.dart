import 'package:flemingo_pdfreader/constants/size_configuration.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String? text;
  final void Function()? press;

  const RoundedButton({
    super.key,
    this.text,
    this.press,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize SizeConfig
    SizeConfig().init(context);

    return GestureDetector(
      onTap: press,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: SizeConfig.getProportionateScreenHeight(16)),
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.getProportionateScreenHeight(15),
          horizontal: SizeConfig.getProportionateScreenWidth(30),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConfig.getProportionateScreenWidth(30)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 15),
              blurRadius: SizeConfig.getProportionateScreenHeight(30),
              color: const Color(0xff666666).withOpacity(0.20),
            ),
          ],
        ),
        child: Text(
          text.toString(),
          style: TextStyle(
            fontSize: SizeConfig.getProportionateScreenHeight(15),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}


