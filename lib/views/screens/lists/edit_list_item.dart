import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/models/list.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/app/border_button.dart';
import 'package:whats_for_dinner/views/widgets/app/custom_textfield.dart';

class EditListItemScreen extends StatefulWidget {
  const EditListItemScreen({Key? key}) : super(key: key);

  @override
  State<EditListItemScreen> createState() => _EditListItemScreenState();
}

class _EditListItemScreenState extends State<EditListItemScreen> {
  final TextEditingController _listItemController = TextEditingController();

  final data = Get.arguments as List;

  @override
  Widget build(BuildContext context) {
    final item = data[0] as Item;
    final listId = data[1] as String;
    _listItemController.text = item.name;
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
                      'Edit name:',
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
              icon: Icons.person,
              placeholderText: 'item',
              controller: _listItemController,
              borderColor: appGreen,
              textfieldWidth: double.maxFinite,
              textfieldHeight: 60,
              borderRadius: 10,
              onSubmit: (_) {},
            ),
            const SizedBox(height: 25),
            GestureDetector(
              onTap: () {
                listController.editListItemName(
                    item.id, listId, _listItemController.text);
                Navigator.pop(context);
              },
              child: BorderButton(
                buttonColor: appGreen,
                buttonText: 'Submit',
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
