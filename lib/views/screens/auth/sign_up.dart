import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/controllers/auth_controller.dart';
import 'package:whats_for_dinner/main.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/screens/auth/sign_in.dart';
import 'package:whats_for_dinner/views/widgets/auth/add_profile_image.dart';
import 'package:whats_for_dinner/views/widgets/auth/bottom_text.dart';
import 'package:whats_for_dinner/views/widgets/app/custom_textfield.dart';
import 'package:whats_for_dinner/views/widgets/app/gradient_button.dart';

import '../../../routes/routes.dart';

late Rx<File?> pickedImageSignUp;

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void handleSignUp() {
    authController.registerUser(
      _usernameController.text,
      _emailController.text,
      _passwordController.text,
      //authController.profileImage,
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height10 = screenHeight / 89.6;
    double height20 = screenHeight / 44.8;
    double height30 = screenHeight / 29.86;
    double height40 = screenHeight / 22.4;
    double height65 = screenHeight / 13.784;
    double height100 = screenHeight / 8.96;
    double height200 = screenHeight / 4.48;
    double height205 = screenHeight / 4.3707;
    double width30 = screenWidth / 13.8;
    double fontSize35 = screenHeight / 25.6;
    double width35percent = mediaQuery.size.width * .35;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: width30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //AddProfileImage(),
                SizedBox(
                  height: height100,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image(
                    width: width35percent,
                    image: const AssetImage(
                      'assets/images/transparent_logo.png',
                    ),
                  ),
                ),
                isLoading
                    ? Container(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: CupertinoActivityIndicator(
                            color: royalYellow,
                            radius: height20,
                          ),
                        ),
                      )
                    : Container(
                        height: height40,
                      ),
                Text(
                  'Sign Up',
                  style: TextStyle(
                    color: black,
                    fontSize: fontSize35,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: height30,
                ),
                CustomTextfield(
                  icon: Icons.person_outline_rounded,
                  placeholderText: 'Username',
                  controller: _usernameController,
                  borderColor: royalYellow,
                  textfieldWidth: double.maxFinite,
                  textfieldHeight: height65,
                  borderRadius: height10,
                  onSubmit: (_) {},
                  onChanged: (_) {},
                ),
                SizedBox(
                  height: height20,
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
                  keyboard: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: height20,
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
                  height: height30,
                ),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                    });

                    await authController.registerUser(
                      _usernameController.text,
                      _emailController.text,
                      _passwordController.text,
                      //pickedImageSignUp.value,
                    );

                    setState(() {
                      isLoading = false;
                    });
                    //get data from firebase or set global data
                  },
                  child: GradientButton(
                    buttonText: 'Sign Up',
                    firstColor: lightYellow,
                    secondColor: royalYellow,
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  margin: EdgeInsets.only(bottom: height40),
                  child: BottomText(
                    firstText: 'Already have an account ',
                    secondText: 'Login',
                    buttonRoute: RouteHelper.getSignInRoute(),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
