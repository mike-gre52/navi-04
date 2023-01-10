import 'package:flutter/material.dart';
import 'package:whats_for_dinner/models/recipe.dart';

class RecipeIngredientList extends StatelessWidget {
  List<Ingredient> ingredients;
  RecipeIngredientList({
    Key? key,
    required this.ingredients,
  }) : super(key: key);

  int counter = 0;
  Widget buildRecipeIngredient(Ingredient ingredient) {
    counter++;
    return RecipeIngredient(
      amount: ingredient.amount,
      stepNumber: counter,
      ingredient: ingredient.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    counter = 0;
    return SingleChildScrollView(
      //physics: NeverScrollableScrollPhysics(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          //physics: const NeverScrollableScrollPhysics(),
          //padding: const EdgeInsets.only(top: 0),
          children: ingredients.map(buildRecipeIngredient).toList(),
        ),
      ),
    );
  }
}

class RecipeIngredient extends StatelessWidget {
  double amount;
  int stepNumber;
  String ingredient;
  RecipeIngredient({
    Key? key,
    required this.amount,
    required this.stepNumber,
    required this.ingredient,
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
          Text(
            '$amount ',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          Flexible(
            child: Text(
              ingredient,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
              maxLines: null,
            ),
          ),
        ],
      ),
    );
  }
}
