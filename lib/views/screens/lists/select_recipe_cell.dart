import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whats_for_dinner/models/recipe.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/helper.dart';

class SelectRecipeCell extends StatelessWidget {
  Recipe recipe;

  SelectRecipeCell({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height5 = screenHeight / 179.2;
    double height10 = screenHeight / 89.6;
    double height15 = screenHeight / 59.733;
    double height30 = screenHeight / 29.86;
    double height50 = screenHeight / 17.92;
    double width10 = screenWidth / 41.4;
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
        margin: EdgeInsets.only(left: width10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(top: height5),
                child: Text(
                  recipe.name,
                  style: TextStyle(
                      fontSize: fontSize18,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                      height: 1),
                  maxLines: 2,
                ),
              ),
            ),
            Container(
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
                size: height30,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
