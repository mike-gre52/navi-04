import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:whats_for_dinner/models/list.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';

import '../../../routes/routes.dart';

class RecentlyDeletedBottomPopup extends StatelessWidget {
  ListData list;
  RecentlyDeletedBottomPopup({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height; //896
    double screenWidth = mediaQuery.size.width; //414
    double height2 = screenHeight / 448;
    double height5 = screenHeight / 179.2;
    double height10 = screenHeight / 89.6;
    double height30 = screenHeight / 29.86;
    double height40 = screenHeight / 22.4;
    double height100 = screenHeight / 8.96;
    double height125 = screenHeight / 7.168;
    double fontSize20 = screenHeight / 44.8;
    double fontSize16 = screenHeight / 56;
    double fontSize28 = screenHeight / 32;
    double width10 = screenWidth / 41.4;
    double width100 = screenWidth / 4.14;
    double width275 = screenWidth / 1.533;
    double width200 = screenWidth / 2.07;
    return StreamBuilder<List<Item>>(
        stream: listController.getRecentlyDeletedListItems(list.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final listItems = snapshot.data!;
            return Container(
              height: height125,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: width100,
                      vertical: height5,
                    ),
                    height: height5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(height5),
                      color: grey,
                    ),
                  ),
                  PopupButton(
                    icon: Icons.clear_all_rounded,
                    buttonName: 'Clear',
                    onClick: () {
                      listController.clearRecentlyDeleted(list.id!, listItems);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        });
  }
}

class PopupButton extends StatelessWidget {
  IconData icon;
  String buttonName;
  bool isRed;
  Function onClick;
  PopupButton(
      {Key? key,
      required this.icon,
      required this.buttonName,
      required this.onClick,
      this.isRed = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height; //896
    double screenWidth = mediaQuery.size.width; //414
    double height10 = screenHeight / 89.6;
    double width15 = screenWidth / 27.6;
    double width30 = screenWidth / 13.8;
    double fontSize20 = screenHeight / 44.8;
    return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Container(
        margin: EdgeInsets.only(left: width30, top: height10),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: width15),
            Text(
              buttonName,
              style: TextStyle(
                fontSize: fontSize20,
                fontWeight: FontWeight.w700,
                color: isRed ? red : black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
