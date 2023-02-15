import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whats_for_dinner/models/recipe.dart';
import 'package:whats_for_dinner/utils/colors.dart';

class ListIngredientCell extends StatefulWidget {
  String ingredient;
  Function addIngredientToList;
  Function removeIngredientFromList;
  Color color;
  ListIngredientCell({
    Key? key,
    required this.ingredient,
    required this.addIngredientToList,
    required this.removeIngredientFromList,
    required this.color,
  }) : super(key: key);

  @override
  State<ListIngredientCell> createState() => _ListIngredientCellState();
}

class _ListIngredientCellState extends State<ListIngredientCell> {
  @override
  bool isSelected = false;
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height; //896
    double screenWidth = mediaQuery.size.width; //414
    double height10 = screenHeight / 89.6;
    double height40 = screenHeight / 22.4;
    double height30 = screenHeight / 29.86;

    return Container(
      margin: EdgeInsets.only(top: 10, right: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              isSelected = !isSelected;
              if (isSelected) {
                widget.addIngredientToList(widget.ingredient);
              }
              if (!isSelected) {
                widget.removeIngredientFromList(widget.ingredient);
              }
            },
            child: isSelected
                ? Container(
                    height: height30,
                    width: height30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(height10),
                      color: widget.color,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  )
                : Container(
                    height: height30,
                    width: height30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(height10),
                      border: Border.all(
                        color: widget.color,
                        width: 2,
                      ),
                    ),
                  ),
          ),
          SizedBox(width: 10),
          Flexible(
            child: Text(
              widget.ingredient,
            ),
          ),
        ],
      ),
    );
  }
}
