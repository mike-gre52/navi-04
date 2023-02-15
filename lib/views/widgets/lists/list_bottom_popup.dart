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

class ListBottomPopup extends StatelessWidget {
  ListData list;
  ListBottomPopup({
    Key? key,
    required this.list,
  }) : super(key: key);

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('Are you sure you want to delete this list?'),
        content: const Text('All data will be lost'),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            child: const Text('Yes'),
            onPressed: () {
              /*
              StreamBuilder<List<Item>>(
                  stream: listController.getListItems(list.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      listItems = snapshot.data!;
                      listController.clearRecentlyDeleted(list.id, listItems);
                      return Container();
                    } else {
                      return Container();
                    }
                  });
                  */
              Navigator.pop(context);
              listController.deleteList(
                  list.id, listItems, recentlyDeletedItems);
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  List<Item> listItems = [];
  List<Item> recentlyDeletedItems = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Item>>(
        stream: listController.getListItems(list.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            listItems = snapshot.data!;
            return StreamBuilder<List<Item>>(
                stream: listController.getRecentlyDeletedListItems(list.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    recentlyDeletedItems = snapshot.data!;
                    return Container(
                      height: 250,
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
                            icon: CupertinoIcons.clear_circled,
                            buttonName: 'Clear Selected',
                            onClick: () {
                              listController.deleteSelectedItems(
                                  list.id, listItems);
                              Navigator.pop(context);
                            },
                          ),
                          PopupButton(
                            icon: Icons.clear_all_rounded,
                            buttonName: 'Clear All',
                            onClick: () {
                              listController.deleteAllListItems(
                                  list.id, listItems, true);
                              Navigator.pop(context);
                            },
                          ),
                          PopupButton(
                            icon: CupertinoIcons.arrowshape_turn_up_left,
                            buttonName: 'Recently Deleted',
                            onClick: () {
                              Get.toNamed(RouteHelper.recentlyDeleted,
                                  arguments: list);
                            },
                          ),
                          PopupButton(
                            icon: CupertinoIcons.plus_rectangle,
                            buttonName: 'Add Recipe Items',
                            onClick: () {
                              Navigator.pop(context);
                              Get.toNamed(
                                  RouteHelper.addToListSelectRecipeScreen,
                                  arguments: [list, appGreen]);
                            },
                          ),
                          PopupButton(
                            icon: CupertinoIcons.delete,
                            buttonName: 'Delete List',
                            isRed: true,
                            onClick: () {
                              _showDialog(context);
                              //Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                });
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
