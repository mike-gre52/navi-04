import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/models/list.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/lists/list_item.dart';

class ListCell extends StatefulWidget {
  ListData list;
  ListCell({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  State<ListCell> createState() => _ListCellState();
}

class _ListCellState extends State<ListCell> {
  addName(String listName) {
    listController.updateListName(widget.list, listName);
  }

  Widget buildListItem(Item item) => ListItem(
        listId: widget.list.id!,
        showCheckBox: false,
        item: item,
        list: widget.list,
        recentlyDeleted: false,
      );

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
    int animationDuration = 200;
    return StreamBuilder<List<Item>>(
        stream: listController.getListItems(widget.list.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final listItems = snapshot.data!;
            int itemCount = 0;
            if (widget.list.itemCount != null) {
              itemCount = widget.list.itemCount!;
            }
            return AnimatedContainer(
              margin: EdgeInsets.symmetric(vertical: height10),
              duration: Duration(milliseconds: animationDuration),
              curve: Curves.easeIn,
              height: isOpened ? (itemCount * height25) + height100 : height100,
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
                                        child: const Icon(
                                            Icons.edit_note_rounded)),
                                  )
                                : Container(),
                          ],
                        ),
                        Container(
                            width: height50, height: height3, color: appGreen),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              showList
                                  ? Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(top: height5),
                                        width: width250,
                                        child: ListView(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          padding:
                                              const EdgeInsets.only(top: 0),
                                          children: listItems.reversed
                                              .map(buildListItem)
                                              .toList(),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              widget.list.itemCount != null
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${widget.list.itemCount} items',
                                              style: TextStyle(
                                                fontSize: fontSize16,
                                                fontWeight: FontWeight.w400,
                                                color: black,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: (() {
                                                if (listItems.isNotEmpty) {
                                                  setState(() {
                                                    isOpened = !isOpened;
                                                    //showList = !showList;
                                                    if (showList) {
                                                      Future.delayed(
                                                          Duration(
                                                            milliseconds:
                                                                animationDuration,
                                                          ), () {
                                                        setState(() {
                                                          showList = !showList;
                                                        });
                                                      });
                                                    } else {
                                                      showList = !showList;
                                                    }
                                                  });
                                                }
                                              }),
                                              child: Icon(
                                                isOpened
                                                    ? Icons
                                                        .arrow_drop_up_rounded
                                                    : Icons
                                                        .arrow_drop_down_rounded,
                                                size: height50,
                                                color: appGreen,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  : Container(),
                            ],
                          ),
                        )
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
          } else {
            return Container();
          }
        });
  }
}
