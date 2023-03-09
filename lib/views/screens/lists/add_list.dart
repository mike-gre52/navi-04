import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';

import '../../widgets/app/app_header.dart';
import '../../widgets/app/custom_textfield.dart';
import '../../widgets/app/gradient_button.dart';

class AddListScreen extends StatefulWidget {
  AddListScreen({Key? key}) : super(key: key);

  @override
  State<AddListScreen> createState() => _AddListScreenState();
}

class _AddListScreenState extends State<AddListScreen> {
  final TextEditingController _listNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _listNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height5 = screenHeight / 179.2;
    double height10 = screenHeight / 89.6;
    double height20 = screenHeight / 44.8;
    double height40 = screenHeight / 22.4;
    double height60 = screenHeight / 14.933;
    double width30 = screenWidth / 13.8;
    double fontSize18 = screenHeight / 49.777;

    return Scaffold(
      body: Column(
        children: [
          AppHeader(
            headerText: 'Add list',
            headerColor: appGreen,
            borderColor: royalYellow,
            textColor: Colors.white,
            dividerColor: Colors.white,
            rightAction: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.white,
                fontSize: height20,
                fontWeight: FontWeight.w600,
              ),
            ),
            onIconClick: () {
              Navigator.pop(context);
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: width30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height10,
                ),
                Container(
                  margin: EdgeInsets.only(left: height5),
                  child: Text(
                    'List Name',
                    style: TextStyle(
                      fontSize: fontSize18,
                      color: black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                CustomTextfield(
                  icon: Icons.list_rounded,
                  placeholderText: '',
                  controller: _listNameController,
                  borderColor: appGreen,
                  textfieldWidth: double.maxFinite,
                  textfieldHeight: height60,
                  borderRadius: height10,
                  onSubmit: (_) {},
                  onChanged: (_) {},
                ),
                SizedBox(
                  height: height40,
                ),
                GestureDetector(
                  onTap: () {
                    if (_listNameController.text.length > 0) {
                      listController.createList(_listNameController.text);

                      Navigator.pop(context);
                    } else {
                      Get.snackbar(
                        'Please enter a name',
                        'The name field cannot be empty',
                      );
                    }
                  },
                  child: GradientButton(
                    buttonText: 'Create',
                    firstColor: lightGreen,
                    secondColor: appGreen,
                    showArrow: false,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
