import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:whats_for_dinner/main.dart';
import 'package:whats_for_dinner/models/list.dart';
import 'package:whats_for_dinner/models/user.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/app/app_header.dart';
import 'package:whats_for_dinner/views/widgets/app/create_or_join_banner.dart';
import 'package:whats_for_dinner/views/widgets/app/empty_add_button.dart';
import 'package:whats_for_dinner/views/widgets/lists/alternate_list_cell.dart';
import 'package:whats_for_dinner/views/widgets/lists/list_cell.dart';

class ListsScreen extends StatefulWidget {
  const ListsScreen({Key? key}) : super(key: key);

  @override
  State<ListsScreen> createState() => _ListsScreenState();
}

class _ListsScreenState extends State<ListsScreen> {
  Widget buildListCell(ListData list) => GestureDetector(
        onTap: (() {
          Get.toNamed(RouteHelper.singleList, arguments: list);
        }),
        child: AlternateListCell(
          list: list,
        ),
      );

  void goToAddListFile() {
    Get.toNamed(RouteHelper.getAddList());
  }

  updateUI() {
    setState(() {});
  }

  void test(List<ListData> lists) {
    for (ListData list in lists) {
      print(list.itemCount);
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height15 = screenHeight / 59.733;
    double height40 = screenHeight / 22.4;
    double height100 = screenHeight / 8.96;

    double fontSize18 = screenHeight / 49.7778;

    double width30 = screenWidth / 13.8;
    double width100 = screenWidth / 4.14;
    return Scaffold(
      body: inGroup
          ? StreamBuilder<List<ListData>>(
              stream: listController.getListData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final lists = snapshot.data!;
                  return Column(
                    children: [
                      AppHeader(
                        headerText: 'Lists',
                        headerColor: appGreen,
                        borderColor: royalYellow,
                        textColor: Colors.white,
                        dividerColor: Colors.white,
                        rightAction: Icon(
                          Icons.add_rounded,
                          size: height40,
                          color: Colors.white,
                        ),
                        onIconClick: () {
                          goToAddListFile();
                        },
                      ),
                      lists.isNotEmpty
                          ? Expanded(
                              child: Container(
                                margin:
                                    EdgeInsets.symmetric(horizontal: width30),
                                child: ListView(
                                  padding: const EdgeInsets.all(0),
                                  children: lists.map(buildListCell).toList(),
                                ),
                              ),
                            )
                          : Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "You have not added any Lists",
                                    style: TextStyle(
                                      fontSize: fontSize18,
                                      fontWeight: FontWeight.w400,
                                      color: appGreen,
                                    ),
                                  ),
                                  SizedBox(height: height15),
                                  GestureDetector(
                                    onTap: () {
                                      goToAddListFile();
                                    },
                                    child: EmptyAddButton(
                                      color: appGreen,
                                      name: "Add List",
                                      width: width100,
                                    ),
                                  )
                                ],
                              ),
                            ),
                    ],
                  );
                } else {
                  return Container(
                    child: Center(
                      child: CupertinoActivityIndicator(
                        radius: height15,
                        color: appGreen,
                        animating: true,
                      ),
                    ),
                  );
                }
              },
            )
          : Column(
              children: [
                AppHeader(
                  headerText: 'Lists',
                  headerColor: appGreen,
                  borderColor: royalYellow,
                  textColor: Colors.white,
                  dividerColor: Colors.white,
                  rightAction: Container(),
                  onIconClick: () {},
                ),
                Expanded(
                  child: Center(
                    child: CreateOrJoinBanner(
                      onCreateGroup: updateUI,
                      color: appGreen,
                      item: "list",
                      onClickHere: updateUI,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
