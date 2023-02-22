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

  @override
  Widget build(BuildContext context) {
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
                        rightAction: const Icon(
                          Icons.add_rounded,
                          size: 40,
                          color: Colors.white,
                        ),
                        onIconClick: () {
                          Get.toNamed(RouteHelper.addRecipe);
                        },
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, top: 5),
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
                      color: appBlue,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
