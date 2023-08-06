import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/models/recipe.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/utils/helper.dart';
import 'package:whats_for_dinner/views/widgets/recipes/recipes_popup.dart';

import '../../../routes/routes.dart';

class RecipeCell extends StatelessWidget {
  Recipe recipe;
  bool inFolder;
  String category;

  RecipeCell({
    Key? key,
    required this.recipe,
    this.inFolder = false,
    this.category = "",
  }) : super(key: key);

  int? getTime() {
    int? time;
    if ((recipe.cookTime != null && recipe.prepTime != null) &&
        !(recipe.cookTime == -1 && recipe.prepTime == -1)) {
      if (recipe.cookTime != -1 && recipe.prepTime != -1) {
        time = recipe.cookTime! + recipe.prepTime!;
      }
    } else if (recipe.totalTime != null) {
      if (recipe.totalTime! > 0) {
        time = recipe.totalTime!;
      }
    } else {
      time = null;
    }
    return time;
  }

  onEditTotalTime(String data) {
    int? totalTime = int.tryParse(data);
    if (totalTime != null) {
      print("updating time");
      recipeController.updateRecipeTotalTime(recipe, totalTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;
    double height5 = screenHeight / 179.2;
    double height15 = screenHeight / 59.733;
    double height32 = screenHeight / 28;
    double height75 = screenHeight / 11.946;
    double height100 = screenHeight / 8.96;
    double width10 = screenWidth / 41.4;
    double width5 = screenWidth / 82.8;
    double width20 = screenWidth / 20.7;
    double width30 = screenWidth / 13.8;
    double fontSize22 = screenHeight / 40.727;

    int? totalTime = getTime();

    return Container(
      margin: EdgeInsets.only(top: height5, bottom: height5),
      height: height75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(height15),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(210, 210, 210, 1.0),
            offset: Offset(0.0, 2.0),
            blurRadius: 2.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Container(
        //margin: EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          children: [
            Container(
              height: height75,
              width: height75,
              child: recipe.imageUrl != null
                  ? !recipe.imageUrl!.isNotEmpty
                      ? Icon(CupertinoIcons.photo)
                      : null
                  : Icon(CupertinoIcons.photo),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(height15),
                    bottomLeft: Radius.circular(height15)),
                color: Colors.grey,
                image: recipe.imageUrl != null && recipe.imageUrl!.isNotEmpty
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          recipe.imageUrl!,
                        ),
                      )
                    : null,
              ),
            ),
            SizedBox(width: width10),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: width5),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: height5),
                        child: Text(
                          recipe.name != null ? recipe.name! : "no name",
                          style: TextStyle(
                              fontSize: fontSize22,
                              fontWeight: FontWeight.w600,
                              height: 1.05,
                              overflow: TextOverflow.ellipsis),
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        child: Text(
                          recipe.isImport != null && recipe.isImport!
                              ? trimSourceUrl(recipe.sourceUrl != null
                                  ? recipe.sourceUrl!
                                  : "")
                              : "",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            height: 0.9,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  //isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(width20),
                    ),
                  ),
                  builder: (context) => RecipesPopup(
                    recipe: recipe,
                    inFolder: inFolder,
                    category: category,
                  ),
                );
              },
              child: Container(
                height: height75,
                width: width30,
                decoration: BoxDecoration(
                  color: appBlue,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(height15),
                    bottomRight: Radius.circular(height15),
                  ),
                ),
                child: Icon(
                  Icons.more_vert,
                  size: height32,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
