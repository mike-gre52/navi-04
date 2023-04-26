import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/main.dart';
import 'package:whats_for_dinner/models/group.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/app/border_button.dart';
import 'package:whats_for_dinner/views/widgets/app/custom_textfield.dart';
import 'package:whats_for_dinner/views/widgets/profile/group_member.dart';
import 'package:whats_for_dinner/views/widgets/app/header.dart';
import 'package:whats_for_dinner/views/widgets/profile/circle_check_button.dart';

class JoinGroup extends StatefulWidget {
  bool inGroup = false;
  String username;
  String userColor;
  Function onSubmit;
  JoinGroup({
    Key? key,
    required this.inGroup,
    required this.username,
    required this.userColor,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<JoinGroup> createState() => _JoinGroupState();
}

class _JoinGroupState extends State<JoinGroup> {
  TextEditingController _groupIdController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _groupIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height10 = screenHeight / 89.6;
    double height15 = screenHeight / 59.733;
    double height60 = screenHeight / 14.933;
    double width10 = screenWidth / 41.4;
    double width275 = screenWidth / 1.505;
    double fontSize22 = screenHeight / 40.727;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Join or create a group',
            style: TextStyle(
              fontSize: fontSize22,
              fontWeight: FontWeight.w300,
              color: black,
            ),
          ),
          SizedBox(
            height: height15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextfield(
                icon: Icons.group_add_outlined,
                placeholderText: 'Enter group code here',
                controller: _groupIdController,
                borderColor: royalYellow,
                textfieldWidth: width275,
                textfieldHeight: height60,
                borderRadius: height10,
                onSubmit: (_) {},
                onChanged: (_) {},
              ),
              GestureDetector(
                onTap: () async {
                  final newMember = Member(
                    name: widget.username,
                    id: firebaseAuth.currentUser!.uid,
                    color: widget.userColor,
                  );
                  await groupController.addGroupMember(
                    _groupIdController.text,
                    newMember,
                  );
                  widget.onSubmit();
                },
                child: CircleCheckButton(),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text(
                'Want to create a group?',
                style: TextStyle(
                  fontSize: fontSize22,
                  fontWeight: FontWeight.w300,
                  color: black,
                ),
              ),
              SizedBox(
                width: width10,
              ),
              GestureDetector(
                onTap: () {
                  print("create group");
                  Get.toNamed(RouteHelper.createGroup,
                      arguments: [widget.onSubmit]);
                },
                child: Text(
                  'Click Here',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: royalYellow,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
