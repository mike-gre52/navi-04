import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whats_for_dinner/utils/colors.dart';

class GroupMember extends StatelessWidget {
  String circleText;
  String color;
  GroupMember({
    required this.circleText,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color memberColor = royalYellow;
    memberColor = Color(int.parse(color));
    print(circleText);
    return Column(
      children: [
        Column(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  width: 3,
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
                  circleText.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                      fontSize: 25,
                      color: memberColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(height: 5),
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
