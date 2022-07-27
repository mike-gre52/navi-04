import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class AppHeader extends StatelessWidget {
  String headerText;
  Color headerColor;
  Color borderColor;
  Color textColor;
  Color dividerColor;
  Widget rightAction;
  Function onIconClick;
  AppHeader({
    required this.headerText,
    required this.headerColor,
    required this.borderColor,
    required this.textColor,
    required this.dividerColor,
    required this.rightAction,
    required this.onIconClick,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 120,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: headerColor,
            border: Border(
              bottom: BorderSide(
                color: borderColor,
                width: 4,
              ),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(210, 210, 210, 1.0),
                offset: Offset(0.0, 2.0),
                blurRadius: 3.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
        ),
        Positioned(
          left: 30,
          bottom: 15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                headerText,
                style: TextStyle(
                  fontSize: 30,
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  //overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                height: 3,
                width: 50,
                color: dividerColor,
              ),
            ],
          ),
        ),
        Positioned(
          right: 30,
          bottom: 15,
          child: GestureDetector(
              onTap: () {
                onIconClick();
              },
              child: rightAction),
        ),
      ],
    );
  }
}
