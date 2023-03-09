import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/views/widgets/profile/group_member.dart';
import 'package:whats_for_dinner/views/widgets/app/header.dart';

class MyGroup extends StatefulWidget {
  const MyGroup({Key? key}) : super(key: key);

  @override
  State<MyGroup> createState() => _MyGroupState();
}

class _MyGroupState extends State<MyGroup> {
  var inGroup = false;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;
    double height100 = screenHeight / 8.96;
    double width10 = screenWidth / 41.4;
    double width30 = screenWidth / 13.8;
    double fontSize14 = screenHeight / 64;
    double fontSize24 = screenHeight / 37.333;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: width30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Header(
                headerText: 'My Group',
                dividerColor: royalYellow,
              ),
              inGroup
                  ? Container()
                  : Text(
                      'Manage Groups',
                      style: TextStyle(
                        fontSize: fontSize14,
                        color: royalYellow,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ],
          ),
          Container(
            height: height100,
            width: double.maxFinite,
            child: inGroup
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not in a Group?  ',
                        style: TextStyle(
                          fontSize: fontSize24,
                          fontWeight: FontWeight.w300,
                          color: black,
                        ),
                      ),
                      Text(
                        'Click Here',
                        style: TextStyle(
                          fontSize: fontSize24,
                          fontWeight: FontWeight.w800,
                          color: royalYellow,
                        ),
                      )
                    ],
                  )
                : Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      children: [
                        GroupMember(
                          circleText: 'M',
                          color: '0xff478b3a',
                          isExtra: false,
                        ),
                        SizedBox(
                          width: width10,
                        ),
                        GroupMember(
                          circleText: 'A',
                          color: '0xff478b3a',
                          isExtra: false,
                        ),
                        SizedBox(
                          width: width10,
                        ),
                        GroupMember(
                          circleText: '+3',
                          color: '4286625219',
                          isExtra: false,
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
