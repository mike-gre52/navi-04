import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/controllers/image_controller.dart';
import 'package:whats_for_dinner/main.dart';
import 'package:whats_for_dinner/models/list.dart';
import 'package:whats_for_dinner/models/recipe.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/app/app_yes_no_popup.dart';

import '../../../routes/routes.dart';

class RecipePopup extends StatefulWidget {
  Recipe recipe;
  Function updateUI;
  Function updateImage;
  RecipePopup({
    Key? key,
    required this.recipe,
    required this.updateUI,
    required this.updateImage,
  }) : super(key: key);

  @override
  State<RecipePopup> createState() => _RecipePopupState();
}

class _RecipePopupState extends State<RecipePopup> {
  void onDialogAction() {
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
    recipeController.deleteRecipe(widget.recipe);
  }

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AppYesNoPopup(
          header: 'Are you sure you want to delete this Recipe?',
          subHeader: 'All data will be lost',
          leftActionButton: "Yes",
          rightActionButton: 'Cancel',
          leftActionFunction: onDialogAction),
      barrierDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    ImageController imageController = ImageController();
    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;
    double height5 = screenHeight / 179.2;
    double height160 = screenHeight / 5.6;
    double height200 = screenHeight / 4.48;
    double height240 = screenHeight / 3.733;
    double height280 = screenHeight / 3.2;
    double width100 = screenWidth / 4.14;

    void onSubmit() async {
      if (imageController.image != null) {
        Reference ref = firebaseStorage
            .ref()
            .child(globalGroupId)
            .child('recipeImages')
            .child(widget.recipe.id!);

        String url =
            await imageController.uploadToStorage(imageController.image!, ref);

        recipeController.updateImageUrl(widget.recipe, url);

        widget.updateImage(url);
      }
    }

    return Container(
      height: widget.recipe.isImport != null && !widget.recipe.isImport!
          ? height280
          : height240,
      child: Column(
        children: [
          Container(
            margin:
                EdgeInsets.symmetric(horizontal: width100, vertical: height5),
            height: height5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(height5),
              color: grey,
            ),
          ),
          PopupButton(
            icon: CupertinoIcons.plus_rectangle,
            buttonName: 'Add Ingredient to list',
            onClick: () {
              Navigator.pop(context);
              Get.toNamed(RouteHelper.getSelectList(),
                  arguments: widget.recipe);
            },
          ),
          PopupButton(
            icon: Icons.edit,
            buttonName: 'Edit Ingredients',
            onClick: () {
              Navigator.pop(context);
              Get.toNamed(RouteHelper.editRecipeScreen, arguments: [
                'Ingredients',
                widget.recipe,
                widget.updateUI,
              ]);

              //Edit Ingredients
              //Navigator.pop(context);
            },
          ),
          PopupButton(
            icon: Icons.edit,
            buttonName: 'Edit Instructions',
            onClick: () {
              Navigator.pop(context);
              Get.toNamed(RouteHelper.editRecipeScreen, arguments: [
                'Instructions',
                widget.recipe,
                widget.updateUI,
              ]);
            },
          ),
          widget.recipe.isImport != null && !widget.recipe.isImport!
              ? PopupButton(
                  icon: Icons.image,
                  isRed: false,
                  buttonName: 'Change Image',
                  onClick: () {
                    Navigator.pop(context);
                    _showActionSheet(
                      context,
                      imageController,
                      onSubmit,
                    );
                  },
                )
              : Container(),
          PopupButton(
            icon: Icons.folder_rounded,
            isRed: false,
            buttonName: 'Edit Folders:',
            onClick: () {
              Navigator.pop(context);
              Get.toNamed(
                RouteHelper.getSelectCategoriesScreen(),
                arguments: widget.recipe,
              );
            },
          ),
          PopupButton(
            icon: Icons.delete,
            isRed: true,
            buttonName: 'Delete Recipe',
            onClick: () {
              _showDialog(context);
            },
          ),
        ],
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

class PopupButton extends StatelessWidget {
  IconData icon;
  String buttonName;
  bool isRed;
  Function onClick;
  PopupButton(
      {Key? key,
      required this.icon,
      required this.buttonName,
      required this.onClick,
      this.isRed = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;
    double height7 = screenHeight / 128;
    double width15 = screenWidth / 27.6;
    double width30 = screenWidth / 13.8;
    double fontSize20 = screenHeight / 44.8;

    return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Container(
        margin: EdgeInsets.only(left: width30, top: height7),
        child: Row(
          children: [
            Icon(
              icon,
              color: isRed ? red : black,
            ),
            SizedBox(width: width15),
            Text(
              buttonName,
              style: TextStyle(
                fontSize: fontSize20,
                fontWeight: FontWeight.w700,
                color: isRed ? red : black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
