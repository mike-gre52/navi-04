import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/controllers/auth_controller.dart';
import 'package:whats_for_dinner/controllers/user_controller.dart';
import 'package:whats_for_dinner/main.dart';
import 'package:whats_for_dinner/models/group.dart';
import 'package:whats_for_dinner/models/user.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/views/screens/auth/sign_up.dart';
import 'package:whats_for_dinner/views/widgets/auth/add_profile_image.dart';
import 'package:whats_for_dinner/views/widgets/auth/bottom_text.dart';
import 'package:whats_for_dinner/views/widgets/app/custom_textfield.dart';
import 'package:whats_for_dinner/views/widgets/app/gradient_button.dart';

import '../../../routes/routes.dart';
import '../../../utils/constants.dart';

class JoinGroupScreen extends StatefulWidget {
  const JoinGroupScreen({Key? key}) : super(key: key);

  @override
  State<JoinGroupScreen> createState() => _JoinGroupScreenState();
}

class _JoinGroupScreenState extends State<JoinGroupScreen> {
  TextEditingController _groupIdController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _groupIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height5 = screenHeight / 179.2;
    double height10 = screenHeight / 89.6;
    double height30 = screenHeight / 29.86;
    double height40 = screenHeight / 22.4;
    double height65 = screenHeight / 13.784;
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

    joinGroup(User user) async {
      final newMember = Member(
        name: user.name,
        id: firebaseAuth.currentUser!.uid,
        color: user.color,
      );
      await groupController.addGroupMember(
        _groupIdController.text,
        newMember,
      );
    }

    Function onCreateGroup = Get.arguments as Function;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: width30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height200,
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
                  height: height30,
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
                    User user = await userController.getUserDataSnapshot();
                    await joinGroup(user);
                    if (true) {}
                    Navigator.pop(context);
                    onCreateGroup();
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
                        Get.toNamed(RouteHelper.createGroup);
                      },
                      child: Text(
                        'Click Here',
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
          ),
        ],
      ),
    );
  }
}
