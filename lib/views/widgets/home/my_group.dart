import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/views/widgets/home/group_member.dart';
import 'package:whats_for_dinner/views/widgets/header.dart';

class MyGroup extends StatefulWidget {
  const MyGroup({Key? key}) : super(key: key);

  @override
  State<MyGroup> createState() => _MyGroupState();
}

class _MyGroupState extends State<MyGroup> {
  var inGroup = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
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
                        fontSize: 14,
                        color: royalYellow,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ],
          ),
          Container(
            height: 100,
            width: double.maxFinite,
            child: inGroup
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not in a Group?  ',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                          color: black,
                        ),
                      ),
                      Text(
                        'Click Here',
                        style: TextStyle(
                          fontSize: 25,
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
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GroupMember(
                          circleText: 'A',
                          color: '0xff478b3a',
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GroupMember(
                          circleText: '+3',
                          color: '4286625219',
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
