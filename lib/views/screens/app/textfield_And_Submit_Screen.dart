import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/views/widgets/app/border_button.dart';
import 'package:whats_for_dinner/views/widgets/app/custom_textfield.dart';

import '../../../models/recipe.dart';

class TextfieldAndSubmitScreen extends StatefulWidget {
  const TextfieldAndSubmitScreen({Key? key}) : super(key: key);

  @override
  State<TextfieldAndSubmitScreen> createState() =>
      _TextfieldAndSubmitScreenState();
}

class _TextfieldAndSubmitScreenState extends State<TextfieldAndSubmitScreen> {
  final TextEditingController _textController = TextEditingController();

  final data = Get.arguments as List;
  late final Color color;
  late final String header;
  late final Function onSubmit;
  late final IconData textfieldIcon;
  TextInputType keyboard = TextInputType.text;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    color = data[0];
    header = data[1];
    onSubmit = data[2];
    textfieldIcon = data[3];

    if (data.length > 4) {
      keyboard = data[4];
    } else {
      keyboard = TextInputType.text;
    }
  }

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
                      header,
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
              icon: textfieldIcon,
              placeholderText: '',
              controller: _textController,
              borderColor: color,
              textfieldWidth: double.maxFinite,
              textfieldHeight: height60,
              borderRadius: height10,
              keyboard: keyboard,
              onSubmit: (_) {},
              onChanged: (_) {},
            ),
            SizedBox(height: height15),
            GestureDetector(
              onTap: () {
                if (_textController.text.trim() != "") {
                  //Takes a single String parameter(the text in the textfield)
                  onSubmit(_textController.text);
                  Navigator.pop(context);
                }
              },
              child: BorderButton(
                buttonColor: color,
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
