import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/models/list.dart';
import 'package:whats_for_dinner/models/recipe.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';

import '../../../routes/routes.dart';

class RecipesPopup extends StatelessWidget {
  Recipe recipe;
  RecipesPopup({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('Are you sure you want to delete this Recipe?'),
        content: const Text('All data will be lost'),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            child: const Text('Yes'),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              recipeController.deleteRecipe(recipe);
            },
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
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
            icon: CupertinoIcons.delete,
            buttonName: 'Delete Recipe',
            isRed: true,
            onClick: () {
              _showDialog(context);
              //Navigator.pop(context);
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
