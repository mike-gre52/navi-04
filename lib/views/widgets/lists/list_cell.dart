import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whats_for_dinner/models/list.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/lists/list_item.dart';

class ListCell extends StatefulWidget {
  String name;
  int itemCount;
  String listId;
  ListCell({
    Key? key,
    required this.name,
    required this.itemCount,
    required this.listId,
  }) : super(key: key);

  @override
  State<ListCell> createState() => _ListCellState();
}

class _ListCellState extends State<ListCell> {
  Widget buildListItem(Item item) => ListItem(
        listId: widget.listId,
        showCheckBox: false,
        item: item,
      );

  bool isOpened = false;
  bool showList = false;
  @override
  Widget build(BuildContext context) {
    int animationDuration = 200;
    return StreamBuilder<List<Item>>(
        stream: listController.getListItems(widget.listId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final listItems = snapshot.data!;
            return AnimatedContainer(
              margin: const EdgeInsets.only(top: 10),
              duration: Duration(milliseconds: animationDuration),
              curve: Curves.easeIn,
              height: isOpened ? (widget.itemCount * 25) + 100 : 100,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
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
                    margin: const EdgeInsets.only(left: 30, top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: black,
                              height: 1),
                        ),
                        Container(width: 50, height: 3, color: appGreen),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              showList
                                  ? Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 5),
                                        width: 250,
                                        child: ListView(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            padding:
                                                const EdgeInsets.only(top: 0),
                                            children: listItems.reversed
                                                .map(buildListItem)
                                                .toList()),
                                      ),
                                    )
                                  : Container(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${widget.itemCount} items',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: black),
                                      ),
                                      GestureDetector(
                                        onTap: (() {
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
                                        }),
                                        child: Icon(
                                          isOpened
                                              ? Icons.arrow_drop_up_rounded
                                              : Icons.arrow_drop_down_rounded,
                                          size: 50,
                                          color: appGreen,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                      right: 15,
                    ),
                    child: Icon(
                      Icons.edit,
                      size: 30,
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
