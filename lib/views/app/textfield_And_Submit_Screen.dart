import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/views/widgets/app/border_button.dart';
import 'package:whats_for_dinner/views/widgets/app/custom_textfield.dart';

import '../../models/recipe.dart';

class TextfieldAndSubmitScreen extends StatefulWidget {
  const TextfieldAndSubmitScreen({Key? key}) : super(key: key);

  @override
  State<TextfieldAndSubmitScreen> createState() =>
      _TextfieldAndSubmitScreenState();
}

class _TextfieldAndSubmitScreenState extends State<TextfieldAndSubmitScreen> {
  final TextEditingController _textController = TextEditingController();

  final data = Get.arguments as List;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height10 = screenHeight / 89.6;
    double height15 = screenHeight / 59.733;
    double height25 = screenHeight / 35.84;
    double height30 = screenHeight / 29.86;
    double height60 = screenHeight / 14.933;
    double width10 = screenWidth / 41.4;
    double width30 = screenWidth / 13.8;

    double fontSize18 = screenHeight / 49.777;
    return Scaffold(
        body: SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: width30, right: width30, top: height30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: width10, right: width10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Add a Recipe Name below',
                      style: TextStyle(
                        fontSize: fontSize18,
                        color: black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (() {
                      Navigator.pop(context);
                    }),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: fontSize18,
                        color: black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height15),
            CustomTextfield(
              icon: CupertinoIcons.link,
              placeholderText: 'recipe link',
              controller: _textController,
              borderColor: appBlue,
              textfieldWidth: double.maxFinite,
              textfieldHeight: height60,
              borderRadius: height10,
              onSubmit: (_) {},
              onChanged: (_) {},
            ),
            SizedBox(height: height15),
            GestureDetector(
              onTap: () {
                //recipeController.addLinkRecipe(_linkController.text);
                //Navigator.pop(context);
              },
              child: BorderButton(
                buttonColor: appBlue,
                buttonText: 'Submit',
              ),
            ),
            SizedBox(height: height25),
          ],
        ),
      ),
    ));
  }
}
