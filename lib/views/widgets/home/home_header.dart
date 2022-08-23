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
                height: 60,
                width: 60,
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
                          radius: 60,
                          backgroundImage: NetworkImage(profileImage),
                        ),
                      )
                    : Center(
                        child: Text(
                          headerText.substring(0, 1),
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              color: black),
                        ),
                      ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome,',
                    style: TextStyle(
                      height: .5,
                      fontSize: 20,
                      color: Color.fromRGBO(213, 213, 213, 1.0),
                    ),
                  ),
                  Text(
                    headerText,
                    style: TextStyle(
                        fontSize: 30,
                        color: black,
                        fontWeight: FontWeight.w600),
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
