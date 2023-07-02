import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/main.dart';
import 'package:whats_for_dinner/models/recipe.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/utils/helper.dart';
import 'package:whats_for_dinner/views/widgets/app/border_button.dart';
import 'package:whats_for_dinner/views/widgets/app/gradient_button.dart';
import 'package:whats_for_dinner/views/widgets/lists/list_ingredient_cell.dart';
import 'package:whats_for_dinner/views/widgets/recipes/recipe_categories_picker.dart';
import 'package:whats_for_dinner/views/widgets/recipes/select_recipe_categories.dart';

class SelectedCategoriesScreen extends StatefulWidget {
  SelectedCategoriesScreen({Key? key}) : super(key: key);

  @override
  State<SelectedCategoriesScreen> createState() =>
      _SelectedCategoriesScreenState();
}

class _SelectedCategoriesScreenState extends State<SelectedCategoriesScreen> {
  final recipe = Get.arguments as Recipe;

  List<String> ingredientsToAdd = [];

  void addIngredient(String ingredient) {
    setState(() {
      ingredientsToAdd += [ingredient];
    });
  }

  void removeIngredient(String ingredient) {
    setState(() {
      ingredientsToAdd.remove(ingredient);
    });
  }

  Widget buildRecipeIngredient(Ingredient ingredient) {
    return ListIngredientCell(
      ingredient: ingredient.name,
      addIngredientToList: addIngredient,
      removeIngredientFromList: removeIngredient,
      color: appBlue,
    );
  }

  List<String> selectedCategories = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedCategories = recipe.categories;
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double fortyFivePercent = screenHeight * .45;

    double height5 = screenHeight / 186.4;
    double height20 = screenHeight / 48.6;
    double height50 = screenHeight / 17.92;
    double height55 = screenHeight / 16.945;
    double height250 = screenHeight / 3.584;

    double width30 = screenWidth / 13.8;
    double width100 = screenWidth / 4.3;

    double fontSize28 = screenHeight / 33.285;
    double fontSize16 = screenHeight / 58.25;
    double fontSize18 = screenHeight / 51.777;
    double fontSize20 = screenHeight / 44.8;

    String selectedCategory = "";

    void onSelectedItem(int selectedItem) {
      if (selectedItem == 0) {
        return;
      } else {
        selectedItem -= 1;
        selectedCategory = categories[selectedItem];
      }
    }

    void updateCategories(String newCategory) {
      if (selectedCategories.contains(newCategory)) {
        //remove category
        selectedCategories.remove(newCategory);
      } else {
        selectedCategories.add(newCategory);
      }
      print(selectedCategories);
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: width30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select Cateogries:",
                style: TextStyle(
                  fontSize: fontSize28,
                  fontWeight: FontWeight.w700,
                  color: appBlue,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              Container(
                height: 3,
                width: width100,
                color: appBlue,
              ),
              SelectRecipeCategories(
                updateCategories: updateCategories,
                selectedCategories: selectedCategories,
                height: height250,
              ),
              SizedBox(height: height5),
              GestureDetector(
                onTap: () {
                  recipe.categories = selectedCategories;
                  recipeController.updateRecipeCategories(recipe);
                  Navigator.pop(context);
                },
                child: Align(
                  alignment: Alignment.center,
                  child: BorderButton(
                    buttonColor: appBlue,
                    buttonText: 'Submit',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
