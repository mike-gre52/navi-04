import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whats_for_dinner/models/recipe.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/views/widgets/recipes/recipes_popup.dart';

class RecipeCell extends StatelessWidget {
  Recipe recipe;

  RecipeCell({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;
    double height5 = screenHeight / 179.2;
    double height15 = screenHeight / 59.733;
    double height32 = screenHeight / 28;
    double height75 = screenHeight / 11.946;
    double width10 = screenWidth / 41.4;
    double width5 = screenWidth / 82.8;
    double width20 = screenWidth / 20.7;
    double width30 = screenWidth / 13.8;
    double fontSize22 = screenHeight / 40.727;

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
              child: !recipe.imageUrl.isNotEmpty
                  ? Icon(CupertinoIcons.photo)
                  : null,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(height15),
                    bottomLeft: Radius.circular(height15)),
                color: Colors.grey,
                image: recipe.imageUrl.isNotEmpty
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          recipe.imageUrl,
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
                          recipe.name,
                          style: TextStyle(
                              fontSize: fontSize22,
                              fontWeight: FontWeight.w600,
                              height: 1.1,
                              overflow: TextOverflow.ellipsis),
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            const Text(
                              'Time: ',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                height: 0.9,
                              ),
                            ),
                            recipe.totalTime != -2
                                ? Text(
                                    '${recipe.totalTime} mins',
                                    style: const TextStyle(height: 0.9),
                                  )
                                : Container(
                                    width: width30,
                                  ),
                            //Icon(Icons.),
                            SizedBox(width: width10),
                            const Text(
                              'Yield: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, height: 0.9),
                            ),
                            Text(
                              '${recipe.servings}',
                              style: const TextStyle(height: 0.9),
                            ),
                          ],
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
                  builder: (context) => RecipesPopup(recipe: recipe),
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
