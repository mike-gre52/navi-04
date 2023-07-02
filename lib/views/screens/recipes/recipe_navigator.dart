import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/main.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/views/screens/recipes/filtered_recipe.dart';
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
                          ? RecipeFoldersNavigation(setScreen: widget.setScreen)
                          : FilteredRecipeNavigation(
                              setScreen: widget.setScreen),
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
                    ),
                  ),
                ),
              ],
            ),
    );
    switch (widget.screen) {
      case recipePage.allRecipes:
        return RecipesScreen(setScreen: widget.setScreen);
      case recipePage.recipeFolders:
        return RecipeFoldersScreen(setScreen: widget.setScreen);
      default:
        return FilteredRecipeScreen(
            setScreen: widget.setScreen, category: widget.category);
    }

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
  RecipeFoldersNavigation({super.key, required this.setScreen});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double fontSize20 = screenHeight / 44.8;
    return GestureDetector(
      onTap: () {
        setScreen(recipePage.allRecipes, "");
      },
      child: Text(
        'View All',
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class FilteredRecipeNavigation extends StatelessWidget {
  Function setScreen;
  FilteredRecipeNavigation({
    super.key,
    required this.setScreen,
  });

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height40 = screenHeight / 22.4;
    double width10 = screenWidth / 41.4;

    double fontSize20 = screenHeight / 44.8;

    double iconSize24 = screenHeight / 37.333;
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setScreen(recipePage.recipeFolders, "");
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