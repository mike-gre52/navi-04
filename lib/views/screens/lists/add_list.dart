import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';

import '../../widgets/app/app_header.dart';
import '../../widgets/app/custom_textfield.dart';
import '../../widgets/app/gradient_button.dart';

class AddListScreen extends StatelessWidget {
  AddListScreen({Key? key}) : super(key: key);

  final TextEditingController _listNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppHeader(
            headerText: 'Add list',
            headerColor: appGreen,
            borderColor: royalYellow,
            textColor: Colors.white,
            dividerColor: Colors.white,
            rightAction: const Text(
              'Cancel',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            onIconClick: () {
              Navigator.pop(context);
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Text(
                    'List Name',
                    style: TextStyle(
                      fontSize: 18,
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
                  textfieldHeight: 60,
                  borderRadius: 10,
                  onSubmit: (_) {},
                  onChanged: (_) {},
                ),
                const SizedBox(
                  height: 40,
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
