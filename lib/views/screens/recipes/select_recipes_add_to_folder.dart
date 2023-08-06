import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/models/list.dart';
import 'package:whats_for_dinner/models/recipe.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/utils/helper.dart';
import 'package:whats_for_dinner/views/screens/lists/select_recipe_cell.dart';
import 'package:whats_for_dinner/views/screens/recipes/select_recipes_cell.dart';
import 'package:whats_for_dinner/views/widgets/app/app_header.dart';
import 'package:whats_for_dinner/views/widgets/app/gradient_button.dart';
import 'package:whats_for_dinner/views/widgets/recipes/recipe_cell.dart';
import 'package:whats_for_dinner/views/widgets/recipes/recipe_link_cell.dart';

import '../../../routes/routes.dart';

class SelectRecipesAddToFolderScreen extends StatefulWidget {
  SelectRecipesAddToFolderScreen({Key? key}) : super(key: key);

  @override
  State<SelectRecipesAddToFolderScreen> createState() =>
      _SelectRecipesAddToFolderScreenState();
}

class _SelectRecipesAddToFolderScreenState
    extends State<SelectRecipesAddToFolderScreen> {
  //late ListData list;
  //late Color color;
  final category = Get.arguments as String;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //list = data[0] as ListData;
    //color = data[1] as Color;
  }

  List<Recipe> selectedRecipes = [];

  bool containsRecipe(Recipe newRecipe) {
    for (Recipe recipe in selectedRecipes) {
      if (recipe.id == newRecipe.id) {
        return true;
      }
    }
    return false;
  }

  int recipeIndex(Recipe newRecipe) {
    int index = 0;
    for (Recipe recipe in selectedRecipes) {
      if (recipe.id == newRecipe.id) {
        return index;
      }
      index++;
    }
    return -1;
  }

  void onSelectRecipe(Recipe recipe) {
    if (containsRecipe(recipe)) {
      //unselect recipe
      setState(() {
        selectedRecipes.removeAt(recipeIndex(recipe));
      });
    } else {
      //select recipe
      setState(() {
        selectedRecipes.add(recipe);
      });
    }
  }

  bool isSelected(Recipe recipe) {
    return containsRecipe(recipe);
  }

  List<Recipe> recipesNotInFolder(List<Recipe> recipes) {
    List<Recipe> recipesNotInFolder = [];
    for (Recipe recipe in recipes) {
      if (!recipe.categories.contains(category)) {
        recipesNotInFolder.add(recipe);
      }
    }
    return recipesNotInFolder;
  }

  @override
  Widget build(BuildContext context) {
    Widget buildRecipeCell(Recipe recipe) {
      if (recipe.isLink != null) {
        return GestureDetector(
          onTap: (() {}),
          child: SelectRecipesCell(
            recipe: recipe,
            isSelected: isSelected(recipe),
            onSelectRecipe: onSelectRecipe,
          ),
        );
      } else {
        return Container();
      }
    }

    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height5 = screenHeight / 179.2;
    double height50 = screenHeight / 35.84;
    double height75 = screenHeight / 11.946;

    double width20 = screenWidth / 20.7;
    double width100 = screenWidth / 4.14;

    double fontSize20 = screenHeight / 44.8;
    double fontSize24 = screenHeight / 37.333;

    return Scaffold(
      body: StreamBuilder<List<Recipe>>(
        stream: recipeController.getRecipes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final recipes = snapshot.data!;
            List<Recipe> selectableRecipes = recipesNotInFolder(recipes);
            return Column(
              children: [
                AppHeader(
                  headerText: 'Select Recipes',
                  headerColor: appBlue,
                  borderColor: royalYellow,
                  textColor: Colors.white,
                  dividerColor: Colors.white,
                  rightAction: Text(
                    'Cancel',
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
                selectableRecipes.isNotEmpty
                    ? Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                              left: width20, right: width20, top: height5),
                          child: ListView.builder(
                            itemCount: selectableRecipes.length + 1,
                            padding: const EdgeInsets.all(0),
                            itemBuilder: (context, index) {
                              if (index < selectableRecipes.length) {
                                print(selectableRecipes.length);
                                return buildRecipeCell(
                                    selectableRecipes[index]);
                              } else {
                                return GestureDetector(
                                    onTap: () {
                                      recipeController.addRecipesToCategory(
                                          selectedRecipes, category);
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        right: width100,
                                        left: width100,
                                        top: height50,
                                      ),
                                      height: height75,
                                      decoration: BoxDecoration(
                                          color: appBlue,
                                          borderRadius:
                                              BorderRadius.circular(height50)),
                                      child: Center(
                                        child: Text(
                                          "Add",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: fontSize24,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ));
                              }
                            },
                            //children: recipesNotInFolder(recipes)
                            //    .map(buildRecipeCell)
                            //    .toList(),
                          ),
                        ),
                      )
                    : Text(
                        "There are no recipes to select",
                        style: TextStyle(
                          fontSize: fontSize20,
                          color: appBlue,
                        ),
                      ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
