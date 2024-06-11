import 'package:flemingo_pdfreader/utils/dimensions.dart';
import 'package:flutter/material.dart';

class FileOpenerButton extends StatelessWidget {
  const FileOpenerButton({
    super.key,
    required this.size,
    this.onPressed,
    required this.image,
    required this.title,
  });

  final Size size;
  final void Function()? onPressed;
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          height: Dimensions.height75,
          width: size.width / 2.28,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
              color: Colors.white,
              boxShadow: [BoxShadow(offset: const Offset(2, 7), blurRadius: 15, color: Colors.grey.shade400)]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: Dimensions.height45,
                width: Dimensions.height45,
                decoration: BoxDecoration(image: DecorationImage(image: AssetImage(image), fit: BoxFit.fill)),
              ),
              Padding(
                padding: EdgeInsets.only(right: Dimensions.width10),
                child: Text(title,
                    style: TextStyle(
                      fontSize: Dimensions.font18,
                    )),
              )
            ],
          )),
    );
  }
}
