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
    return Scaffold(
        body: SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: 30, right: 30, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Add a Recipe Name below',
                      style: TextStyle(
                        fontSize: 18,
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
                        fontSize: 18,
                        color: black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            CustomTextfield(
              icon: CupertinoIcons.link,
              placeholderText: 'recipe link',
              controller: _textController,
              borderColor: appBlue,
              textfieldWidth: double.maxFinite,
              textfieldHeight: 60,
              borderRadius: 10,
              onSubmit: (_) {},
              onChanged: (_) {},
            ),
            const SizedBox(height: 5),
            const SizedBox(height: 15),
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
            const SizedBox(height: 25),
          ],
        ),
      ),
    ));
  }
}
