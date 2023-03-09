import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whats_for_dinner/main.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/utils/helper.dart';
import 'package:whats_for_dinner/views/widgets/recipes/recipe_popup.dart';

import '../../../controllers/image_controller.dart';
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
  ImageController imageController = ImageController();

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;

    double height5 = screenHeight / 186.4;
    double height20 = screenHeight / 48.6;
    double height40 = screenHeight / 22.4;
    double height55 = screenHeight / 16.945;
    double height70 = screenHeight / 13.314;
    double height200 = screenHeight / 4.48;
    double height250 = screenHeight / 3.584;

    double width10 = screenWidth / 41.4;
    double width30 = screenWidth / 13.8;
    double width100 = screenWidth / 4.3;

    double fontSize28 = screenHeight / 33.285;
    double fontSize16 = screenHeight / 58.25;
    double fontSize18 = screenHeight / 51.777;
    double fontSize20 = screenHeight / 44.8;
    updateUI() {
      setState(() {});
    }

    void onSubmit() async {
      if (imageController.image != null) {
        Reference ref = firebaseStorage
            .ref()
            .child(globalGroupId)
            .child('recipeImages')
            .child(recipe.id);

        String url =
            await imageController.uploadToStorage(imageController.image!, ref);

        recipeController.updateImageUrl(recipe, url);

        setState(() {
          recipe.imageUrl = url;
        });
      }
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
                expandedHeight: height200,
                pinned: true,
                actions: [
                  Container(
                    margin: EdgeInsets.only(right: width10),
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          //isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(height20),
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
                    constraints: BoxConstraints(
                      maxHeight: height250,
                      minWidth: double.infinity,
                    ),
                    child: Image.network(
                      recipe.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return GestureDetector(
                          onTap: () {
                            _showActionSheet(
                              context,
                              imageController,
                              onSubmit,
                            );
                          },
                          child: Center(
                            child: Icon(
                              CupertinoIcons.photo,
                              size: height40,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  //height: 2000,
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

void _showActionSheet(
  BuildContext context,
  ImageController imageController,
  Function onSubmit,
) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          /// This parameter indicates the action would be a default
          /// defualt behavior, turns the action's text to bold text.
          onPressed: () {
            //Open Library
            imageController.pickImage(false, onSubmit);
            Navigator.pop(context);
          },
          child: const Text('Choose from library'),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            //Open Camera
            imageController.pickImage(true, onSubmit);
            Navigator.pop(context);
          },
          child: const Text('Take photo'),
        ),
        CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ],
    ),
  );
}
