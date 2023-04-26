import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/app/gradient_button.dart';

import '../../widgets/app/custom_textfield.dart';

class BookmarkLink extends StatefulWidget {
  const BookmarkLink({Key? key}) : super(key: key);

  @override
  State<BookmarkLink> createState() => _BookmarkLinkState();
}

class _BookmarkLinkState extends State<BookmarkLink> {
  final TextEditingController _linkController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _linkController.dispose();
  }

  final url = Get.arguments as String;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height10 = screenHeight / 89.6;
    double height15 = screenHeight / 59.733;
    double height20 = screenHeight / 44.8;
    double height30 = screenHeight / 29.86;
    double height60 = screenHeight / 14.933;
    double width30 = screenWidth / 13.8;
    double fontSize18 = screenHeight / 49.777;
    double fontSize20 = screenHeight / 44.8;

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: width30, vertical: height20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
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
              ),
              SizedBox(height: height10),
              Text(
                'Unfortunately this recipe could not be imported. You can still bookmark the link. Just include a name for the recipe!',
                style: TextStyle(
                    fontSize: fontSize20, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: height15),
              CustomTextfield(
                icon: CupertinoIcons.link,
                placeholderText: 'Recipe Name',
                controller: _linkController,
                borderColor: appBlue,
                textfieldWidth: double.maxFinite,
                textfieldHeight: height60,
                borderRadius: height10,
                showIcon: false,
                onSubmit: (_) {},
                onChanged: (_) {},
              ),
              SizedBox(height: height30),
              GestureDetector(
                onTap: () {
                  if (_linkController.text != '') {
                    recipeController.addLinkRecipe(url, _linkController.text);
                    Navigator.pop(context);
                  }
                },
                child: GradientButton(
                  buttonText: 'Add',
                  firstColor: lightBlue,
                  secondColor: appBlue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
