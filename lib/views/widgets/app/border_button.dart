import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class BorderButton extends StatelessWidget {
  Color buttonColor;
  String buttonText;
  double borderRadius;
  double buttonWidth;

  BorderButton({
    Key? key,
    required this.buttonColor,
    required this.buttonText,
    this.borderRadius = 18,
    this.buttonWidth = 125,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double fontSize22 = screenHeight / 40.727;
    return Container(
      height: 60,
      width: buttonWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: buttonColor, width: 2),
      ),
      child: Center(
        child: Text(
          buttonText,
          style: TextStyle(
            color: buttonColor,
            fontSize: fontSize22,
          ),
        ),
      ),
    );
  }
}
