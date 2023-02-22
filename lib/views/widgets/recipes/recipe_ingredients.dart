import 'package:flutter/material.dart';
import 'package:whats_for_dinner/models/recipe.dart';
import 'package:whats_for_dinner/utils/colors.dart';

class RecipeIngredientList extends StatelessWidget {
  List<Ingredient> ingredients;
  bool showDelete;
  Function deleteIngredient;
  RecipeIngredientList({
    Key? key,
    required this.ingredients,
    required this.showDelete,
    required this.deleteIngredient,
  }) : super(key: key);

  int counter = 0;
  Widget buildRecipeIngredient(Ingredient ingredient) {
    counter++;
    return RecipeIngredient(
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

class RecipeIngredient extends StatelessWidget {
  int stepNumber;
  String ingredient;
  bool showDelete;
  Function deleteIngredient;
  RecipeIngredient({
    Key? key,
    required this.stepNumber,
    required this.ingredient,
    required this.showDelete,
    required this.deleteIngredient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$stepNumber)  ',
            style: TextStyle(fontSize: 24),
          ),
          Expanded(
            child: Text(
              ingredient,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
              maxLines: null,
            ),
          ),
          showDelete
              ? GestureDetector(
                  onTap: () {
                    deleteIngredient(stepNumber - 1);
                  },
                  child: const Icon(
                    Icons.close,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
