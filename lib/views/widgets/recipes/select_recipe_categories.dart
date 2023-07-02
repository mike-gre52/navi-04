import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:whats_for_dinner/main.dart';
import 'package:whats_for_dinner/utils/colors.dart';

class SelectRecipeCategories extends StatelessWidget {
  Function updateCategories;
  List<String> selectedCategories;
  double height;
  SelectRecipeCategories({
    super.key,
    required this.updateCategories,
    required this.selectedCategories,
    required this.height,
  });

  Widget buildListItem(String category) {
    if (selectedCategories.contains(category)) {
      return CategoryCell(
        category: category,
        updateCategories: updateCategories,
        isChecked: true,
      );
    } else {
      return CategoryCell(
        category: category,
        updateCategories: updateCategories,
        isChecked: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;

    return Container(
      height: height,
      child: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) => buildListItem(
          categories[index],
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
