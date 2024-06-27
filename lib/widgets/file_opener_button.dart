import 'package:flemingo_pdfreader/constants/size_configuration.dart';
import 'package:flutter/material.dart';

class FileOpenerButton extends StatelessWidget {
  final String image;
  final String title;
  final void Function()? onPressed;

  const FileOpenerButton({
    super.key,
    this.onPressed,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: SizeConfig.getProportionateScreenHeight(70),
        width: SizeConfig.getProportionateScreenWidth(180 - 15),
        // Adjust width proportionally
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.getProportionateScreenWidth(10)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConfig.getProportionateScreenHeight(15)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(2, 7),
              blurRadius: 15,
              color: Colors.grey.shade400,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: SizeConfig.getProportionateScreenHeight(45),
              width: SizeConfig.getProportionateScreenHeight(45),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: SizeConfig.getProportionateScreenHeight(15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

