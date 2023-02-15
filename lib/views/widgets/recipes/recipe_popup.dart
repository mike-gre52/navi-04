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
    return Container(
      height: 160,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 5),
            height: 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
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
    return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Container(
        margin: EdgeInsets.only(left: 30, top: 7),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 15),
            Text(
              buttonName,
              style: TextStyle(
                fontSize: 20,
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
