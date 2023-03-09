import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whats_for_dinner/utils/colors.dart';

class Header extends StatelessWidget {
  String headerText;
  Color dividerColor;
  Header({
    required this.headerText,
    required this.dividerColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;
    double height5 = screenHeight / 179.2;
    double width30 = screenWidth / 13.8;
    double fontSize20 = screenHeight / 44.8;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headerText,
          style: TextStyle(
            fontSize: fontSize20,
            color: black,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          height: height5,
          width: width30,
          color: dividerColor,
        )
      ],
    );
  }
}
