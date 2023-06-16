import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whats_for_dinner/main.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/utils/helper.dart';
import 'package:whats_for_dinner/utils/recipe_cell_helper.dart';
import 'package:whats_for_dinner/views/widgets/app/banner_add.dart';
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
  setPrepTime(String data) {
    int? prepTime = int.tryParse(data);
    if (prepTime != null) {
      recipeController.updateRecipePrepTime(widget.recipe, prepTime);
      setState(() {
        widget.recipe.prepTime = prepTime;
      });
    }
  }

  setCookTime(String data) {
    int? cookTime = int.tryParse(data);
    if (cookTime != null) {
      recipeController.updateRecipeCookTime(widget.recipe, cookTime);
      setState(() {
        widget.recipe.cookTime = cookTime;
      });
    }
  }

  setServings(String data) {
    recipeController.updateRecipeServings(widget.recipe, data);
    setState(() {
      widget.recipe.servings = data;
    });
  }

  setTotalTime(String data) {
    int? totalTime = int.tryParse(data);
    if (totalTime != null) {
      recipeController.updateRecipeTotalTime(widget.recipe, totalTime);
      setState(() {
        widget.recipe.totalTime = totalTime;
      });
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;
    double height30 = screenHeight / 29.86;
    double height45 = screenHeight / 19.911;
    double height50 = screenHeight / 17.92;
    double height60 = screenHeight / 14.933;
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
            height: isPremium ? height100 : height150,
            width: double.maxFinite,
            decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 2, color: royalYellow),
                ),
                color: const Color.fromRGBO(250, 250, 250, 1.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                widget.recipe.cookTime == -1 ||
                        widget.recipe.prepTime == -1 ||
                        (widget.recipe.cookTime == null &&
                            widget.recipe.prepTime == null &&
                            widget.recipe.totalTime != null)
                    ? TotalTime(
                        recipe: widget.recipe,
                        setTotalTime: setTotalTime,
                        setServings: setServings,
                      )
                    : SplitTime(
                        recipe: widget.recipe,
                        setPrepTime: setPrepTime,
                        setCookTime: setCookTime,
                        setServings: setServings,
                      ),
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
                isPremium
                    ? Container()
                    : Container(
                        height: height50,
                        child: BannerAdWidget(),
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
                  ? widget.recipe.ingredients.length.toDouble() * height45
                  : RecipeCellHelper.getInstructionHeight(
                      widget.recipe.instructions, screenHeight, screenWidth),
              color: paperBackground,
              width: double.maxFinite,
              child: TabBarView(
                physics: const AlwaysScrollableScrollPhysics(),
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
  Function setPrepTime;
  Function setCookTime;
  Function setServings;
  SplitTime({
    Key? key,
    required this.recipe,
    required this.setPrepTime,
    required this.setCookTime,
    required this.setServings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        RecipeInfo(
          header: 'Prep Time:',
          subheader: recipe.prepTime != null ? recipe.prepTime.toString() : '',
          onEdit: setPrepTime,
        ),
        RecipeInfo(
          header: 'Cook Time:',
          subheader: recipe.cookTime != null ? recipe.cookTime.toString() : '',
          onEdit: setCookTime,
        ),
        RecipeInfo(
          header: 'Servings:',
          subheader: recipe.servings != null ? recipe.servings.toString() : '',
          onEdit: setServings,
        )
      ],
    );
  }
}

class TotalTime extends StatelessWidget {
  Recipe recipe;
  Function setTotalTime;
  Function setServings;
  TotalTime({
    Key? key,
    required this.recipe,
    required this.setTotalTime,
    required this.setServings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        RecipeInfo(
          header: 'Total Time:',
          subheader: recipe.totalTime != -2 ? recipe.totalTime.toString() : '',
          onEdit: setTotalTime,
        ),
        RecipeInfo(
          header: 'Servings:',
          subheader: recipe.servings != null ? recipe.servings.toString() : '',
          onEdit: setServings,
        )
      ],
    );
  }
}

class RecipeInfo extends StatelessWidget {
  String header;
  String subheader;
  Function onEdit;
  RecipeInfo({
    Key? key,
    required this.header,
    required this.subheader,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double width100 = screenWidth / 4.14;
    double fontSize14 = screenHeight / 64;
    double fontSize16 = screenHeight / 56;
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                header,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: fontSize16,
                ),
              ),
              SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.getSingleTextfieldAndSubmitScreen(),
                      arguments: [appBlue, header, onEdit, Icons.edit_rounded]);
                },
                child: const Icon(
                  CupertinoIcons.info,
                  size: 16,
                ),
              )
            ],
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: width100),
            child: Text(
              subheader,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: fontSize14,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
        ],
      ),
    );
  }
}
