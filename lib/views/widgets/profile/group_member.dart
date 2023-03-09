import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whats_for_dinner/utils/colors.dart';

class GroupMember extends StatelessWidget {
  String circleText;
  String color;
  bool isExtra;
  GroupMember({
    required this.circleText,
    required this.color,
    required this.isExtra,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height5 = screenHeight / 179.2;
    double height50 = screenHeight / 17.92;
    double width3 = screenWidth / 138;
    double fontSize24 = screenHeight / 37.333;

    Color memberColor = royalYellow;
    memberColor = Color(int.parse(color));
    return Column(
      children: [
        Column(
          children: [
            Container(
              height: height50,
              width: height50,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  width: width3,
                  color: memberColor,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(180, 180, 180, 1.0),
                    offset: Offset(0.0, 1.0),
                    blurRadius: 3.0,
                    spreadRadius: 1.0,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  isExtra
                      ? circleText
                      : circleText.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                      fontSize: fontSize24,
                      color: memberColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(height: height5),
            /*
            Text(
              circleText.substring(0, 1).toUpperCase() +
                  circleText.substring(1),
              style: TextStyle(
                fontSize: 15,
                color: black,
                fontWeight: FontWeight.w600,
              ),
            ),
            */
          ],
        )
      ],
    );
  }
}
