import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/models/recipe.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/utils/helper.dart';
import 'package:whats_for_dinner/views/widgets/app/app_header.dart';
import 'package:whats_for_dinner/views/widgets/recipes/edit_ingredient_cell.dart';
import 'package:whats_for_dinner/views/widgets/recipes/edit_instruction_cell.dart';
import 'package:whats_for_dinner/views/widgets/recipes/recipe_instructions.dart';

import '../../widgets/recipes/recipe_ingredients.dart';

class EditRecipe extends StatefulWidget {
  EditRecipe({Key? key}) : super(key: key);

  @override
  State<EditRecipe> createState() => _EditRecipeState();
}

class _EditRecipeState extends State<EditRecipe> {
  final data = Get.arguments as List<dynamic>;
  late String dataType;
  late Recipe recipe;
  late Function updateUI;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataType = data[0] as String;
    recipe = data[1] as Recipe;
    updateUI = data[2] as Function;
  }

  var ingredientCounter = 0;
  Widget buildRecipeIngredient(Ingredient ingredient) {
    ingredientCounter++;
    print(ingredientCounter);
    return EditIngredientCell(
      ingredient: ingredient,
      counterValue: ingredientCounter,
      deleteIngredient: deleteIngredient,
      editIngredient: editIngredient,
      addIngredient: addIngredient,
    );
  }

  var instructionCounter = 0;
  Widget buildRecipeInstruction(Instruction instruction) {
    instructionCounter++;
    return EditInstructionCell(
      instruction: instruction,
      counterValue: instructionCounter,
      deleteInstruction: deleteInstruction,
      editInstruction: editInstruction,
      addInstruction: addInstruction,
    );
  }

  void deleteIngredient(int index) {
    setState(() {
      recipe.ingredients.removeAt(index);
      ingredientCounter = 0;
    });
  }

  void editIngredient(Ingredient ingredient, int index) {
    setState(() {
      recipe.ingredients.replaceRange(index, index + 1, [ingredient]);
      ingredientCounter = 0;
    });
  }

  void addIngredient(Ingredient ingredient) {
    setState(() {
      recipe.ingredients.add(ingredient);
      ingredientCounter = 0;
    });
  }

  void deleteInstruction(int index) {
    setState(() {
      recipe.instructions.removeAt(index);
      instructionCounter = 0;
    });
  }

  void editInstruction(Instruction instruction, int index) {
    setState(() {
      recipe.instructions.replaceRange(index, index + 1, [instruction]);
      ingredientCounter = 0;
    });
  }

  void addInstruction(Instruction instruction) {
    setState(() {
      recipe.instructions.add(instruction);
      instructionCounter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppHeader(
            headerText: dataType == 'Ingredients'
                ? 'Edit Ingredients'
                : 'Edit Instructions',
            headerColor: appBlue,
            borderColor: royalYellow,
            textColor: Colors.white,
            dividerColor: Colors.white,
            rightAction: const Text(
              'Done',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            onIconClick: () {
              Navigator.pop(context);
              if (dataType == 'Ingredients') {
                setState(() {
                  recipeController.updateIngredients(recipe);
                });
                updateUI();
              } else {
                setState(() {
                  recipeController.updateInstructions(recipe);
                });
                updateUI();
              }
            },
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 5),
              child: ListView(
                padding: const EdgeInsets.all(0),
                children: dataType == 'Ingredients'
                    ? recipe.ingredients.map(buildRecipeIngredient).toList()
                    : recipe.instructions.map(buildRecipeInstruction).toList(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          if (dataType == 'Ingredients') {
            Ingredient ingredient = Ingredient(
              name: '',
              id: generateId(),
            );
            Get.toNamed(RouteHelper.editRecipeItemScreen, arguments: [
              'Ingredient',
              ingredient,
              recipe.instructions.length + 1,
              editIngredient,
              addIngredient,
              true
            ]);
          } else {
            Instruction instruction = Instruction(
              instruction: '',
              id: generateId(),
              orderNumber: recipe.instructions.length + 1,
            );
            Get.toNamed(RouteHelper.editRecipeItemScreen, arguments: [
              'Instruction',
              instruction,
              recipe.instructions.length + 1,
              editInstruction,
              addInstruction,
              true
            ]);
          }
        },
        child: const Icon(
          Icons.add_rounded,
          size: 32,
        ),
      ),
    );
  }
}
