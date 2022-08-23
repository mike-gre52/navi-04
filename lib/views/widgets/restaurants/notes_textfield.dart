import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../utils/colors.dart';

class NotesTextfield extends StatefulWidget {
  TextEditingController controller;
  Color borderColor;

  NotesTextfield({
    Key? key,
    required this.controller,
    required this.borderColor,
  }) : super(key: key);

  @override
  State<NotesTextfield> createState() => _NotesTextfieldState();
}

class _NotesTextfieldState extends State<NotesTextfield> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height5 = screenHeight / 179.2;
    double height10 = screenHeight / 89.6;
    double height15 = screenHeight / 59.73;
    double height25 = screenHeight / 35.84;
    double height65 = screenHeight / 13.78;
    double width350 = screenWidth / 1.18;

    return Container(
      height: 200,
      width: width350,
      child: CupertinoTextField(
        cursorColor: black,
        cursorHeight: height25,
        controller: widget.controller,
        maxLines: null,
        expands: true,
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.done,
        style: TextStyle(
          color: black,
          height: 1.5,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.borderColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(height5),
        ),
      ),
    );
  }
}
