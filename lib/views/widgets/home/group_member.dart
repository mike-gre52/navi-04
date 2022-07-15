import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whats_for_dinner/utils/colors.dart';

class GroupMember extends StatelessWidget {
  String circleText;
  GroupMember({
    required this.circleText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 75,
          width: 75,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(width: 3, color: royalYellow),
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
              circleText,
              style: TextStyle(
                  fontSize: 25,
                  color: royalYellow,
                  fontWeight: FontWeight.w500),
            ),
          ),
        )
      ],
    );
  }
}
