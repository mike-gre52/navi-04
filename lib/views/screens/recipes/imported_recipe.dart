import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/main.dart';
import 'package:whats_for_dinner/models/recipe.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/utils/helper.dart';
import 'package:whats_for_dinner/views/widgets/app/gradient_button.dart';
import 'package:whats_for_dinner/views/widgets/lists/list_ingredient_cell.dart';
import 'package:whats_for_dinner/views/widgets/recipes/recipe_categories_picker.dart';
import 'package:whats_for_dinner/views/widgets/recipes/select_recipe_categories.dart';

class ImportedRecipe extends StatefulWidget {
  ImportedRecipe({Key? key}) : super(key: key);

  @override
  State<ImportedRecipe> createState() => _ImportedRecipeState();
}

class _ImportedRecipeState extends State<ImportedRecipe> {
  final recipe = Get.arguments as Recipe;

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
      color: appBlue,
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double fortyFivePercent = screenHeight * .45;

    double height5 = screenHeight / 186.4;
    double height20 = screenHeight / 48.6;
    double height50 = screenHeight / 17.92;
    double height55 = screenHeight / 16.945;
    double height100 = screenHeight / 8.96;
    double height350 = screenHeight / 2.56;

    double width30 = screenWidth / 13.8;
    double width100 = screenWidth / 4.3;

    double fontSize28 = screenHeight / 33.285;
    double fontSize16 = screenHeight / 58.25;
    double fontSize18 = screenHeight / 51.777;
    double fontSize20 = screenHeight / 44.8;

    double iconSize28 = screenHeight / 32;

    String selectedCategory = "";
    List<String> selectedCategories = [];

    void onSelectedItem(int selectedItem) {
      if (selectedItem == 0) {
        return;
      } else {
        selectedItem -= 1;
        selectedCategory = categories[selectedItem];
      }
    }

    void updateCategories(String newCategory) {
      if (selectedCategories.contains(newCategory)) {
        //remove category
        selectedCategories.remove(newCategory);
      } else {
        selectedCategories.add(newCategory);
      }
      print(selectedCategories);
    }

    void onSubmitAddCategory(String category) {
      bool didAdd = recipeController.addRecipeCategory(category);
      if (didAdd) {
        setState(() {
          categories.add(category);
        });
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: width30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                recipe.name != null ? recipe.name! : "no name",
                style: TextStyle(
                  fontSize: fontSize28,
                  fontWeight: FontWeight.w700,
                  color: appBlue,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                recipe.sourceUrl != null
                    ? trimSourceUrl(recipe.sourceUrl!)
                    : "",
                style: TextStyle(
                  fontSize: fontSize16,
                  fontWeight: FontWeight.w600,
                  color: black,
                ),
              ),
              SizedBox(height: height5),
              Text(
                'Quick add ingredients to a list:',
                style: TextStyle(
                  fontSize: fontSize18,
                  fontWeight: FontWeight.w600,
                  color: appBlue,
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: height350,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children:
                        recipe.ingredients.map(buildRecipeIngredient).toList(),
                  ),
                ),
              ),
              SizedBox(height: height20),
              GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.getSelectListFromImportRecipe(),
                      arguments: ingredientsToAdd);
                },
                child: Container(
                  height: height55,
                  width: width100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: appBlue,
                  ),
                  child: Center(
                    child: Text(
                      'Add',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSize20,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height5),
              //RecipeCategoriesPicker(onSelect: onSelectedItem),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Add to Folders",
                    style: TextStyle(
                      fontSize: fontSize18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(
                          RouteHelper.getSingleTextfieldAndSubmitScreen(),
                          arguments: [
                            appBlue,
                            "Add Recipe Folder",
                            onSubmitAddCategory,
                            Icons.add_rounded,
                          ]);
                    },
                    child: Icon(
                      Icons.add_circle_outline_rounded,
                      size: iconSize28,
                      color: appBlue,
                    ),
                  ),
                ],
              ),
              Container(
                height: 3,
                width: width30,
                color: appBlue,
              ),
              SelectRecipeCategories(
                updateCategories: updateCategories,
                selectedCategories: selectedCategories,
                height: height100,
                onAddCategory: () {},
              ),

              GestureDetector(
                onTap: () {
                  recipe.categories = selectedCategories;
                  recipeController.uploadRecipe(recipe);
                  Navigator.pop(context);
                  Get.toNamed(
                    RouteHelper.getRecipeScreen(),
                    arguments: recipe,
                  );
                },
                child: Align(
                  alignment: Alignment.center,
                  child: GradientButton(
                    buttonText: 'Confirm',
                    firstColor: lightBlue,
                    secondColor: appBlue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
