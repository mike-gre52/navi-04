import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/models/recipe.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';

class CreateRecipeIngredientList extends StatelessWidget {
  List<Ingredient> ingredients;
  bool showDelete;
  Function deleteIngredient;
  CreateRecipeIngredientList({
    Key? key,
    required this.ingredients,
    required this.showDelete,
    required this.deleteIngredient,
  }) : super(key: key);

  int counter = 0;
  Widget buildRecipeIngredient(Ingredient ingredient) {
    counter++;
    return CreateRecipeIngredient(
      stepNumber: counter,
      ingredient: ingredient.name,
      showDelete: showDelete,
      deleteIngredient: deleteIngredient,
    );
  }

  @override
  Widget build(BuildContext context) {
    counter = 0;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: ingredients.map(buildRecipeIngredient).toList(),
      ),
    );
  }
}

class CreateRecipeIngredient extends StatelessWidget {
  int stepNumber;
  String ingredient;
  bool showDelete;
  Function deleteIngredient;
  CreateRecipeIngredient({
    Key? key,
    required this.stepNumber,
    required this.ingredient,
    required this.showDelete,
    required this.deleteIngredient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;

    double height5 = screenHeight / 179.2;
    double height25 = screenHeight / 35.84;
    double icon16 = screenHeight / 56;
    double width5 = screenWidth / 82.8;
    double fontSize20 = screenHeight / 44.8;

    return Container(
      margin: EdgeInsets.only(top: height5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: width5),
          Text(
            '$stepNumber)  ',
            style: TextStyle(
                fontSize: fontSize20, fontWeight: FontWeight.w500, height: 1.2),
          ),
          Expanded(
            child: Text(
              ingredient,
              style: TextStyle(
                fontSize: fontSize20,
                fontWeight: FontWeight.w500,
                height: 1.2,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          GestureDetector(
            onTap: () {
              deleteIngredient(stepNumber - 1);
            },
            child: Icon(
              Icons.close_rounded,
              size: height25,
            ),
          )
        ],
      ),
    );
  }
}
