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

  @override
  Widget build(BuildContext context) {
    Widget buildRecipeCell(Recipe recipe) {
      if (recipe.isLink != null) {
        return !recipe.isLink!
            ? GestureDetector(
                onTap: (() {
                  Get.toNamed(RouteHelper.getSelectIngredients(), arguments: [
                    recipe,
                    list,
                    color,
                  ]);
                }),
                child: SelectRecipeCell(
                  recipe: recipe,
                ),
              )
            : Container();
      } else {
        return Container();
      }
    }

    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height5 = screenHeight / 179.2;
    double width20 = screenWidth / 20.7;
    double fontSize20 = screenHeight / 44.8;

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
                  rightAction: Text(
                    'Back',
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
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        left: width20, right: width20, top: height5),
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
