import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/home/header.dart';
import 'package:whats_for_dinner/views/widgets/home/home_circle_button.dart';
import 'package:whats_for_dinner/views/widgets/home/my_group.dart';
import 'package:whats_for_dinner/views/widgets/home/quick_add.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 120,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: royalYellow,
                  border: const Border(
                    bottom: BorderSide(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(210, 210, 210, 1.0),
                      offset: Offset(0.0, 2.0),
                      blurRadius: 3.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, bottom: 10, right: 10),
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: black,
                          width: 3,
                        ),
                      ),
                      child: const Center(
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                              'https://firebasestorage.googleapis.com/v0/b/navi-04.appspot.com/o/profilePics%2F5WEEDYuD55faG39HPDaz1AA0Dw32?alt=media&token=5470d433-d88f-45c9-8e7b-f2441bc7239f'),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Welcome,',
                          style: TextStyle(
                            height: .5,
                            fontSize: 20,
                            color: Color.fromRGBO(213, 213, 213, 1.0),
                          ),
                        ),
                        Text(
                          'Michael',
                          style: TextStyle(
                              fontSize: 30,
                              color: black,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
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
          const SizedBox(
            height: 60,
          ),
          MyGroup(),
          const SizedBox(
            height: 60,
          ),
          QuickAdd(),
        ],
      ),
    );
  }
}
