import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/models/list.dart';
import 'package:whats_for_dinner/models/recipe.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/screens/recipes/recipe.dart';
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
    return ListIngredientCell(
      ingredient: ingredient.name,
      addIngredientToList: addIngredient,
      removeIngredientFromList: removeIngredient,
      color: color,
    );
  }

  late Recipe recipe;
  late ListData list;
  late Color color;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recipe = arguments[0] as Recipe;
    list = arguments[1] as ListData;
    color = arguments[2] as Color;
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double seventyPercentHeight = screenHeight * .70;
    double height10 = screenHeight / 89.6;
    double height125 = screenHeight / 7.168;
    double width20 = screenWidth / 20.7;
    double fontSize20 = screenHeight / 44.8;
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: AppHeader(
              headerText: 'Select Ingredients',
              headerColor: color,
              borderColor: royalYellow,
              textColor: Colors.white,
              dividerColor: Colors.white,
              rightAction: Text(
                'Back',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onIconClick: () {
                Navigator.pop(context);
              },
            ),
          ),
          Container(
            height: seventyPercentHeight,
            margin: EdgeInsets.only(left: width20),
            child: SingleChildScrollView(
              child: Column(
                children:
                    recipe.ingredients.map(buildRecipeIngredient).toList(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: width20, top: height10),
            height: height125,
            child: Row(
              children: [
                Column(
                  children: [
                    Text(
                      '${ingredientsToAdd.length} Items selected',
                      style: TextStyle(color: color, fontSize: 16),
                      maxLines: 2,
                    ),
                    GestureDetector(
                      onTap: () {
                        ingredientsToAdd.forEach((ingrediant) {
                          listController.addListItem(ingrediant, list.id);
                        });

                        Navigator.pop(context);
                      },
                      child: GradientButton(
                        buttonText: 'Add',
                        firstColor: color,
                        secondColor: color,
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
