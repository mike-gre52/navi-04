import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/models/list.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/app/custom_textfield.dart';
import 'package:whats_for_dinner/views/widgets/lists/list_column.dart';

import '../../widgets/app/app_header.dart';
import '../../widgets/lists/list_item.dart';

class ListScreen extends StatefulWidget {
  ListScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  TextEditingController _itemController = TextEditingController();

  final list = Get.arguments as ListData;

  @override
  void dispose() {
    super.dispose();
    _itemController.dispose();
  }

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('Are you sure you want to delete this list?'),
        content: const Text('All data will be lost'),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            child: const Text('Yes'),
            onPressed: () {
              Navigator.pop(context);
              listController.deleteList(list.id);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppHeader(
            headerText: list.name,
            headerColor: appGreen,
            borderColor: royalYellow,
            textColor: Colors.white,
            dividerColor: Colors.white,
            rightAction: const Text(
              'Back',
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
            margin: EdgeInsets.only(left: 15, right: 15, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextfield(
                  icon: Icons.add,
                  placeholderText: 'Add item',
                  controller: _itemController,
                  borderColor: appGreen,
                  textfieldWidth: 275,
                  textfieldHeight: 60,
                  borderRadius: 20,
                  onSubmit: (_) {
                    listController.addListItem(
                      _itemController.text,
                      list.id,
                    );
                    _itemController.clear();
                  },
                ),
                GestureDetector(
                  onTap: () {
                    listController.addListItem(
                      _itemController.text,
                      list.id,
                    );
                    _itemController.clear();
                  },
                  child: Container(
                    height: 50,
                    width: 75,
                    decoration: BoxDecoration(
                      color: appGreen,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        'Add',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          ListColumn(
            listId: list.id,
          ),
        ],
      ),
      floatingActionButton: Container(
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(200, 200, 200, 0.9),
          shape: BoxShape.circle,
        ),
        child: GestureDetector(
          onTap: () {
            _showDialog(context);
            //listController.deleteList(list.id);
            //Navigator.pop(context);
          },
          child: Icon(
            Icons.delete_outline_rounded,
            size: 40,
            color: red,
          ),
        ),
      ),
    );
  }
}
