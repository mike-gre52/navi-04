import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/models/list.dart';
import 'package:whats_for_dinner/models/recipe.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/app/app_header.dart';

class SelectList extends StatelessWidget {
  SelectList({Key? key}) : super(key: key);

  final recipe = Get.arguments as Recipe;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;
    double width30 = screenWidth / 13.8;
    double fontSize20 = screenHeight / 44.8;
    Widget buildListCell(ListData list) => GestureDetector(
          onTap: () {
            Navigator.pop(context);
            Get.toNamed(RouteHelper.selectIngredients,
                arguments: [recipe, list, appBlue]);
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
                  rightAction: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSize20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onIconClick: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: width30),
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
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;
    double height5 = screenHeight / 179.2;
    double height10 = screenHeight / 89.6;
    double height15 = screenHeight / 59.733;
    double height32 = screenHeight / 28;
    double height50 = screenHeight / 17.92;
    double width10 = screenWidth / 41.4;
    double width30 = screenWidth / 13.8;
    double fontSize18 = screenHeight / 49.777;

    return Container(
      margin: EdgeInsets.only(top: height10),
      height: height50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(height15),
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
        margin: EdgeInsets.only(left: width10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(top: height5),
                child: Text(
                  list.name,
                  style: TextStyle(
                    fontSize: fontSize18,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                    height: 1,
                  ),
                ),
              ),
            ),
            Container(
              height: height50,
              width: width30,
              decoration: BoxDecoration(
                color: appGreen,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(height15),
                  bottomRight: Radius.circular(height15),
                ),
              ),
              child: Icon(
                Icons.more_vert,
                size: height32,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
