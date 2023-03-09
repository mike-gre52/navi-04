import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/views/widgets/app/gradient_button.dart';

class ConfirmResetEmailSent extends StatelessWidget {
  ConfirmResetEmailSent({Key? key}) : super(key: key);

  String email = Get.arguments as String;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height20 = screenHeight / 44.4;
    double height200 = screenHeight / 4.48;
    double height250 = screenHeight / 3.584;
    double width30 = screenWidth / 13.8;
    double fontSize15 = screenHeight / 59.733;
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
                  height: height200,
                ),
                Text(
                  'Success',
                  style: TextStyle(
                    color: black,
                    fontSize: fontSize35,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'An email has been sent to $email. If you do not see it, check your junk mail.',
                  style: TextStyle(
                    color: darkGrey,
                    fontSize: fontSize15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: height20,
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.pop(context);
                  },
                  child: GradientButton(
                    buttonText: 'Sign In',
                    firstColor: lightYellow,
                    secondColor: royalYellow,
                    showArrow: false,
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
