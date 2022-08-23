import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/models/group.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/app/border_button.dart';
import 'package:whats_for_dinner/views/widgets/app/custom_textfield.dart';
import 'package:whats_for_dinner/views/widgets/home/group_member.dart';
import 'package:whats_for_dinner/views/widgets/app/header.dart';
import 'package:whats_for_dinner/views/widgets/profile/circle_check_button.dart';

class JoinGroup extends StatefulWidget {
  bool inGroup = false;
  String username;
  String userColor;
  JoinGroup({
    Key? key,
    required this.inGroup,
    required this.username,
    required this.userColor,
  }) : super(key: key);

  @override
  State<JoinGroup> createState() => _JoinGroupState();
}

class _JoinGroupState extends State<JoinGroup> {
  TextEditingController _groupIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.inGroup
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    await groupController
                        .setGroupId()
                        .then((value) => Get.toNamed(RouteHelper.manageGroup));
                  },
                  child: Text(
                    'Manage Group',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: royalYellow,
                    ),
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Join a group!  ',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w300,
                    color: black,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextfield(
                      icon: Icons.group_add_outlined,
                      placeholderText: 'Group Id',
                      controller: _groupIdController,
                      borderColor: royalYellow,
                      textfieldWidth: 280,
                      textfieldHeight: 60,
                      borderRadius: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        final newMember = Member(
                          name: widget.username,
                          id: firebaseAuth.currentUser!.uid,
                          color: widget.userColor,
                        );
                        groupController.addGroupMember(
                          _groupIdController.text,
                          newMember,
                        );
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
                      'Want to start a group?',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w300,
                        color: black,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.createGroup);
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
