import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/models/recipe.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';

class EditIngredientCell extends StatelessWidget {
  int counterValue;
  Ingredient ingredient;
  Function deleteIngredient;
  Function editIngredient;
  Function addIngredient;
  EditIngredientCell({
    Key? key,
    required this.ingredient,
    required this.counterValue,
    required this.deleteIngredient,
    required this.editIngredient,
    required this.addIngredient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;
    double height5 = screenHeight / 179.2;
    double height24 = screenHeight / 37.33333;
    double width10 = screenWidth / 41.4;
    double width315 = screenWidth / 1.31428571;
    double fontSize18 = screenHeight / 49.777;

    return Container(
      padding: EdgeInsets.only(bottom: height5),
      margin: EdgeInsets.only(top: height5),
      width: double.maxFinite,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: appBlue,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: width315,
            child: Text(
              ingredient.name,
              style:
                  TextStyle(fontWeight: FontWeight.w500, fontSize: fontSize18),
            ),
          ),
          Expanded(child: Container()),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.editRecipeItemScreen, arguments: [
                    'Ingredient',
                    ingredient,
                    counterValue,
                    editIngredient,
                    addIngredient,
                    false
                  ]);
                },
                child: Icon(
                  Icons.edit,
                  size: height24,
                ),
              ),
              SizedBox(width: width10),
              GestureDetector(
                onTap: () {
                  deleteIngredient(counterValue - 1);
                },
                child: Icon(
                  CupertinoIcons.delete,
                  size: height24,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
