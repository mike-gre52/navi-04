import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/views/screens/auth/sign_in.dart';

class BottomText extends StatelessWidget {
  String firstText;
  String secondText;
  String buttonRoute;
  BottomText({
    Key? key,
    required this.firstText,
    required this.secondText,
    required this.buttonRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double fontSize20 = screenHeight / 44.8;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          firstText,
          style: TextStyle(
            fontSize: fontSize20,
            fontWeight: FontWeight.w400,
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(buttonRoute);
          },
          child: Text(
            secondText,
            style: TextStyle(
              fontSize: fontSize20,
              color: const Color.fromRGBO(204, 170, 64, 1.0),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
