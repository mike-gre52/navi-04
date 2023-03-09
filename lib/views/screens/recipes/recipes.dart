import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/main.dart';
import 'package:whats_for_dinner/models/recipe.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/utils/helper.dart';
import 'package:whats_for_dinner/views/widgets/app/app_header.dart';
import 'package:whats_for_dinner/views/widgets/app/create_or_join_banner.dart';
import 'package:whats_for_dinner/views/widgets/recipes/recipe_cell.dart';
import 'package:whats_for_dinner/views/widgets/recipes/recipe_link_cell.dart';

import '../../../routes/routes.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({Key? key}) : super(key: key);

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  Widget buildRecipeCell(Recipe recipe) => recipe.isLink
      ? GestureDetector(
          onTap: (() {
            searchUrl(recipe.sourceUrl);
          }),
          child: RecipeLinkCell(
            recipe: recipe,
          ),
        )
      : GestureDetector(
          onTap: (() {
            Get.toNamed(RouteHelper.recipeScreen, arguments: recipe);
            //Get.toNamed(RouteHelper.testScreen);
          }),
          child: RecipeCell(
            recipe: recipe,
          ),
        );

  updateUI() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;

    double height5 = screenHeight / 186.4;
    double height20 = screenHeight / 48.6;
    double height40 = screenHeight / 22.4;
    double height55 = screenHeight / 16.945;
    double height70 = screenHeight / 13.314;
    double height200 = screenHeight / 4.48;
    double height250 = screenHeight / 3.584;

    double width10 = screenWidth / 41.4;
    double width20 = screenWidth / 20.7;
    double width30 = screenWidth / 13.8;
    double width100 = screenWidth / 4.3;

    double fontSize28 = screenHeight / 33.285;
    double fontSize16 = screenHeight / 58.25;
    double fontSize18 = screenHeight / 51.777;
    double fontSize20 = screenHeight / 44.8;
    return Scaffold(
      body: inGroup
          ? StreamBuilder<List<Recipe>>(
              stream: recipeController.getRecipes(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final recipes = snapshot.data!;
                  return Column(
                    children: [
                      AppHeader(
                        headerText: 'Recipes',
                        headerColor: appBlue,
                        borderColor: royalYellow,
                        textColor: Colors.white,
                        dividerColor: Colors.white,
                        rightAction: Icon(
                          Icons.add_rounded,
                          size: height40,
                          color: Colors.white,
                        ),
                        onIconClick: () {
                          Get.toNamed(RouteHelper.addRecipe);
                        },
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                              left: width20, right: width20, top: height5),
                          child: ListView.builder(
                            padding: const EdgeInsets.all(0),
                            itemCount: recipes.length,
                            itemBuilder: (BuildContext context, int index) {
                              return buildRecipeCell(recipes[index]);
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              },
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
  }
}
