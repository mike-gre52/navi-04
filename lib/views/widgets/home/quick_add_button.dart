import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whats_for_dinner/utils/colors.dart';

class QuickAddButton extends StatelessWidget {
  String buttonText;
  Color buttonColor;
  QuickAddButton({
    required this.buttonText,
    required this.buttonColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 115,
      decoration: BoxDecoration(
        border: Border.all(
          color: buttonColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          buttonText,
          style: TextStyle(
              color: black, fontSize: 16, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
