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
    return Column(
      children: [
        Container(
          height: 75,
          width: 75,
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
              size: 40,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          buttonText,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }
}
