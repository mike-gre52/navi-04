import 'package:flutter/material.dart';
import 'package:whats_for_dinner/utils/colors.dart';

import '../../../controllers/auth_controller.dart';

class AddProfileImage extends StatelessWidget {
  AddProfileImage({Key? key}) : super(key: key);
  AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height30 = screenHeight / 29.86;
    double height40 = screenHeight / 22.4;
    double height65 = screenHeight / 13.78;
    double height100 = screenHeight / 8.96;
    double height150 = screenHeight / 5.973;
    double width165 = screenWidth / 2.509;
    double fontSize22 = screenHeight / 40.727;

    return Stack(
      children: [
        Center(
          child: Container(
            margin: EdgeInsets.only(
              top: height100,
            ),
            height: height150,
            width: height150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: royalYellow,
                width: 3,
              ),
            ),
            child: Center(
              child: Icon(
                Icons.person_outline,
                size: height100,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        Positioned(
          top: 95,
          right: 110,
          child: GestureDetector(
            onTap: () {
              _authController.pickImage();
            },
            child: Container(
              height: height40,
              width: height40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: royalYellow,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 2.0),
                    blurRadius: 3.0,
                    spreadRadius: 1.0,
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
