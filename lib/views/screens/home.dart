import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whats_for_dinner/main.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/app/header.dart';
import 'package:whats_for_dinner/views/widgets/home/home_circle_button.dart';
import 'package:whats_for_dinner/views/widgets/home/my_group.dart';
import 'package:whats_for_dinner/views/widgets/home/quick_add.dart';

import '../../models/user.dart';
import '../widgets/home/home_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double height50 = screenHeight / 17.92;
    double height60 = screenHeight / 14.933;
    return Scaffold(
      body: StreamBuilder<User>(
        stream: userController.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                HomeHeader(
                  headerText:
                      snapshot.data!.name.substring(0, 1).toUpperCase() +
                          snapshot.data!.name.substring(1),
                  headerColor: royalYellow,
                  borderColor: Colors.white,
                  profileImage: snapshot.data!.profileImage,
                ),
                SizedBox(height: height50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HomeCircleButton(
                      buttonColor: appRed,
                      icon: Icons.food_bank_rounded,
                      buttonText: 'Resturant',
                    ),
                    HomeCircleButton(
                      buttonColor: appGreen,
                      icon: Icons.list_alt_outlined,
                      buttonText: 'Lists',
                    ),
                    HomeCircleButton(
                      buttonColor: appBlue,
                      icon: Icons.emoji_food_beverage_rounded,
                      buttonText: 'Recipes',
                    )
                  ],
                ),
                SizedBox(
                  height: height60,
                ),
                SizedBox(
                  height: height60,
                ),
                const QuickAdd(),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
