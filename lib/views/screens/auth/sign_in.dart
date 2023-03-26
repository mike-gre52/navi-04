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

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height5 = screenHeight / 179.2;
    double height10 = screenHeight / 89.6;
    double height40 = screenHeight / 22.4;
    double height65 = screenHeight / 13.784;
    double height200 = screenHeight / 4.48;
    double height205 = screenHeight / 4.3707;
    double height250 = screenHeight / 3.584;
    double width30 = screenWidth / 13.8;
    double fontSize35 = screenHeight / 25.6;
    double height30 = screenHeight / 29.86;
    double height100 = screenHeight / 8.96;
    double width60percent = mediaQuery.size.width * .60;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: width30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height100,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image(
                    width: width60percent,
                    image: const AssetImage(
                      'assets/images/loading_screen.png',
                    ),
                  ),
                ),
                SizedBox(
                  height: height30,
                ),
                Text(
                  'Login',
                  style: TextStyle(
                    color: black,
                    fontSize: fontSize35,
                    fontWeight: FontWeight.w500,
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
                  textfieldWidth: double.maxFinite,
                  textfieldHeight: height65,
                  borderRadius: height10,
                  onSubmit: (_) {},
                  onChanged: (_) {},
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
                  height: height10,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getResetPassword());
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height5,
                ),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                    });

                    await authController.loginUser(
                      _emailController.text,
                      _passwordController.text,
                    );

                    setState(() {
                      isLoading = false;
                    });
                    //get data from firebase
                  },
                  child: GradientButton(
                    buttonText: 'Login',
                    firstColor: lightYellow,
                    secondColor: royalYellow,
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  margin: EdgeInsets.only(bottom: height40),
                  child: BottomText(
                    firstText: 'Don\'t have an account? ',
                    secondText: 'Sign Up',
                    buttonRoute: RouteHelper.getSignUpRoute(),
                  ),
                ),
              ],
            ),
          ),
          isLoading
              ? Container(
                  margin: EdgeInsets.only(top: height205),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: CupertinoActivityIndicator(
                      color: royalYellow,
                      radius: 20,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
