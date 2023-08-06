import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/models/recipe.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';

class RecipeIngredientList extends StatelessWidget {
  Recipe recipe;
  bool showDelete;
  List<int> checkedItems;
  Function deleteIngredient;
  Function editCheckedItems;
  RecipeIngredientList({
    Key? key,
    required this.recipe,
    required this.showDelete,
    required this.deleteIngredient,
    required this.checkedItems,
    required this.editCheckedItems,
  }) : super(key: key);

  int counter = 0;

  bool isThisIngredientChecked(int index) {
    return checkedItems.contains(index);
  }

  Widget buildRecipeIngredient(Ingredient ingredient) {
    counter++;
    return RecipeIngredient(
      recipe: recipe,
      stepNumber: counter,
      ingredient: ingredient.name,
      showDelete: showDelete,
      deleteIngredient: deleteIngredient,
      isChecked: isThisIngredientChecked(counter - 1),
      editCheckedItems: editCheckedItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Ingredient> ingredients = recipe.ingredients;
    counter = 0;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: ingredients.map(buildRecipeIngredient).toList(),
      ),
    );
  }
}

class RecipeIngredient extends StatefulWidget {
  Recipe recipe;
  int stepNumber;
  String ingredient;
  bool showDelete;
  Function deleteIngredient;
  bool isChecked;
  Function editCheckedItems;
  RecipeIngredient({
    Key? key,
    required this.recipe,
    required this.stepNumber,
    required this.ingredient,
    required this.showDelete,
    required this.deleteIngredient,
    required this.isChecked,
    required this.editCheckedItems,
  }) : super(key: key);

  @override
  State<RecipeIngredient> createState() => _RecipeIngredientState();
}

class _RecipeIngredientState extends State<RecipeIngredient> {
  void toggleIsChecked() {
    if (widget.isChecked) {
      //calls the editCheckedItems function which takes two parameters
      //one boolean which if true removes the index
      //stepnumber - 1 must be used because the stepnumber is one higher than the index
      widget.editCheckedItems(true, widget.stepNumber - 1);
    } else {
      //adds the index to the list of selected items
      widget.editCheckedItems(false, widget.stepNumber - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("building recipe item");
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;

    double height5 = screenHeight / 179.2;
    double height15 = screenHeight / 89.6;
    double height25 = screenHeight / 35.84;
    double icon16 = screenHeight / 56;
    double width5 = screenWidth / 82.8;
    double fontSize20 = screenHeight / 44.8;

    return Container(
      margin: widget.stepNumber == 1
          ? EdgeInsets.only(top: 5)
          : EdgeInsets.only(top: height15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              toggleIsChecked();
            },
            child: Container(
              height: height25,
              width: height25,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: appBlue),
                borderRadius: BorderRadius.circular(5),
                color: widget.isChecked ? appBlue : Colors.transparent,
              ),
              child: widget.isChecked
                  ? Center(
                      child: Icon(
                        Icons.check,
                        size: icon16,
                        color: paperBackground,
                      ),
                    )
                  : null,
            ),
          ),
          SizedBox(width: width5),
          Text(
            '${widget.stepNumber})  ',
            style: TextStyle(
                fontSize: fontSize20, fontWeight: FontWeight.w500, height: 1.2),
          ),
          Expanded(
            child: Text(
              widget.ingredient,
              style: TextStyle(
                fontSize: fontSize20,
                fontWeight: FontWeight.w500,
                height: 1.2,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getSelectList(),
                  arguments: widget.recipe);
            },
            child: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
    );
  }
}
