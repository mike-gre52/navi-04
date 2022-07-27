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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headerText,
          style: TextStyle(
            fontSize: 20,
            color: black,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          height: 5,
          width: 30,
          color: dividerColor,
        )
      ],
    );
  }
}
