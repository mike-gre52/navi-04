import 'package:flutter/material.dart';
import 'package:whats_for_dinner/views/widgets/profile/select_color.dart';

class SelectColorScreen extends StatelessWidget {
  const SelectColorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height80 = screenHeight / 11.2;
    double width30 = screenWidth / 13.8;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: height80, left: width30, right: width30),
        child: Column(
          children: const [
            SelectColor(),
          ],
        ),
      ),
    );
  }
}
