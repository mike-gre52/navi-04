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
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      height: 75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
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
              height: 75,
              width: 75,
              child: !recipe.imageUrl.isNotEmpty
                  ? Icon(CupertinoIcons.photo)
                  : null,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
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
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 5),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: Text(
                          recipe.name,
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              height: 1.1,
                              overflow: TextOverflow.ellipsis),
                          maxLines: 2,
                        ),
                      ),
                      Row(
                        children: [
                          const Text(
                            'Time: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          recipe.totalTime != -2
                              ? Text('${recipe.totalTime} mins')
                              : Container(
                                  width: 30,
                                ),
                          //Icon(Icons.),
                          const SizedBox(width: 10),
                          const Text(
                            'Yield: ',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          Text(
                            '${recipe.servings}',
                          ),
                        ],
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
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (context) => RecipesPopup(recipe: recipe),
                );
              },
              child: Container(
                height: 75,
                width: 30,
                decoration: BoxDecoration(
                  color: appBlue,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: const Icon(
                  Icons.more_vert,
                  size: 32,
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
