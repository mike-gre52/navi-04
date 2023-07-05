import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/main.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';

class SelectRecipeCategories extends StatefulWidget {
  Function updateCategories;
  List<String> selectedCategories;
  Function onAddCategory;
  double height;
  SelectRecipeCategories({
    super.key,
    required this.updateCategories,
    required this.selectedCategories,
    required this.onAddCategory,
    required this.height,
  });

  @override
  State<SelectRecipeCategories> createState() => _SelectRecipeCategoriesState();
}

class _SelectRecipeCategoriesState extends State<SelectRecipeCategories> {
  Widget buildListItem(String category) {
    if (widget.selectedCategories.contains(category)) {
      return CategoryCell(
        category: category,
        updateCategories: widget.updateCategories,
        isChecked: true,
      );
    } else {
      return CategoryCell(
        category: category,
        updateCategories: widget.updateCategories,
        isChecked: false,
      );
    }
  }

  void onSubmitAddCategory(String category) {
    bool didAdd = recipeController.addRecipeCategory(category);
    if (didAdd) {
      setState(() {
        categories.add(category);
      });
      widget.onAddCategory();
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double height5 = screenHeight / 179.2;
    double fontSize16 = screenHeight / 56;

    return Container(
      height: widget.height,
      child: categories.isNotEmpty
          ? ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) => buildListItem(
                categories[index],
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "You have no folders created",
                    style: TextStyle(
                      fontSize: fontSize16,
                    ),
                  ),
                  SizedBox(height: height5),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(
                          RouteHelper.getSingleTextfieldAndSubmitScreen(),
                          arguments: [
                            appBlue,
                            "Add Recipe Folder",
                            onSubmitAddCategory,
                            Icons.folder_rounded,
                          ]);
                    },
                    child: Text(
                      "Click Here",
                      style: TextStyle(
                        fontSize: fontSize16,
                        color: appBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class CategoryCell extends StatefulWidget {
  String category;
  Function updateCategories;
  bool isChecked;
  CategoryCell({
    super.key,
    required this.category,
    required this.updateCategories,
    required this.isChecked,
  });

  @override
  State<CategoryCell> createState() => _CategoryCellState();
}

class _CategoryCellState extends State<CategoryCell> {
  bool isSelected = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSelected = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screnWidth = mediaQuery.size.width;

    double height5 = screenHeight / 179.2;

    double height30 = screenHeight / 29.866;

    double width10 = screnWidth / 41.4;
    double width30 = screnWidth / 13.8;

    double fontSize16 = screenHeight / 56;
    double fontSize18 = screenHeight / 49.777;

    return Container(
      margin: EdgeInsets.symmetric(vertical: height5),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              //add to list
              widget.updateCategories(widget.category);
              setState(() {
                isSelected = !isSelected;
              });
            },
            child: Container(
              height: height30,
              width: height30,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(color: appBlue, width: 2),
              ),
              child: isSelected
                  ? Center(
                      child: Icon(
                        Icons.check_rounded,
                        size: fontSize18,
                      ),
                    )
                  : null,
            ),
          ),
          SizedBox(width: width10),
          Text(
            widget.category,
            style: TextStyle(
              fontSize: fontSize16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
