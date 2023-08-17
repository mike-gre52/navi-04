import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/models/list.dart';
import 'package:whats_for_dinner/models/recipe.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/app/app_yes_no_popup.dart';

import '../../../routes/routes.dart';

class RecipesPopup extends StatelessWidget {
  Recipe recipe;
  bool inFolder;
  String category;

  RecipesPopup({
    Key? key,
    required this.recipe,
    required this.inFolder,
    required this.category,
  }) : super(key: key);

  _showDialog(BuildContext context) {
    void _confirmActionFunction() {
      Navigator.pop(context);
      Navigator.pop(context);
      recipeController.deleteRecipe(recipe);
    }

    showDialog(
      context: context,
      builder: (_) => AppYesNoPopup(
        header: "Are you sure you want to delete this Recipe?",
        subHeader: "All data will be lost",
        confirmAction: "Yes",
        cancelAction: "Cancel",
        confirmActionFunction: _confirmActionFunction,
      ),
      barrierDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;
    double height5 = screenHeight / 179.2;
    double height7 = screenHeight / 128;
    double height10 = screenHeight / 89.6;
    double height15 = screenHeight / 59.733;
    double height20 = screenHeight / 44.8;
    double height30 = screenHeight / 29.86;
    double height32 = screenHeight / 28;
    double height50 = screenHeight / 17.92;
    double height100 = screenHeight / 8.96;
    double height125 = screenHeight / 7.168;
    double height150 = screenHeight / 5.973;
    double height160 = screenHeight / 5.6;
    double height200 = screenHeight / 4.48;
    double height600 = screenHeight / 1.493;
    double width5 = screenWidth / 82.8;
    double width15 = screenWidth / 27.6;
    double width30 = screenWidth / 13.8;
    double width100 = screenWidth / 4.14;
    double fontSize16 = screenHeight / 56;
    double fontSize18 = screenHeight / 49.777;
    double fontSize20 = screenHeight / 44.8;
    return Container(
      height: height125,
      child: Column(
        children: [
          Container(
            margin:
                EdgeInsets.symmetric(horizontal: width100, vertical: height5),
            height: height5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(height5),
              color: grey,
            ),
          ),
          inFolder
              ? PopupButton(
                  icon: CupertinoIcons.folder_badge_plus,
                  buttonName: 'Remove from Folder',
                  isRed: false,
                  onClick: () {
                    print("trying to remove");
                    Navigator.pop(context);
                    recipeController.removeRecipeCategoryFromRecipe(
                      recipe,
                      category,
                    );
                  },
                )
              : PopupButton(
                  icon: CupertinoIcons.folder_badge_plus,
                  buttonName: 'Add to Folder',
                  isRed: false,
                  onClick: () {
                    Navigator.pop(context);
                    Get.toNamed(
                      RouteHelper.getSelectCategoriesScreen(),
                      arguments: recipe,
                    );
                  },
                ),
          PopupButton(
            icon: CupertinoIcons.delete,
            buttonName: 'Delete Recipe',
            isRed: true,
            onClick: () {
              _showDialog(context);
            },
          ),
        ],
      ),
    );
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
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;
    double height7 = screenHeight / 128;
    double width15 = screenWidth / 27.6;
    double width30 = screenWidth / 13.8;
    double fontSize20 = screenHeight / 44.8;
    return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Container(
        margin: EdgeInsets.only(left: width30, top: height7),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: width15),
            Text(
              buttonName,
              style: TextStyle(
                fontSize: fontSize20,
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
