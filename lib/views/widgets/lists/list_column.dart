import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:whats_for_dinner/models/list.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/app/banner_add.dart';
import 'package:whats_for_dinner/views/widgets/lists/list_item.dart';

class ListColumn extends StatelessWidget {
  ListData list;
  bool isRecentlyDeleted;

  ListColumn({
    Key? key,
    required this.list,
    required this.isRecentlyDeleted,
  }) : super(key: key);

  int adSpacer = 5;
  int adCount = 0;
  Item adItem = Item(name: "ad", id: "", isChecked: true, imageUrl: "");
  bool showAd = false;

  Widget buildListItem(Item item) {
    //Cell
    adCount++;
    if (adCount == adSpacer && !isRecentlyDeleted) {
      adCount = 0;
      return Column(
        children: [
          BannerAdWidget(),
          ListItem(
            listId: list.id!,
            showCheckBox: true,
            item: item,
            list: list,
            recentlyDeleted: isRecentlyDeleted,
          )
        ],
      );
    }
    {
      //Cell
      return ListItem(
        listId: list.id!,
        showCheckBox: true,
        item: item,
        list: list,
        recentlyDeleted: isRecentlyDeleted,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;
    double height5 = screenHeight / 179.2;
    double height50 = screenHeight / 17.92;
    double width30 = screenWidth / 13.8;
    adCount = 0;
    return StreamBuilder<List<Item>>(
        stream: isRecentlyDeleted
            ? listController.getRecentlyDeletedListItems(list.id)
            : listController.getListItems(list.id),
        builder: (context, snapshot) {
          adCount = 0;
          if (snapshot.hasData) {
            final listItems = snapshot.data!;
            if (listItems.length < 6) {
              if (listItems.length == 1) {
                adSpacer = 1;
              } else if (listItems.length == 2) {
                adSpacer = 2;
              } else {
                adSpacer = 3;
              }
            } else {
              adSpacer = 5;
            }
            return Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.only(
                    top: height5,
                    left: width30,
                    right: width30,
                  ),
                  width: double.infinity,
                  child: ListView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: const EdgeInsets.only(top: 0),
                      children: listItems.reversed.map(buildListItem).toList()),
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
