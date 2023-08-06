import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class EmptyAddButton extends StatelessWidget {
  final Color color;
  final String name;
  final double width;
  const EmptyAddButton({
    super.key,
    required this.color,
    required this.name,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;

    double height5 = screenHeight / 179.2;
    double height15 = screenHeight / 59.73;
    double height50 = screenHeight / 17.92;

    double fontSize18 = screenHeight / 49.77;
    return Container(
      height: height50,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height15),
        color: color,
      ),
      child: Center(
        child: Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize18,
          ),
        ),
      ),
    );
  }
}
