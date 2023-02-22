import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/models/list.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/app/custom_textfield.dart';
import 'package:whats_for_dinner/views/widgets/lists/list_bottom_popup.dart';
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

  addItem() {
    if (_itemController.text.trim() != "") {
      listController.addListItem(
        _itemController.text,
        list.id,
      );
      _itemController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (() {
          FocusScope.of(context).unfocus();
        }),
        child: Column(
          children: [
            AppHeader(
              headerText: list.name,
              headerColor: appGreen,
              borderColor: royalYellow,
              textColor: Colors.white,
              dividerColor: Colors.white,
              rightAction: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        //isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (context) => ListBottomPopup(list: list),
                      );
                    },
                    child: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Back',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
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
                    onChanged: (_) {},
                    onSubmit: (_) {
                      addItem();
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      addItem();
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
              list: list,
              isRecentlyDeleted: false,
            ),
          ],
        ),
      ),
    );
  }
}
