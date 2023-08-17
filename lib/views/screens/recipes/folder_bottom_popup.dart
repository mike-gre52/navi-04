import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:whats_for_dinner/main.dart';
import 'package:whats_for_dinner/models/list.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/app/app_yes_no_popup.dart';

import '../../../routes/routes.dart';

class FolderBottomPopup extends StatefulWidget {
  String category;
  Function onSubmitEditFolderName;
  Function onSubmitDelete;
  FolderBottomPopup({
    Key? key,
    required this.category,
    required this.onSubmitEditFolderName,
    required this.onSubmitDelete,
  }) : super(key: key);

  @override
  State<FolderBottomPopup> createState() => _FolderBottomPopupState();
}

class _FolderBottomPopupState extends State<FolderBottomPopup> {
  void _confirmActionFunction() {
    Navigator.pop(context);
    Navigator.pop(context);
    recipeController.deleteRecipeCategory(widget.category);
    categories.remove(widget.category);
    widget.onSubmitDelete();
  }

  _showDeleteFolderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AppYesNoPopup(
        header: 'Are you sure you want to delete this folder?',
        subHeader: 'All data will be lost',
        confirmAction: "Yes",
        cancelAction: "No",
        confirmActionFunction: _confirmActionFunction,
      ),
      barrierDismissible: true,
    );
  }

  void onDeleteRecipeCategory() {}

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;
    double height5 = screenHeight / 179.2;
    double height175 = screenHeight / 5.12;
    double width100 = screenWidth / 4.14;

    return Container(
      height: height175,
      child: Column(
        children: [
          Container(
            margin:
                EdgeInsets.symmetric(horizontal: width100, vertical: height5),
            height: height5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: grey,
            ),
          ),
          PopupButton(
            icon: CupertinoIcons.plus,
            buttonName: 'Add Recipes',
            onClick: () {
              Navigator.pop(context);
              Get.toNamed(
                RouteHelper.getSelectRecipesAddToFolder(),
                arguments: widget.category,
              );
            },
          ),
          PopupButton(
            icon: Icons.edit_outlined,
            buttonName: 'Edit Folder Name',
            isRed: false,
            onClick: () {
              Navigator.pop(context);
              Get.toNamed(
                RouteHelper.getEditNameScreen(),
                arguments: [
                  appBlue,
                  "Edit Folder Name",
                  widget.onSubmitEditFolderName,
                  Icons.edit,
                  widget.category,
                ],
              );
            },
          ),
          PopupButton(
            icon: CupertinoIcons.delete,
            buttonName: 'Delete Folder',
            isRed: true,
            onClick: () {
              _showDeleteFolderDialog(context);
            },
          ),
        ],
      ),
    );
  }
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
    double height10 = screenHeight / 89.6;
    double height15 = screenHeight / 59.733;
    double width30 = screenWidth / 13.8;
    double fontSize20 = screenHeight / 44.8;
    return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Container(
        margin: EdgeInsets.only(left: width30, top: height10),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: height15),
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
