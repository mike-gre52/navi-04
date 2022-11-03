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
    return StreamBuilder<List<Item>>(
        stream: listController.getRecentlyDeletedListItems(list.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final listItems = snapshot.data!;
            return Container(
              height: 125,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 5),
                    height: 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: grey,
                    ),
                  ),
                  PopupButton(
                    icon: Icons.clear_all_rounded,
                    buttonName: 'Clear',
                    onClick: () {
                      listController.clearRecentlyDeleted(list.id, listItems);
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
    return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Container(
        margin: EdgeInsets.only(left: 30, top: 7),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: 15),
            Text(
              buttonName,
              style: TextStyle(
                fontSize: 20,
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
