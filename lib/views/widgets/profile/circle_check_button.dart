import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whats_for_dinner/utils/colors.dart';

class CircleCheckButton extends StatelessWidget {
  const CircleCheckButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double height30 = screenHeight / 29.86;
    double height50 = screenHeight / 17.92;
    return Container(
      height: height50,
      width: height50,
      decoration: BoxDecoration(
        color: royalYellow,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.check,
        color: Colors.white,
        size: height30,
      ),
    );
  }
}
