import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/main.dart';
import 'package:whats_for_dinner/models/group.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/models/user.dart';
import 'package:whats_for_dinner/views/widgets/app/border_button.dart';
import 'package:whats_for_dinner/views/widgets/app/custom_textfield.dart';
import 'package:whats_for_dinner/views/widgets/profile/group_member.dart';
import 'package:whats_for_dinner/views/widgets/app/header.dart';
import 'package:whats_for_dinner/views/widgets/profile/circle_check_button.dart';

class JoinGroup extends StatefulWidget {
  bool inGroup = false;
  String username;
  String userColor;
  Function onJoinedGroup;
  JoinGroup({
    Key? key,
    required this.inGroup,
    required this.username,
    required this.userColor,
    required this.onJoinedGroup,
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

  bool isLoading = false;
  void toggleIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<bool> joinGroup(User user) async {
    final newMember = Member(
      name: user.name,
      id: firebaseAuth.currentUser!.uid,
      color: user.color,
    );
    bool didJoin = await groupController.addGroupMember(
      _groupIdController.text,
      newMember,
    );
    return didJoin;
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;

    double height5 = screenHeight / 179.2;
    double height10 = screenHeight / 89.6;
    double height15 = screenHeight / 59.733;
    double height25 = screenHeight / 35.84;
    double height30 = screenHeight / 29.86;
    double height40 = screenHeight / 22.4;
    double height50 = screenHeight / 17.92;
    double height65 = screenHeight / 13.784;
    double height100 = screenHeight / 8.96;
    double height200 = screenHeight / 4.48;
    double height250 = screenHeight / 3.584;
    double fontSize35 = screenHeight / 25.6;
    double height205 = screenHeight / 4.3707;
    double width10 = screenWidth / 41.4;
    double width30 = screenWidth / 13.8;
    double width80 = screenWidth / 5.175;
    double width200 = screenWidth / 2.07;
    double width350 = screenWidth / 1.182;
    double fontSize14 = screenHeight / 64;
    double fontSize16 = screenHeight / 56;
    double fontSize18 = screenHeight / 49.777;
    double fontSize20 = screenHeight / 44.8;
    double fontSize22 = screenHeight / 40.727;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height10,
          ),
          Text(
            'Join Group',
            style: TextStyle(
              color: black,
              fontSize: fontSize35,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'Enter a group code if you have one. If not, you can create a group below',
            style: TextStyle(
              color: darkGrey,
              fontSize: fontSize16,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: height10,
          ),
          isLoading
              ? Align(
                  alignment: Alignment.center,
                  child: CupertinoActivityIndicator(
                    color: royalYellow,
                    radius: height15,
                  ),
                )
              : Container(
                  height: height30,
                ),
          SizedBox(
            height: height10,
          ),
          CustomTextfield(
            icon: Icons.group_add_outlined,
            placeholderText: 'Enter Group Code Here',
            controller: _groupIdController,
            borderColor: royalYellow,
            textfieldWidth: width350,
            textfieldHeight: height65,
            borderRadius: height10,
            onSubmit: (_) {},
            onChanged: (_) {},
          ),
          SizedBox(
            height: height10,
          ),
          GestureDetector(
            onTap: () async {
              if (_groupIdController.text.trim() != "") {
                toggleIsLoading();
                User user = await userController.getUserDataSnapshot();
                bool didJoin = await joinGroup(user);
                if (true) {}
                toggleIsLoading();
                //toggleIsLoading();
                if (didJoin) {
                  widget.onJoinedGroup();
                }
              }
            },
            child: Container(
              height: height40,
              width: width80,
              decoration: BoxDecoration(
                color: royalYellow,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Join",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSize18,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          SizedBox(
            height: height30,
          ),
          Row(
            children: [
              Text(
                'Want to start a group?',
                style: TextStyle(
                  fontSize: fontSize22,
                  fontWeight: FontWeight.w300,
                  color: black,
                ),
              ),
              SizedBox(
                width: height10,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.createGroup,
                      arguments: [widget.onJoinedGroup]);
                },
                child: Text(
                  'Tap Here',
                  style: TextStyle(
                    fontSize: fontSize22,
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
    
    /*
    Container(
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
                  if (_groupIdController.text.trim() != "") {
                    bool didJoinGroup = await groupController.addGroupMember(
                      _groupIdController.text,
                      newMember,
                    );
                    if (didJoinGroup) {
                      widget.onJoinedGroup();
                    }
                  }
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
                  Get.toNamed(
                    RouteHelper.createGroup,
                    arguments: [widget.onJoinedGroup],
                  );
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
*/