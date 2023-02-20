import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/controllers/image_controller.dart';
import 'package:whats_for_dinner/main.dart';
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

  late ImageController imageController;

  bool imageJustUploaded = false;

  bool isImageUploaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageController = ImageController();
  }

  @override
  void dispose() {
    super.dispose();
    _listItemController.dispose();
  }

  final data = Get.arguments as List;

  @override
  Widget build(BuildContext context) {
    final item = data[0] as Item;
    final listId = data[1] as String;
    _listItemController.text = item.name;

    if (item.imageUrl != '') {
      setState(() {
        isImageUploaded = true;
      });
    }

    Reference ref = firebaseStorage
        .ref()
        .child(globalGroupId)
        .child('listImages')
        .child('list-$listId')
        .child(item.id);

    void _showActionSheet(
      BuildContext context,
      ImageController imageController,
      Function onSubmit,
    ) {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              /// This parameter indicates the action would be a default
              /// defualt behavior, turns the action's text to bold text.
              onPressed: () {
                //Open Library
                imageController.pickImage(
                  false,
                  onSubmit,
                );

                Navigator.pop(context);
              },
              child: const Text('Choose from library'),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                //Open Camera
                imageController.pickImage(
                  true,
                  onSubmit,
                );

                Navigator.pop(context);
              },
              child: const Text('Take photo'),
            ),
            CupertinoActionSheetAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      );
    }

    void onSubmit() async {
      if (imageController.image != null) {
        setState(() {
          imageJustUploaded = true;
        });
        String imageUrl =
            await imageController.uploadToStorage(imageController.image!, ref);
        listController.updateListImageUrl(item, listId, imageUrl);
      }
    }

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
              onChanged: (_) {},
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
            const SizedBox(height: 25),
            isImageUploaded
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      item.imageUrl,
                      height: 350.0,
                      width: 350.0,
                      fit: BoxFit.cover,
                    ),
                  )
                : imageJustUploaded
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.file(
                          imageController.image!,
                          height: 350.0,
                          width: 350.0,
                          fit: BoxFit.cover,
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          _showActionSheet(
                            context,
                            imageController,
                            onSubmit,
                          );
                        },
                        child: Container(
                          height: 350,
                          width: 350,
                          decoration: BoxDecoration(
                            color: lightGrey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.photo),
                              Text('Add Image'),
                            ],
                          ),
                        ),
                      )
          ],
        ),
      ),
    ));
  }
}
