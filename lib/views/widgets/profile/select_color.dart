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
    return Container(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Color',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: black,
            ),
          ),
          const Text(
            'This color will be visibile to other group members',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
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
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: 22,
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
    return GestureDetector(
      onTap: (() async {
        String oldColor = await Database().getColor();
        //sets local color
        Database().setColor(color.value.toString());
        //sets firebase color
        userController.setFirebaseUserColor(color.value.toString());
        //set firebase group color
        groupController.setFirebaseUserColorInGroup(
          color.value.toString(),
          oldColor,
        );
        Navigator.pop(context);
      }),
      child: Container(
        margin: EdgeInsets.all(7),
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
