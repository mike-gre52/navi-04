import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';

class AppHeader extends StatelessWidget {
  String headerText;
  Color headerColor;
  Color borderColor;
  Color textColor;
  Color dividerColor;
  Widget rightAction;
  Function onIconClick;
  bool safeArea;
  bool smallHeader;
  AppHeader({
    required this.headerText,
    required this.headerColor,
    required this.borderColor,
    required this.textColor,
    required this.dividerColor,
    required this.rightAction,
    required this.onIconClick,
    this.safeArea = false,
    this.smallHeader = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;

    double height5 = screenHeight / 179.2;
    double height15 = screenHeight / 59.733;
    double height90 = screenHeight / 9.955;
    double width30 = screenWidth / 13.8;
    double width50 = screenWidth / 8.28;
    double width250 = screenWidth / 1.656;
    double height120 = screenHeight / 7.466;
    double fontSize26 = screenHeight / 34.4615;
    double fontSize30 = screenHeight / 29.866;

    return Stack(
      children: [
        Container(
          height: safeArea ? height90 : height120,
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
          left: width30,
          bottom: height15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: width250),
                child: Text(
                  headerText,
                  style: TextStyle(
                    fontSize: smallHeader ? fontSize26 : fontSize30,
                    color: textColor,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Container(
                height: height5,
                width: width50,
                color: dividerColor,
              ),
            ],
          ),
        ),
        Positioned(
          right: width30,
          bottom: height15,
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
