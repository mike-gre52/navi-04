import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/models/list.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';

class AlternateListCell extends StatefulWidget {
  ListData list;
  AlternateListCell({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  State<AlternateListCell> createState() => _AlternateListCellState();
}

class _AlternateListCellState extends State<AlternateListCell> {
  addName(String listName) {
    listController.updateListName(widget.list, listName);
  }

  int getUncheckedListItemsCount(List<Item> listItems) {
    int numUncheckedItems = 0;
    for (int i = 0; i < listItems.length; i++) {
      if (listItems[i].isChecked != null && !listItems[i].isChecked!) {
        numUncheckedItems++;
      }
    }
    return numUncheckedItems;
  }

  bool isOpened = false;
  bool showList = false;
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;
    double height3 = screenHeight / 298.66667;
    double height5 = screenHeight / 179.2;
    double height10 = screenHeight / 89.6;
    double height15 = screenHeight / 59.733;
    double height25 = screenHeight / 35.84;
    double height30 = screenHeight / 29.86;
    double height50 = screenHeight / 17.92;
    double height100 = screenHeight / 8.96;
    double width5 = screenWidth / 82.8;
    double width15 = screenWidth / 27.6;
    double width30 = screenWidth / 13.8;
    double width250 = screenWidth / 1.656;
    double fontSize16 = screenHeight / 56;
    double fontSize24 = screenHeight / 37.333;
    return Container(
      margin: EdgeInsets.symmetric(vertical: height10),
      height: height100,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(height30),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(210, 210, 210, 1.0),
            offset: Offset(0.0, 2.0),
            blurRadius: 2.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: width30, top: height15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: width250),
                      child: Text(
                        widget.list.name != null
                            ? widget.list.name!
                            : "add name",
                        style: TextStyle(
                            fontSize: fontSize24,
                            fontWeight: FontWeight.w600,
                            color: black,
                            height: 1.2,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    widget.list.name == null
                        ? GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                  RouteHelper
                                      .getSingleTextfieldAndSubmitScreen(),
                                  arguments: [
                                    appGreen,
                                    "Add a name for the list: ",
                                    addName,
                                    CupertinoIcons.list_bullet
                                  ]);
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: width5),
                              child: const Icon(Icons.edit_note_rounded),
                            ),
                          )
                        : Container(),
                  ],
                ),
                Container(
                  width: height50,
                  height: height3,
                  color: appGreen,
                ),
                const SizedBox(height: 15),
                Text(
                  "${widget.list.itemCount} items",
                  style: TextStyle(
                    fontSize: fontSize16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: height10,
              right: width15,
            ),
            child: Icon(
              Icons.edit,
              size: height30,
              color: appGreen,
            ),
          ),
        ],
      ),
    );
  }
}
