import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/utils/helper.dart';
import 'package:whats_for_dinner/views/widgets/recipes/recipe_popup.dart';

import '../../../models/recipe.dart';
import '../../widgets/recipes/recipe_tab_controller.dart';
import '../../widgets/recipes/recipes_popup.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({Key? key}) : super(key: key);

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  final recipe = Get.arguments as Recipe;

  @override
  Widget build(BuildContext context) {
    updateUI() {
      setState(() {});
    }

    return Scaffold(
      //backgroundColor: appBlue,

      body: Container(
        //margin: const EdgeInsets.only(top: 75),
        color: appBlue,
        child: SafeArea(
          bottom: false,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: appBlue,
                expandedHeight: 200,
                pinned: true,
                actions: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          //isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (context) => RecipePopup(
                            recipe: recipe,
                            updateUI: updateUI,
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.more_vert,
                      ),
                    ),
                  ),
                ],
                //floating: true,
                title: Text(recipe.name),
                flexibleSpace: FlexibleSpaceBar(
                  background: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 250,
                      minWidth: double.infinity,
                    ),
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        recipe.imageUrl,
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  child: RecipeTabController(
                    recipe: recipe,
                  ),
                ),
              ),
              /*
              SliverToBoxAdapter(
                child: Container(
                  height: 50,
                  color: paperBackground,
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, bottom: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Source: ',
                          style: TextStyle(fontSize: 18),
                        ),
                        GestureDetector(
                          onTap: () {
                            searchUrl(
                                'https://sallysbakingaddiction.com/chewy-chocolate-chip-cookies/');
                          },
                          child: Text(
                            'sallysbakingaddiction.com',
                            style: TextStyle(fontSize: 18, color: royalYellow),
                          ),
                        )
                      ],
                    ),
                  ),
                  //color: Color.fromRGBO(245, 242, 233, 1.0),
                ),
              ),
              */
            ],
          ),
        ),
      ),
    );
  }
}
