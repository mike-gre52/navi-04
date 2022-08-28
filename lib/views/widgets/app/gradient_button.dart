import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GradientButton extends StatelessWidget {
  String buttonText;
  Color firstColor;
  Color secondColor;
  bool showArrow;

  GradientButton({
    Key? key,
    required this.buttonText,
    required this.firstColor,
    required this.secondColor,
    this.showArrow = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height30 = screenHeight / 29.86;
    double height65 = screenHeight / 13.78;
    double width165 = screenWidth / 2.509;
    double fontSize22 = screenHeight / 40.727;

    return Container(
      height: height65,
      width: width165,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: const [0, 1],
          colors: [firstColor, secondColor],
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: height30),
        child: showArrow
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    buttonText,
                    style: TextStyle(color: Colors.white, fontSize: fontSize22),
                  ),
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  )
                ],
              )
            : Center(
                child: Text(
                  buttonText,
                  style: TextStyle(color: Colors.white, fontSize: fontSize22),
                ),
              ),
      ),
    );
  }
}
