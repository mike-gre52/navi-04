import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/models/list.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/app/border_button.dart';
import 'package:whats_for_dinner/views/widgets/app/custom_textfield.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({Key? key}) : super(key: key);

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final TextEditingController _linkController = TextEditingController();

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
                      'Add Recipe link:',
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
              controller: _linkController,
              borderColor: appBlue,
              textfieldWidth: double.maxFinite,
              textfieldHeight: 60,
              borderRadius: 10,
              onSubmit: (_) {},
              onChanged: (_) {},
            ),
            const SizedBox(height: 25),
            GestureDetector(
              onTap: () {
                recipeController.addLinkRecipe(_linkController.text);
                Navigator.pop(context);
              },
              child: BorderButton(
                buttonColor: appBlue,
                buttonText: 'Submit',
              ),
            ),
            const SizedBox(height: 25),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Want to create a recipe from scratch?',
                style: TextStyle(fontSize: 20),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.getAddRestaurantRoute());
              },
              child: Text(
                'Click Here',
                style: TextStyle(
                    color: appBlue, fontWeight: FontWeight.w600, fontSize: 22),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
