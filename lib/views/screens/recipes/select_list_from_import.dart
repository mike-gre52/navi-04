import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/models/list.dart';
import 'package:whats_for_dinner/models/recipe.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/utils/helper.dart';
import 'package:whats_for_dinner/views/widgets/app/app_header.dart';

class SelectListFromImportRecipe extends StatelessWidget {
  SelectListFromImportRecipe({Key? key}) : super(key: key);

  final ingredients = Get.arguments as List<String>;

  @override
  Widget build(BuildContext context) {
    Widget buildListCell(ListData list) => GestureDetector(
          onTap: () {
            for (String element in ingredients) {
              listController.addListItem(element, list.id);
            }
            Navigator.pop(context);
            showSnackBar("Success",
                "The Selected Ingredients have been added to ${list.name}");
          },
          child: SmallListCell(
            list: list,
          ),
        );

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
                  headerColor: appBlue,
                  borderColor: royalYellow,
                  textColor: Colors.white,
                  dividerColor: Colors.white,
                  rightAction: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onIconClick: () {
                    Navigator.pop(context);
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

class SmallListCell extends StatelessWidget {
  final ListData list;
  const SmallListCell({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(210, 210, 210, 1.0),
            offset: Offset(0.0, 2.0),
            blurRadius: 2.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Container(
                width: double.maxFinite,
                margin: const EdgeInsets.only(top: 5),
                child: Text(
                  list.name,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                      height: 1),
                ),
              ),
            ),
            Container(
              height: 50,
              width: 30,
              decoration: BoxDecoration(
                color: appGreen,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: const Icon(
                Icons.more_vert,
                size: 32,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
