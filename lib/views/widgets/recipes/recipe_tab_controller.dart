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
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;
    double height30 = screenHeight / 29.86;
    double height50 = screenHeight / 17.92;
    double height100 = screenHeight / 8.96;
    double height125 = screenHeight / 7.168;
    double height150 = screenHeight / 5.973;
    double height200 = screenHeight / 4.48;
    double height600 = screenHeight / 1.493;
    double width30 = screenWidth / 13.8;
    double fontSize16 = screenHeight / 56;
    double fontSize18 = screenHeight / 49.777;
    TabController _tabController =
        TabController(length: 2, vsync: this, initialIndex: tabIndex);

    //listens for when the tab controller is changed

    return Container(
      width: double.maxFinite,
      child: Column(
        children: [
          Container(
            height: widget.recipe.isImport ? height150 : height100,
            width: double.maxFinite,
            decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 2, color: royalYellow),
                ),
                color: const Color.fromRGBO(250, 250, 250, 1.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                widget.recipe.isImport
                    ? Container(
                        margin: EdgeInsets.symmetric(horizontal: width30),
                        height: height30,
                        child: Row(
                          children: [
                            Text(
                              'Source: ',
                              style: TextStyle(fontSize: fontSize18),
                            ),
                            GestureDetector(
                              onTap: () {
                                searchUrl(widget.recipe.sourceUrl);
                              },
                              child: Text(
                                trimSourceUrl(widget.recipe.sourceUrl),
                                style: TextStyle(
                                    color: royalYellow, fontSize: fontSize16),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                widget.recipe.cookTime == -1 || widget.recipe.prepTime == -1
                    ? TotalTime(recipe: widget.recipe)
                    : SplitTime(recipe: widget.recipe),
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
            constraints: BoxConstraints(
              minHeight: height600,
            ),
            child: Container(
              height: tabIndex == 0
                  ? widget.recipe.ingredients.length.toDouble() * height50
                  : widget.recipe.instructions.length.toDouble() * height200,
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
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double fontSize14 = screenHeight / 64;
    double fontSize16 = screenHeight / 56;
    return Column(
      children: [
        Text(
          header,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: fontSize16,
          ),
        ),
        Text(
          subheader,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: fontSize14,
          ),
        ),
      ],
    );
  }
}
