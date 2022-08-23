import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
    double height30 = screenHeight / 29.86;
    double height40 = screenHeight / 22.4;
    double height200 = screenHeight / 4.48;
    double height250 = screenHeight / 3.584;
    double fontSize35 = screenHeight / 25.6;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height200,
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
              textfieldWidth: 350,
              textfieldHeight: 65,
              borderRadius: 10,
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
              textfieldWidth: 350,
              textfieldHeight: 65,
              borderRadius: 10,
            ),
            SizedBox(
              height: height30,
            ),
            GestureDetector(
              onTap: () {
                authController.loginUser(
                  _emailController.text,
                  _passwordController.text,
                );
              },
              child: GradientButton(
                buttonText: 'Login',
                firstColor: lightYellow,
                secondColor: royalYellow,
              ),
            ),
            SizedBox(
              height: height250,
            ),
            BottomText(
              firstText: 'Don\'t have an account? ',
              secondText: 'Sign Up',
              buttonRoute: RouteHelper.getSignUpRoute(),
            ),
          ],
        ),
      ),
    );
  }
}
