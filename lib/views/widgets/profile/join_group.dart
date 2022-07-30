import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/border_button.dart';
import 'package:whats_for_dinner/views/widgets/custom_textfield.dart';
import 'package:whats_for_dinner/views/widgets/home/group_member.dart';
import 'package:whats_for_dinner/views/widgets/header.dart';
import 'package:whats_for_dinner/views/widgets/profile/circle_check_button.dart';

class JoinGroup extends StatefulWidget {
  bool inGroup = false;
  JoinGroup({Key? key, required this.inGroup}) : super(key: key);

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
                Header(
                  headerText: 'My Group',
                  dividerColor: royalYellow,
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.manageGroup);
                    },
                    child: BorderButton(
                      buttonColor: royalYellow,
                      buttonText: 'Manage Group',
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
                        groupController.addGroupMember(_groupIdController.text);
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
