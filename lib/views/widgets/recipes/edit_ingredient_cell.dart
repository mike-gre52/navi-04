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
    return Container(
      padding: const EdgeInsets.only(bottom: 5),
      margin: const EdgeInsets.only(top: 5),
      width: double.maxFinite,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: appBlue),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 330,
            child: Text(
              ingredient.name,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
          ),
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
          SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              deleteIngredient(counterValue - 1);
            },
            child: Icon(CupertinoIcons.delete),
          )
        ],
      ),
    );
  }
}
