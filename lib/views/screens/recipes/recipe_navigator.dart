import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/main.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/screens/recipes/filtered_recipe.dart';
import 'package:whats_for_dinner/views/screens/recipes/folder_bottom_popup.dart';
import 'package:whats_for_dinner/views/screens/recipes/recipe_folders.dart';
import 'package:whats_for_dinner/views/screens/recipes/recipes.dart';
import 'package:whats_for_dinner/views/screens/restaurants/filter_restaurants.dart';
import 'package:whats_for_dinner/views/widgets/app/app_header.dart';
import 'package:whats_for_dinner/views/widgets/app/create_or_join_banner.dart';

enum recipePage {
  allRecipes,
  recipeFolders,
  filteredRecipes,
}

class RecipeNavigator extends StatefulWidget {
  final screen;
  Function setScreen;
  String category;
  RecipeNavigator({
    super.key,
    required this.screen,
    required this.setScreen,
    required this.category,
  });

  @override
  State<RecipeNavigator> createState() => _RecipeNavigatorState();
}

class _RecipeNavigatorState extends State<RecipeNavigator> {
  updateUI() {
    setState(() {});
  }

  void onSubmitAddCategory(String category) {
    bool didAdd = recipeController.addRecipeCategory(category);
    if (didAdd) {
      setState(() {
        categories.add(category);
      });
    }
  }

  void onSubmitEditFolderName(String newFolderName) async {
    if (!categories.contains(newFolderName)) {
      await recipeController.renameCategory(widget.category, newFolderName);
      int categoryIndex = categories.indexOf(widget.category);
      categories[categoryIndex] = newFolderName;
      setState(() {
        //widget.category = newFolderName;
        widget.setScreen(recipePage.filteredRecipes, newFolderName);
      });
    } else {
      Get.snackbar(
        'The folder name already exists',
        'You cannot create a duplicate folder',
      );
    }

    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: inGroup
          ? Column(
              children: [
                AppHeader(
                  headerText: widget.screen == recipePage.allRecipes
                      ? "Recipes"
                      : widget.screen == recipePage.recipeFolders
                          ? "Folders"
                          : "${widget.category}",
                  headerColor: appBlue,
                  borderColor: royalYellow,
                  textColor: Colors.white,
                  dividerColor: Colors.white,
                  rightAction: widget.screen == recipePage.allRecipes
                      ? AllRecipesNavigation(setScreen: widget.setScreen)
                      : widget.screen == recipePage.recipeFolders
                          ? RecipeFoldersNavigation(
                              setScreen: widget.setScreen,
                              onCreateCategory: onSubmitAddCategory,
                            )
                          : FilteredRecipeNavigation(
                              setScreen: widget.setScreen,
                              category: widget.category,
                              onSubmitEditRecipeScreen: onSubmitEditFolderName,
                            ),
                  onIconClick: () {
                    //recipeController.getRecipeQuery();
                  },
                ),
                widget.screen == recipePage.allRecipes
                    ? RecipesScreen(setScreen: widget.setScreen)
                    : widget.screen == recipePage.recipeFolders
                        ? RecipeFoldersScreen(setScreen: widget.setScreen)
                        : FilteredRecipeScreen(
                            setScreen: widget.setScreen,
                            category: widget.category,
                          )
              ],
            )
          : Column(
              children: [
                AppHeader(
                  headerText: 'Recipes',
                  headerColor: appBlue,
                  borderColor: royalYellow,
                  textColor: Colors.white,
                  dividerColor: Colors.white,
                  rightAction: Container(),
                  onIconClick: () {},
                ),
                Expanded(
                  child: Center(
                    child: CreateOrJoinBanner(
                      onCreateGroup: updateUI,
                      color: appBlue,
                      item: "recipe",
                      onClickHere: updateUI,
                    ),
                  ),
                ),
              ],
            ),
    );

/*
    return screen == recipePage.allRecipes
        ? const RecipesScreen(setScreen: widget.setScreen)
        : screen == recipePage.recipeFolders
            ? const RecipeFoldersScreen(setScreen: widget.setScreen)
            : const FilterRestaurantScreens(setScreen: widget.setScreen);

  */
  }
}

class AllRecipesNavigation extends StatelessWidget {
  Function setScreen;
  AllRecipesNavigation({super.key, required this.setScreen});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height40 = screenHeight / 22.4;
    double width10 = screenWidth / 41.4;

    double iconSize24 = screenHeight / 37.333;

    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setScreen(recipePage.recipeFolders, "");
          },
          child: Icon(
            Icons.folder,
            color: Colors.white,
            size: iconSize24,
          ),
        ),
        SizedBox(width: width10),
        GestureDetector(
          onTap: () {
            Get.toNamed(RouteHelper.addRecipe);
          },
          child: Icon(
            Icons.add_rounded,
            size: height40,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class RecipeFoldersNavigation extends StatelessWidget {
  Function setScreen;
  Function onCreateCategory;
  RecipeFoldersNavigation({
    super.key,
    required this.setScreen,
    required this.onCreateCategory,
  });

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;

    double screenWidth = mediaQuery.size.width;
    double width10 = screenWidth / 41.4;
    double fontSize24 = screenHeight / 37.333;
    double iconSize40 = screenHeight / 22.4;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            setScreen(recipePage.allRecipes, "");
          },
          child: Text(
            'All',
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(width: width10),
        GestureDetector(
          onTap: () {
            Get.toNamed(RouteHelper.getSingleTextfieldAndSubmitScreen(),
                arguments: [
                  appBlue,
                  "Add Recipe Folder",
                  onCreateCategory,
                  Icons.folder_rounded,
                ]);
          },
          child: Icon(
            Icons.add_rounded,
            size: iconSize40,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class FilteredRecipeNavigation extends StatefulWidget {
  Function setScreen;
  String category;
  Function onSubmitEditRecipeScreen;
  FilteredRecipeNavigation({
    super.key,
    required this.setScreen,
    required this.category,
    required this.onSubmitEditRecipeScreen,
  });

  @override
  State<FilteredRecipeNavigation> createState() =>
      _FilteredRecipeNavigationState();
}

class _FilteredRecipeNavigationState extends State<FilteredRecipeNavigation> {
  void onSubmitDelete() {
    widget.setScreen(recipePage.recipeFolders, "");
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height35 = screenHeight / 25.6;
    double height40 = screenHeight / 22.4;

    double width5 = screenWidth / 82.8;

    double fontSize20 = screenHeight / 44.8;

    double iconSize24 = screenHeight / 37.333;
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              //isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              builder: (context) => FolderBottomPopup(
                category: widget.category,
                onSubmitEditFolderName: widget.onSubmitEditRecipeScreen,
                onSubmitDelete: onSubmitDelete,
              ),
            );
          },
          child: Icon(
            Icons.more_vert,
            color: Colors.white,
            size: height35,
          ),
        ),
        SizedBox(width: width5),
        GestureDetector(
          onTap: () {
            widget.setScreen(recipePage.recipeFolders, "");
          },
          child: Text(
            'Back',
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        /*
        GestureDetector(
          onTap: () {
            setScreen(recipePage.recipeFolders, "");
            // Get.toNamed(
            //     RouteHelper.getRecipeFoldersScreen());
          },
          child: Icon(
            Icons.folder,
            color: Colors.white,
            size: iconSize24,
          ),
        ),
        SizedBox(width: width10),
        GestureDetector(
          onTap: () {
            setScreen(recipePage.allRecipes, "");
          },
          child: Text(
            'All',
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        */
      ],
    );
  }
}












/*

*/