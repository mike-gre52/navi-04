import 'package:flutter/material.dart';
import 'package:whats_for_dinner/utils/colors.dart';

import '../../../controllers/auth_controller.dart';

class AddProfileImage extends StatelessWidget {
  AddProfileImage({Key? key}) : super(key: key);
  AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            margin: const EdgeInsets.only(
              top: 100,
            ),
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: royalYellow,
                width: 3,
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.person_outline,
                size: 100,
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
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: royalYellow,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 2.0),
                    blurRadius: 3.0,
                    spreadRadius: 1.0,
                  ), //Bo
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
