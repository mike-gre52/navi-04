import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';

class CreateOrJoinBanner extends StatelessWidget {
  final Function onCreateGroup;
  final Color color;
  final String item;
  const CreateOrJoinBanner({
    Key? key,
    required this.onCreateGroup,
    required this.color,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;
    double screenWidth75 = screenWidth * .75;
    double height5 = screenHeight / 179.2;
    double height10 = screenHeight / 89.6;
    double height15 = screenHeight / 59.733;
    double height250 = screenHeight / 3.584;
    double height100 = screenHeight / 8.96;
    double width225 = screenWidth / 1.925;
    double fontSize20 = screenHeight / 44.8;

    return Container(
      height: height250,
      width: width225,
      child: Column(
        children: [
          Icon(
            Icons.groups_rounded,
            size: height100,
            color: color,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              "Create or join a group to add your first $item",
              style: TextStyle(
                  fontSize: fontSize20,
                  height: 1.2,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: height15),
          GestureDetector(
            onTap: () {
              Get.toNamed(
                RouteHelper.getJoinGroup(),
                arguments: onCreateGroup,
              );
            },
            child: Container(
              padding: EdgeInsets.all(height10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(height10),
                color: royalYellow,
              ),
              child: Text(
                "Join Group",
                style: TextStyle(
                  fontSize: fontSize20,
                  height: 1.2,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
