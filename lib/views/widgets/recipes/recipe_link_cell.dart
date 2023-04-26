import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whats_for_dinner/models/recipe.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/helper.dart';
import 'package:whats_for_dinner/views/widgets/recipes/recipes_popup.dart';

class RecipeLinkCell extends StatelessWidget {
  Recipe recipe;

  RecipeLinkCell({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;
    double height5 = screenHeight / 179.2;
    double height10 = screenHeight / 89.6;
    double height15 = screenHeight / 59.733;
    double height20 = screenHeight / 44.8;
    double height32 = screenHeight / 28;
    double height50 = screenHeight / 17.92;
    double width5 = screenWidth / 82.8;
    double width30 = screenWidth / 13.8;
    double fontSize18 = screenHeight / 49.777;

    return Container(
      margin: EdgeInsets.only(top: height10),
      height: height50,
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
        margin: EdgeInsets.only(left: width5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: height50,
              width: width30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(height15),
                  bottomLeft: Radius.circular(height15),
                ),
              ),
              child: Icon(
                CupertinoIcons.link,
                size: height20,
                color: appBlue,
              ),
            ),
            Flexible(
              child: Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(left: width5, top: height5),
                child: Text(
                  recipe.name != null ? recipe.name! : "no name",
                  style: TextStyle(
                      fontSize: fontSize18,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                      height: 1),
                  maxLines: 2,
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
                      top: Radius.circular(height20),
                    ),
                  ),
                  builder: (context) => RecipesPopup(recipe: recipe),
                );
              },
              child: Container(
                height: height50,
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
