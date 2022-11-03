import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';

import '../../../models/list.dart';

class ListItem extends StatelessWidget {
  String listId;
  bool showCheckBox;
  Item item;
  ListData list;
  bool recentlyDeleted;

  ListItem({
    required this.listId,
    required this.showCheckBox,
    required this.item,
    required this.list,
    required this.recentlyDeleted,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height; //896
    double screenWidth = mediaQuery.size.width; //414
    double height10 = screenHeight / 89.6;
    double height15 = screenHeight / 59.73;
    double height30 = screenHeight / 29.86;
    double height40 = screenHeight / 22.4;
    double height200 = screenHeight / 4.48;
    double height250 = screenHeight / 3.584;

    double fontSize35 = screenHeight / 25.6;
    double fontSize20 = screenHeight / 44.8;
    double fontSize16 = screenHeight / 56;

    double width10 = screenWidth / 41.4;
    double width275 = screenWidth / 1.533;
    double width200 = screenWidth / 2.07;
    return Column(
      children: [
        GestureDetector(
          onTap: (() {
            if (showCheckBox) {
              Get.toNamed(RouteHelper.editListItem, arguments: [item, listId]);
            } else {
              Get.toNamed(RouteHelper.singleList, arguments: list);
            }
          }),
          child: Container(
            color: Colors.transparent,
            margin: showCheckBox
                ? EdgeInsets.only(top: height10, bottom: height10)
                : const EdgeInsets.only(top: 0),
            //height: showCheckBox ? 60 : 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    showCheckBox
                        ? GestureDetector(
                            onTap: () {
                              listController.toggleListItemCheckedStatus(
                                  item.id, listId, item.isChecked);
                            },
                            child: item.isChecked
                                ? Container(
                                    height: height40,
                                    width: height40,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(height10),
                                      color: appGreen,
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.check_rounded,
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                    ),
                                  )
                                : recentlyDeleted
                                    ? Container()
                                    : Container(
                                        height: height40,
                                        width: height40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(height10),
                                          border: Border.all(
                                            color: appGreen,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                          )
                        : Container(
                            height: height10,
                            width: height10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: appGreen,
                            ),
                          ),
                    SizedBox(width: width10),
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: showCheckBox ? width275 : width200,
                      ),
                      child: Text(
                        item.name,
                        style: TextStyle(
                          fontSize: showCheckBox ? fontSize20 : fontSize16,
                          fontWeight: FontWeight.w400,
                          color: item.isChecked ? Colors.black38 : black,
                        ),
                        maxLines: showCheckBox ? null : 1,
                        overflow: showCheckBox ? null : TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                showCheckBox
                    ? GestureDetector(
                        onTap: () {
                          recentlyDeleted
                              ? listController.restoreListItem(item, listId)
                              : listController.deleteListItem(
                                  item, listId, true, true);
                        },
                        child: Icon(
                          recentlyDeleted
                              ? CupertinoIcons.arrowshape_turn_up_left_circle
                              : Icons.close_rounded,
                          size: 28,
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        ),
        showCheckBox
            ? Container(
                height: 1,
                width: double.infinity,
                color: recentlyDeleted ? grey : appGreen,
              )
            : Container()
      ],
    );
  }
}
