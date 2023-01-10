import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
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

const List<Tab> tabs = <Tab>[
  Tab(text: 'First'),
  Tab(text: 'Second'),
];

class _RecipeTabControllerState extends State<RecipeTabController>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);

    // listens for when the tab controller is changed
    //_tabController.addListener(() {
    //  print('');
    //});

    return Container(
      // margin: EdgeInsets.only(top: 300),
      width: double.maxFinite,
      height: 1000,
      child: Column(
        children: [
          Container(
            height: 100,
            width: double.maxFinite,
            decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 2, color: royalYellow),
                ),
                color: const Color.fromRGBO(250, 250, 250, 1.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RecipeInfo(
                      header: 'Prep Time:',
                      subheader: widget.recipe.prepTime.toString(),
                    ),
                    RecipeInfo(
                      header: 'Cook Time:',
                      subheader: widget.recipe.cookTime.toString(),
                    ),
                    RecipeInfo(
                      header: 'Servings:',
                      subheader: widget.recipe.servings.toString(),
                    )
                  ],
                ),
                TabBar(
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
          Expanded(
            child: Container(
              color: paperBackground,
              height: 500,
              width: double.maxFinite,
              child: TabBarView(
                controller: _tabController,
                children: [
                  RecipeIngredientList(
                    ingredients: widget.recipe.ingredients,
                  ),
                  RecipeInstructionList(
                    instructions: widget.recipe.instructions,
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
