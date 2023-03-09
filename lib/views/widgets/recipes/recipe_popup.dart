import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/models/list.dart';
import 'package:whats_for_dinner/models/recipe.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';

import '../../../routes/routes.dart';

class RecipePopup extends StatelessWidget {
  Recipe recipe;
  Function updateUI;
  RecipePopup({
    Key? key,
    required this.recipe,
    required this.updateUI,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;
    double height5 = screenHeight / 179.2;
    double height160 = screenHeight / 5.6;
    double width100 = screenWidth / 4.14;

    return Container(
      height: height160,
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
          PopupButton(
            icon: CupertinoIcons.plus_rectangle,
            buttonName: 'Add Ingredient to list',
            onClick: () {
              Navigator.pop(context);
              Get.toNamed(RouteHelper.getSelectList(), arguments: recipe);
            },
          ),
          PopupButton(
            icon: Icons.edit,
            buttonName: 'Edit Ingredients',
            onClick: () {
              Navigator.pop(context);
              Get.toNamed(RouteHelper.editRecipeScreen, arguments: [
                'Ingredients',
                recipe,
                updateUI,
              ]);

              //Edit Ingredients
              //Navigator.pop(context);
            },
          ),
          PopupButton(
            icon: Icons.edit,
            buttonName: 'Edit Instructions',
            onClick: () {
              Navigator.pop(context);
              Get.toNamed(RouteHelper.editRecipeScreen, arguments: [
                'Instructions',
                recipe,
                updateUI,
              ]);
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
