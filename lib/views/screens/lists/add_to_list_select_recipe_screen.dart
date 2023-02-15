import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/models/list.dart';
import 'package:whats_for_dinner/models/recipe.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/utils/helper.dart';
import 'package:whats_for_dinner/views/screens/lists/select_recipe_cell.dart';
import 'package:whats_for_dinner/views/widgets/app/app_header.dart';
import 'package:whats_for_dinner/views/widgets/recipes/recipe_cell.dart';
import 'package:whats_for_dinner/views/widgets/recipes/recipe_link_cell.dart';

import '../../../routes/routes.dart';

class AddToListSelectRecipeScreen extends StatefulWidget {
  AddToListSelectRecipeScreen({Key? key}) : super(key: key);

  @override
  State<AddToListSelectRecipeScreen> createState() =>
      _AddToListSelectRecipeScreenState();
}

class _AddToListSelectRecipeScreenState
    extends State<AddToListSelectRecipeScreen> {
  late ListData list;
  late Color color;
  final data = Get.arguments as List;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    list = data[0] as ListData;
    color = data[1] as Color;
  }

  Widget buildRecipeCell(Recipe recipe) => !recipe.isLink
      ? GestureDetector(
          onTap: (() {
            Navigator.pop(context);
            Get.toNamed(RouteHelper.getSelectIngredients(),
                arguments: [recipe, list, color]);
          }),
          child: SelectRecipeCell(
            recipe: recipe,
          ),
        )
      : Container();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Recipe>>(
        stream: recipeController.getRecipes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final recipes = snapshot.data!;
            return Column(
              children: [
                AppHeader(
                  headerText: 'Select Recipe',
                  headerColor: color,
                  borderColor: royalYellow,
                  textColor: Colors.white,
                  dividerColor: Colors.white,
                  rightAction: const Text(
                    'Back',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onIconClick: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 5),
                    child: ListView(
                      padding: const EdgeInsets.all(0),
                      children: recipes.map(buildRecipeCell).toList(),
                    ),
                  ),
                )
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
