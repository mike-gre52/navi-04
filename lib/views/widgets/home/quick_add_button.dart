import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whats_for_dinner/utils/colors.dart';

class QuickAddButton extends StatelessWidget {
  String buttonText;
  Color buttonColor;
  QuickAddButton({
    required this.buttonText,
    required this.buttonColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;
    double height20 = screenHeight / 44.8;
    double height60 = screenHeight / 14.933;
    double width115 = screenWidth / 3.6;
    double fontSize16 = screenHeight / 56;
    return Container(
      height: height60,
      width: width115,
      decoration: BoxDecoration(
        border: Border.all(
          color: buttonColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(height20),
      ),
      child: Center(
        child: Text(
          buttonText,
          style: TextStyle(
            color: black,
            fontSize: fontSize16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
