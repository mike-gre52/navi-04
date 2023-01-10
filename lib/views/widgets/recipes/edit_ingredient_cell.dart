import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/models/recipe.dart';
import 'package:whats_for_dinner/routes/routes.dart';

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
    return Container(
      child: Row(
        children: [
          Text(counterValue.toString()),
          Text(ingredient.name),
          Expanded(child: Container()),
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
            child: Icon(Icons.edit),
          ),
          GestureDetector(
            onTap: () {
              deleteIngredient(counterValue - 1);
            },
            child: Icon(Icons.delete),
          )
        ],
      ),
    );
  }
}
