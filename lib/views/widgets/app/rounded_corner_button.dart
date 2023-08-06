import 'package:flutter/material.dart';
import 'package:whats_for_dinner/utils/colors.dart';

class RoundedCornerButton extends StatelessWidget {
  final IconData icon;
  final String text;
  const RoundedCornerButton({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double height5 = screenHeight / 179.2;
    double height15 = screenHeight / 59.73;
    double height90 = screenHeight / 9.95;
    double iconSize30 = screenHeight / 29.86;
    double fontSize18 = screenHeight / 49.77;

    return Container(
      height: 75,
      width: 75,
      decoration: BoxDecoration(
          //color: black,
          borderRadius: BorderRadius.circular(height15),
          border: Border.all(color: royalYellow, width: 2)),
      child: Container(
        margin: EdgeInsets.only(top: height5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              color: black,
              size: iconSize30,
            ),
            SizedBox(
              height: height5,
            ),
            Text(
              text,
              style: TextStyle(
                color: black,
                fontSize: fontSize18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
