import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:whats_for_dinner/utils/colors.dart';

class TapHereRichText extends StatelessWidget {
  const TapHereRichText({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;

    double height5 = screenHeight / 179.2;
    double height15 = screenHeight / 59.73;
    double height50 = screenHeight / 17.92;

    double fontSize18 = screenHeight / 49.77;
    return Center(
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: 'Tap here',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: royalYellow,
                fontSize: fontSize18,
              ),
            ),
            TextSpan(
                text: ' to create one',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: black,
                  fontSize: fontSize18,
                )),
          ],
        ),
      ),
    );
  }
}
