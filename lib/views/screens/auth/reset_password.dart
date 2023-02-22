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
    double height5 = screenHeight / 179.2;
    double height10 = screenHeight / 89.6;
    double height30 = screenHeight / 29.86;
    double height40 = screenHeight / 22.4;
    double height200 = screenHeight / 4.48;
    double height250 = screenHeight / 3.584;
    double fontSize35 = screenHeight / 25.6;
    double height205 = screenHeight / 4.3707;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 75,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 40,
                  ),
                ),
                isLoading
                    ? Container(
                        height: 50,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: CupertinoActivityIndicator(
                            color: royalYellow,
                            radius: 20,
                          ),
                        ),
                      )
                    : Container(
                        height: 50,
                      ),
                const SizedBox(
                  height: 45,
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
                    fontSize: 16,
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
                  textfieldWidth: 350,
                  textfieldHeight: 65,
                  borderRadius: 10,
                  onSubmit: (_) {},
                  onChanged: (_) {},
                ),
                SizedBox(
                  height: height40,
                ),
                GestureDetector(
                  onTap: () async {
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
