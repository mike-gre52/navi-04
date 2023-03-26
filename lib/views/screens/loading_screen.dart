import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whats_for_dinner/utils/colors.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height20 = screenHeight / 44.8;
    double width75percent = mediaQuery.size.width * .75;
    return Scaffold(
      body: Center(
          child: Image(
        width: width75percent,
        image: const AssetImage(
          'assets/images/loading_screen.png',
        ),
      )),
    );
  }
}
 /*
         CupertinoActivityIndicator(
          color: royalYellow,
          radius: height20,
        ),
        */