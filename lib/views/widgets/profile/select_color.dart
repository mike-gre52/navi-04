import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:whats_for_dinner/data/local_data.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/app/border_button.dart';

class SelectColor extends StatelessWidget {
  const SelectColor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height20 = screenHeight / 44.8;
    double fontSize14 = screenHeight / 64;

    double fontSize24 = screenHeight / 37.333;
    double fontSize22 = screenHeight / 40.727;
    return Container(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Color',
            style: TextStyle(
              fontSize: fontSize22,
              fontWeight: FontWeight.w600,
              color: black,
            ),
          ),
          Text(
            'This color will be visibile to other group members',
            style: TextStyle(
              fontSize: fontSize14,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: height20),
          Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              children: [
                ColorSquare(color: color1),
                ColorSquare(color: color2),
                ColorSquare(color: color3),
                ColorSquare(color: color4),
                ColorSquare(color: color5),
                ColorSquare(color: color6),
                ColorSquare(color: color7),
                ColorSquare(color: color8),
                ColorSquare(color: color9),
                ColorSquare(color: color10),
                ColorSquare(color: color11),
                ColorSquare(color: color12),
                ColorSquare(color: color13),
                ColorSquare(color: color14),
                ColorSquare(color: color15),
                ColorSquare(color: color16),
                ColorSquare(color: color17),
                ColorSquare(color: color18),
              ],
            ),
          ),
          SizedBox(height: height20),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: fontSize22,
                fontWeight: FontWeight.w600,
                color: black,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ColorSquare extends StatelessWidget {
  Color color;
  ColorSquare({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double height7 = screenHeight / 128;
    double height40 = screenHeight / 22.4;

    return GestureDetector(
      onTap: (() {
        //sets local color
        Database().setColor(color.value.toString());
        //sets firebase color
        userController.setFirebaseUserColor(color.value.toString());
        //set firebase group color
        groupController.setFirebaseUserColorInGroup(color.value.toString());
        Navigator.pop(context);
      }),
      child: Container(
        margin: EdgeInsets.all(height7),
        height: height40,
        width: height40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
