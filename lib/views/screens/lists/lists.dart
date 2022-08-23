import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:whats_for_dinner/models/list.dart';
import 'package:whats_for_dinner/models/user.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/app/app_header.dart';
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
        child: ListCell(
          name: list.name,
          itemCount: list.itemCount,
          listId: list.id,
        ),
      );

  void goToAddListFile() {
    Get.toNamed(RouteHelper.getAddList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<ListData>>(
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
                  rightAction: const Icon(
                    Icons.add_rounded,
                    size: 40,
                    color: Colors.white,
                  ),
                  onIconClick: () {
                    goToAddListFile();
                  },
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    child: ListView(
                      padding: const EdgeInsets.all(0),
                      children: lists.map(buildListCell).toList(),
                    ),
                  ),
                )
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
