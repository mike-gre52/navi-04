import 'dart:ui';

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

  bool isImageLoaded = false;

  imageLoaded() {
    setState(() {
      isImageLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final item = data[0] as Item;
    final listId = data[1] as String;
    if (item.name != null) {
      _listItemController.text = item.name!;
    } else {
      _listItemController.text = "";
    }

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

    onDeleteImage() {
      setState(() {
        imageJustUploaded = false;
        isImageUploaded = false;
        item.imageUrl = "";
      });
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

    if (item.imageUrl != null && item.imageUrl != "") {
      var _image = NetworkImage(item.imageUrl!);
      _image.resolve(ImageConfiguration()).addListener(
        ImageStreamListener(
          (info, call) {
            imageLoaded();
            // do something
          },
        ),
      );
    }

    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height10 = screenHeight / 89.6;
    double height15 = screenHeight / 59.733;
    double height25 = screenHeight / 35.84;
    double height30 = screenHeight / 29.86;
    double height65 = screenHeight / 13.784;
    double height350 = screenHeight / 2.56;
    double width10 = screenWidth / 41.4;
    double width30 = screenWidth / 13.8;
    double fontSize18 = screenHeight / 49.777;

    double imageBoxWidth = double.maxFinite;

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
                      'Edit name:',
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
              icon: Icons.person,
              placeholderText: 'item',
              controller: _listItemController,
              borderColor: appGreen,
              textfieldWidth: double.maxFinite,
              textfieldHeight: height65,
              borderRadius: height10,
              onSubmit: (_) {},
              onChanged: (_) {},
            ),
            SizedBox(height: height25),
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
            SizedBox(height: height25),
            isImageUploaded && item.imageUrl != null
                ? Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(height10),
                        child: Image.network(
                          item.imageUrl!,
                          height: height350,
                          width: screenWidth,
                          fit: BoxFit.cover,
                        ),
                      ),
                      isImageLoaded
                          ? Positioned(
                              bottom: 10,
                              right: 10,
                              child: GestureDetector(
                                onTap: () {
                                  _showDialog(
                                      context, item, listId, onDeleteImage);
                                },
                                child: buildBlur(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    color: Colors.white.withOpacity(0.2),
                                    child: const Icon(
                                      Icons.close_rounded,
                                      size: 32,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  )
                : imageJustUploaded
                    ? Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(height10),
                            child: Image.file(
                              imageController.image!,
                              height: height350,
                              width: double.maxFinite,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: GestureDetector(
                              onTap: () {
                                _showDialog(
                                    context, item, listId, onDeleteImage);
                              },
                              child: buildBlur(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  color: Colors.white.withOpacity(0.2),
                                  child: const Icon(
                                    Icons.close_rounded,
                                    size: 32,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
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
                          height: height350,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: lightGrey,
                            borderRadius: BorderRadius.circular(height10),
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

Widget buildBlur({
  required Widget child,
  BorderRadius? borderRadius,
  double sigmaX = 5,
  double sigmaY = 5,
}) =>
    ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5,
          sigmaY: 5,
        ),
        child: child,
      ),
    );

_showDialog(BuildContext context, Item item, String listId, Function onDelete) {
  showDialog(
    context: context,
    builder: (_) => CupertinoAlertDialog(
      title: const Text('Are you sure you want to delete the uploaded image?'),
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
            listController.updateListImageUrl(item, listId, "");
            listController.deleteListItemImage(item, listId);
            onDelete();
          },
        ),
      ],
    ),
    barrierDismissible: true,
  );
}
