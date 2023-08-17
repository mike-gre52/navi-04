import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/controllers/auth_controller.dart';
import 'package:whats_for_dinner/controllers/user_controller.dart';
import 'package:whats_for_dinner/main.dart';
import 'package:whats_for_dinner/models/group.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/views/screens/auth/sign_up.dart';
import 'package:whats_for_dinner/views/widgets/auth/add_profile_image.dart';
import 'package:whats_for_dinner/views/widgets/auth/bottom_text.dart';
import 'package:whats_for_dinner/views/widgets/app/custom_textfield.dart';
import 'package:whats_for_dinner/views/widgets/app/gradient_button.dart';

import '../../../routes/routes.dart';
import '../../../utils/constants.dart';

class Reauth extends StatefulWidget {
  const Reauth({Key? key}) : super(key: key);

  @override
  State<Reauth> createState() => _ReauthState();
}

class _ReauthState extends State<Reauth> {
  TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height10 = screenHeight / 89.6;
    double height20 = screenHeight / 44.4;
    double height40 = screenHeight / 22.4;
    double height50 = screenHeight / 17.92;
    double height65 = screenHeight / 13.784;
    double height75 = screenHeight / 11.946;
    double height250 = screenHeight / 3.584;
    double height350 = screenHeight / 2.56;
    double width30 = screenWidth / 13.8;
    double fontSize16 = screenHeight / 56;
    double fontSize35 = screenHeight / 25.6;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: width30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height75,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_rounded,
                    size: height40,
                  ),
                ),
                isLoading
                    ? Container(
                        height: height50,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: CupertinoActivityIndicator(
                            color: royalYellow,
                            radius: height20,
                          ),
                        ),
                      )
                    : Container(
                        height: height50,
                      ),
                SizedBox(
                  height: height50,
                ),
                Text(
                  'Delete Account',
                  style: TextStyle(
                    color: black,
                    fontSize: fontSize35,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'To continue you must enter your password associated with this account',
                  style: TextStyle(
                    color: darkGrey,
                    fontSize: fontSize16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: height40,
                ),
                CustomTextfield(
                  icon: Icons.lock_outline,
                  placeholderText: 'Password',
                  controller: _passwordController,
                  borderColor: royalYellow,
                  showVisibilityIcon: true,
                  textfieldWidth: double.maxFinite,
                  textfieldHeight: height65,
                  borderRadius: height10,
                  onSubmit: (_) {},
                  onChanged: (_) {},
                ),
                SizedBox(
                  height: height40,
                ),
                GestureDetector(
                  onTap: () async {
                    //get data from firebase
                    setState(() {
                      isLoading = true;
                    });
                    bool userValidated = await authController
                        .validateCredentials(_passwordController.text);
                    if (userValidated) {
                      if (inGroup) {
                        Group group =
                            await groupController.getGroupCall(globalGroupId);
                        await groupController.leaveGroup(group);
                      }

                      authController.updateLocalDataOnSignOut();
                      String userId = authController.user.uid;
                      await userController.deleteUserDocument(userId);
                      await authController
                          .deleteUserAccount(_passwordController.text);
                      await authController.onReady();
                    } else {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  child: GradientButton(
                    buttonText: 'Delete',
                    firstColor: lightYellow,
                    secondColor: royalYellow,
                  ),
                ),
                SizedBox(
                  height: height250,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
