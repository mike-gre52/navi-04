import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:whats_for_dinner/utils/colors.dart';

class BlueFolder extends StatelessWidget {
  const BlueFolder({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double fortyFivePercent = screenHeight * .45;

    double height5 = screenHeight / 186.4;
    double height20 = screenHeight / 48.6;
    double height50 = screenHeight / 17.92;
    double height55 = screenHeight / 16.945;

    double width30 = screenWidth / 13.8;
    double width100 = screenWidth / 4.3;

    double fontSize28 = screenHeight / 33.285;
    double fontSize16 = screenHeight / 58.25;
    double fontSize18 = screenHeight / 51.777;
    double fontSize20 = screenHeight / 44.8;
    return Transform.scale(
      scale: screenHeight / 896,
      child: Stack(
        children: [
          Container(
            height: 80,
            width: 90,
          ),
          Positioned(
            top: 3,
            child: Container(
              height: 30,
              width: 50,
              decoration: BoxDecoration(
                color: lightBlue,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(20),
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            child: Container(
              height: 70,
              width: 90,
              decoration: BoxDecoration(
                color: appBlue,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            left: 20,
            right: 20,
            child: Container(
              height: 5,
              width: 60,
              decoration: BoxDecoration(
                color: veryLightBlue,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          )
        ],
      ),
    );
  }
}
