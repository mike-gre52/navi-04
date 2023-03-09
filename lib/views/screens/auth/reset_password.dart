import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/controllers/auth_controller.dart';
import 'package:whats_for_dinner/controllers/user_controller.dart';
import 'package:whats_for_dinner/main.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/views/screens/auth/sign_up.dart';
import 'package:whats_for_dinner/views/widgets/auth/add_profile_image.dart';
import 'package:whats_for_dinner/views/widgets/auth/bottom_text.dart';
import 'package:whats_for_dinner/views/widgets/app/custom_textfield.dart';
import 'package:whats_for_dinner/views/widgets/app/gradient_button.dart';

import '../../../routes/routes.dart';
import '../../../utils/constants.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController _emailController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
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
                  'Reset Password',
                  style: TextStyle(
                    color: black,
                    fontSize: fontSize35,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Enter the email associated with the account and we will send you an email.',
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
                  icon: Icons.mail_outline_rounded,
                  placeholderText: 'Email',
                  controller: _emailController,
                  borderColor: royalYellow,
                  textfieldWidth: height350,
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
                    if (_emailController.text.trim() != "") {
                      setState(() {
                        isLoading = true;
                      });
                      bool emailSent = await authController
                          .sendPasswordResetEmail(_emailController.text);
                      setState(() {
                        isLoading = false;
                      });
                      if (emailSent) {
                        Navigator.pop(context);
                        Get.toNamed(RouteHelper.getConfirmResetPasswordSent(),
                            arguments: _emailController.text);
                      }
                    }

                    //get data from firebase
                  },
                  child: GradientButton(
                    buttonText: 'Reset',
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
