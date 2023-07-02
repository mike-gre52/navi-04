import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/models/recipe.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/utils/helper.dart';
import 'package:whats_for_dinner/utils/scrapper.dart';

class ConfirmImportRecipe extends StatefulWidget {
  const ConfirmImportRecipe({Key? key}) : super(key: key);

  @override
  State<ConfirmImportRecipe> createState() => _ConfirmImportRecipeState();
}

class _ConfirmImportRecipeState extends State<ConfirmImportRecipe> {
  final data = Get.arguments as List;
  dynamic jsonData;

  late String recipeName;
  late int cookTime;
  late int prepTime;
  late int totalTime;
  late String recipeYield;
  late List<Ingredient> recipeIngredients;
  late List<Instruction> recipeInstructions;
  late String sourceUrl;
  late String imageUrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jsonData = data[0];
    sourceUrl = data[1];

    int index = findData(jsonData);
    recipeName = getRecipeName(jsonData, index);
    imageUrl = getRecipeImage(jsonData, index);
    prepTime = getPrepTime(jsonData, index);
    cookTime = getCookTime(jsonData, index);
    totalTime = getTotalTime(jsonData, index);
    recipeYield = getRecipeYield(jsonData, index);
    recipeInstructions = getRecipeInstructions(jsonData, index);
    recipeIngredients = getRecipeIngredients(jsonData, index);

    Recipe recipe = Recipe(
      name: recipeName,
      prepTime: prepTime,
      cookTime: cookTime,
      totalTime: totalTime == -1 ? prepTime + cookTime : totalTime,
      servings: recipeYield,
      id: generateId(),
      imageUrl: imageUrl,
      ingredients: recipeIngredients,
      instructions: recipeInstructions,
      sourceUrl: sourceUrl,
      categories: [],
      isLink: false,
      isImport: true,
    );

    recipeController.uploadRecipe(recipe);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Center(
          child: Text('Import Recipe'),
        ),
      )),
    );
  }
}
