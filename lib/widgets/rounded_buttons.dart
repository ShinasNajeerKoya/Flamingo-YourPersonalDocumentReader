import 'package:flemingo_pdfreader/utils/dimensions.dart';
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
    return GestureDetector(
      onTap: press,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 16),
        padding: EdgeInsets.symmetric(vertical: Dimensions.height15, horizontal: Dimensions.height30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: [
            BoxShadow(offset: const Offset(0, 15), blurRadius: 30, color: const Color(0xff666666).withOpacity(0.20)),
          ],
        ),
        child: Text(
          text.toString(),
          style: TextStyle(fontSize: Dimensions.font15, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
