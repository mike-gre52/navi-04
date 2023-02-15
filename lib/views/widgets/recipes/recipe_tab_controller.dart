import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/utils/helper.dart';
import 'package:whats_for_dinner/views/widgets/recipes/recipe_ingredients.dart';
import 'package:whats_for_dinner/views/widgets/recipes/recipe_instructions.dart';

import '../../../models/recipe.dart';

class RecipeTabController extends StatefulWidget {
  Recipe recipe;
  RecipeTabController({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  State<RecipeTabController> createState() => _RecipeTabControllerState();
}

int tabIndex = 0;

class _RecipeTabControllerState extends State<RecipeTabController>
    with TickerProviderStateMixin {
  @override
  @override
  Widget build(BuildContext context) {
    TabController _tabController =
        TabController(length: 2, vsync: this, initialIndex: tabIndex);

    //listens for when the tab controller is changed

    return Container(
      width: double.maxFinite,
      child: Column(
        children: [
          Container(
            height: widget.recipe.isImport ? 125 : 100,
            width: double.maxFinite,
            decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 2, color: royalYellow),
                ),
                color: const Color.fromRGBO(250, 250, 250, 1.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                widget.recipe.cookTime == -1 || widget.recipe.prepTime == -1
                    ? TotalTime(recipe: widget.recipe)
                    : SplitTime(recipe: widget.recipe),
                widget.recipe.isImport
                    ? Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        height: 30,
                        child: Row(
                          children: [
                            const Text(
                              'Source: ',
                              style: TextStyle(fontSize: 18),
                            ),
                            GestureDetector(
                              onTap: () {
                                searchUrl(widget.recipe.sourceUrl);
                              },
                              child: Text(
                                trimSourceUrl(widget.recipe.sourceUrl),
                                style:
                                    TextStyle(color: royalYellow, fontSize: 16),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                TabBar(
                  onTap: (value) {
                    if (value == 0) {
                      setState(() {
                        tabIndex = 0;
                      });
                    } else {
                      setState(() {
                        tabIndex = 1;
                      });
                    }
                  },
                  labelColor: appBlue,
                  unselectedLabelColor: black,
                  indicatorColor: royalYellow,
                  splashBorderRadius: BorderRadius.circular(0),
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'Ingredients'),
                    Tab(text: 'Instructions'),
                  ],
                ),
              ],
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 600,
            ),
            child: Container(
              height: tabIndex == 0
                  ? widget.recipe.ingredients.length.toDouble() * 50
                  : widget.recipe.instructions.length.toDouble() * 200,
              color: paperBackground,
              width: double.maxFinite,
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  RecipeIngredientList(
                    ingredients: widget.recipe.ingredients,
                    showDelete: false,
                    deleteIngredient: () {},
                  ),
                  RecipeInstructionList(
                    instructions: widget.recipe.instructions,
                    showDelete: false,
                    deleteInstruction: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SplitTime extends StatelessWidget {
  Recipe recipe;
  SplitTime({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        RecipeInfo(
          header: 'Prep Time:',
          subheader: recipe.prepTime.toString(),
        ),
        RecipeInfo(
          header: 'Cook Time:',
          subheader: recipe.cookTime.toString(),
        ),
        RecipeInfo(
          header: 'Servings:',
          subheader: recipe.servings.toString(),
        )
      ],
    );
  }
}

class TotalTime extends StatelessWidget {
  Recipe recipe;
  TotalTime({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        RecipeInfo(
          header: 'Total Time:',
          subheader: recipe.totalTime != -2 ? recipe.totalTime.toString() : '',
        ),
        RecipeInfo(
          header: 'Servings:',
          subheader: recipe.servings.toString(),
        )
      ],
    );
  }
}

class RecipeInfo extends StatelessWidget {
  String header;
  String subheader;
  RecipeInfo({
    Key? key,
    required this.header,
    required this.subheader,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          header,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
        Text(
          subheader,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
