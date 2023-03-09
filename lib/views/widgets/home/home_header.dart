import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class HomeHeader extends StatelessWidget {
  String headerText;
  Color headerColor;
  Color borderColor;
  String profileImage;
  HomeHeader({
    required this.headerText,
    required this.headerColor,
    required this.borderColor,
    required this.profileImage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;
    double height60 = screenHeight / 14.933;
    double height120 = screenHeight / 7.466;
    double fontSize20 = screenHeight / 44.8;
    double fontSize24 = screenHeight / 37.333;
    double fontSize30 = screenHeight / 29.866;
    return Stack(
      children: [
        Container(
          height: height120,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: headerColor,
            border: Border(
              bottom: BorderSide(
                color: borderColor,
                width: 2,
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
          bottom: 0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, bottom: 10, right: 10),
                height: height60,
                width: height60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: black,
                    width: 3,
                  ),
                ),
                child: profileImage != ''
                    ? Center(
                        child: CircleAvatar(
                          backgroundColor: royalYellow,
                          radius: height60,
                          backgroundImage: NetworkImage(profileImage),
                        ),
                      )
                    : Center(
                        child: Text(
                          headerText.substring(0, 1),
                          style: TextStyle(
                            fontSize: fontSize24,
                            fontWeight: FontWeight.w500,
                            color: black,
                          ),
                        ),
                      ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome,',
                    style: TextStyle(
                      height: .5,
                      fontSize: fontSize20,
                      color: const Color.fromRGBO(213, 213, 213, 1.0),
                    ),
                  ),
                  Text(
                    headerText,
                    style: TextStyle(
                      fontSize: fontSize30,
                      color: black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
