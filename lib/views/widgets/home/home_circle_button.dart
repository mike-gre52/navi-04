import 'package:flutter/material.dart';
import 'package:whats_for_dinner/utils/colors.dart';

class HomeCircleButton extends StatelessWidget {
  Color buttonColor;
  IconData icon;
  String buttonText;
  HomeCircleButton({
    required this.buttonColor,
    required this.icon,
    required this.buttonText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double height5 = screenHeight / 179.2;
    double height40 = screenHeight / 22.4;
    double height75 = screenHeight / 11.946;
    double fontSize14 = screenHeight / 64;
    return Column(
      children: [
        Container(
          height: height75,
          width: height75,
          decoration: BoxDecoration(
            color: buttonColor,
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(180, 180, 180, 1.0),
                offset: Offset(0.0, 1.0),
                blurRadius: 3.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
          child: Center(
            child: Icon(
              icon,
              size: height40,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: height5,
        ),
        Text(
          buttonText,
          style: TextStyle(
            fontSize: fontSize14,
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }
}
