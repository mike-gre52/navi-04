import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/controllers/recipes_controller.dart';
import 'package:whats_for_dinner/main.dart';
import 'package:whats_for_dinner/models/recipe.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/utils/helper.dart';
import 'package:whats_for_dinner/views/screens/recipes/recipe_navigator.dart';
import 'package:whats_for_dinner/views/widgets/app/app_header.dart';
import 'package:whats_for_dinner/views/widgets/app/create_or_join_banner.dart';
import 'package:whats_for_dinner/views/widgets/recipes/blue_folder.dart';
import 'package:whats_for_dinner/views/widgets/recipes/recipe_cell.dart';
import 'package:whats_for_dinner/views/widgets/recipes/recipe_link_cell.dart';

import '../../../routes/routes.dart';

class RecipeFoldersScreen extends StatefulWidget {
  Function setScreen;
  RecipeFoldersScreen({
    Key? key,
    required this.setScreen,
  }) : super(key: key);

  @override
  State<RecipeFoldersScreen> createState() => _RecipeFoldersScreenState();
}

class _RecipeFoldersScreenState extends State<RecipeFoldersScreen> {
  void updateCategories(category) {
    recipeController.deleteRecipeCategory(category);
    setState(() {
      categories.remove(category);
    });
  }

  _showDialog(BuildContext context, String category) {
    showDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              title:
                  Text('Are you sure you want to delete the $category folder'),
              content: const Text(''),
              actions: [
                CupertinoDialogAction(
                  child: const Text('Yes'),
                  onPressed: () {
                    updateCategories(category);
                    Navigator.pop(context);
                  },
                ),
                CupertinoDialogAction(
                  child: const Text('No'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }

  Widget buildRecipeCell(
    String category,
    double screenHeight,
    double screenWidth,
  ) {
    double height10 = screenHeight / 89.6;
    double height80 = screenHeight / 11.2;

    double width10 = screenWidth / 41.4;

    double fontSize18 = screenHeight / 49.777;
    return GestureDetector(
      onTap: () {
        widget.setScreen(recipePage.filteredRecipes, category);
        /*
        Get.toNamed(
          RouteHelper.getFilteredRecipeScreen(),
          arguments: category,
        );
        */
      },
      child: Container(
        margin: const EdgeInsets.only(top: 5, bottom: 5),
        height: height80,
        width: height80,
        decoration: BoxDecoration(
          color: lightGrey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                _showDialog(context, category);
              },
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: EdgeInsets.only(
                    right: height10,
                    top: height10,
                  ),
                  child: const Icon(Icons.close_rounded),
                ),
              ),
            ),
            const BlueFolder(),
            Container(
              margin: EdgeInsets.only(
                right: width10,
                left: width10,
                bottom: height10,
              ),
              child: Text(
                category,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: fontSize18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  updateUI() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;

    double height5 = screenHeight / 186.4;
    double height15 = screenHeight / 59.733;
    double height20 = screenHeight / 48.6;
    double height40 = screenHeight / 22.4;
    double height55 = screenHeight / 16.945;
    double height70 = screenHeight / 13.314;
    double height200 = screenHeight / 4.48;
    double height250 = screenHeight / 3.584;

    double width10 = screenWidth / 41.4;
    double width20 = screenWidth / 20.7;
    double width30 = screenWidth / 13.8;
    double width100 = screenWidth / 4.3;
    double width200 = screenWidth / 2.07;
    double fontSize28 = screenHeight / 33.285;
    double fontSize16 = screenHeight / 58.25;
    double fontSize18 = screenHeight / 51.777;
    double fontSize20 = screenHeight / 44.8;
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(
          left: width20,
          right: width20,
        ),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 1,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          padding: const EdgeInsets.all(0),
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            return buildRecipeCell(
                categories[index], screenHeight, screenWidth);
          },
        ),
      ),
    );
  }
}
