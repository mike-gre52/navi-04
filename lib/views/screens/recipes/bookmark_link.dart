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
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: (() {
                    Navigator.pop(context);
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
              ),
              const SizedBox(height: 10),
              const Text(
                'Unfortunately this recipe could not be imported. You can still bookmark the link. Just include a name for the recipe!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 15),
              CustomTextfield(
                icon: CupertinoIcons.link,
                placeholderText: 'Recipe Name',
                controller: _linkController,
                borderColor: appBlue,
                textfieldWidth: double.maxFinite,
                textfieldHeight: 60,
                borderRadius: 10,
                showIcon: false,
                onSubmit: (_) {},
                onChanged: (_) {},
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  if (_linkController.text != '') {
                    recipeController.addLinkRecipe(url, _linkController.text);
                    Navigator.pop(context);
                    Navigator.pop(context);
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
