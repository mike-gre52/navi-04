import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/models/list.dart';
import 'package:whats_for_dinner/models/recipe.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/app/app_header.dart';
import 'package:whats_for_dinner/views/widgets/app/gradient_button.dart';
import 'package:whats_for_dinner/views/widgets/lists/list_ingredient_cell.dart';

class SelectIngredients extends StatefulWidget {
  SelectIngredients({Key? key}) : super(key: key);

  @override
  State<SelectIngredients> createState() => _SelectIngredientsState();
}

class _SelectIngredientsState extends State<SelectIngredients> {
  final arguments = Get.arguments as List;

  List<String> ingredientsToAdd = [];

  void addIngredient(String ingredient) {
    setState(() {
      ingredientsToAdd += [ingredient];
    });
  }

  void removeIngredient(String ingredient) {
    setState(() {
      ingredientsToAdd.remove(ingredient);
    });
  }

  Widget buildRecipeIngredient(Ingredient ingredient) {
    String recipeName = '${ingredient.amount} ${ingredient.name}';
    return ListIngredientCell(
      ingredient: recipeName,
      addIngredientToList: addIngredient,
      removeIngredientFromList: removeIngredient,
    );
  }

  @override
  Widget build(BuildContext context) {
    final recipe = arguments[0] as Recipe;
    final list = arguments[1] as ListData;
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: AppHeader(
              headerText: 'Select Ingredients',
              headerColor: appGreen,
              borderColor: royalYellow,
              textColor: Colors.white,
              dividerColor: Colors.white,
              rightAction: const Text(
                'Back',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onIconClick: () {
                Navigator.pop(context);
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children:
                    recipe.ingredients.map(buildRecipeIngredient).toList(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, top: 10),
            height: 125,
            child: Row(
              children: [
                Column(
                  children: [
                    Text(
                      '${ingredientsToAdd.length} Items selected',
                      style: TextStyle(color: appGreen, fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        ingredientsToAdd.forEach((ingrediant) {
                          listController.addListItem(ingrediant, list.id);
                        });
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: GradientButton(
                        buttonText: 'Add',
                        firstColor: Color.fromRGBO(125, 227, 111, 1.0),
                        secondColor: appGreen,
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
