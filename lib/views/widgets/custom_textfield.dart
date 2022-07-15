import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../utils/colors.dart';

class CustomTextfield extends StatefulWidget {
  IconData icon;
  String placeholderText;
  TextEditingController controller;
  bool showVisibilityIcon;

  CustomTextfield({
    Key? key,
    required this.icon,
    required this.placeholderText,
    required this.controller,
    this.showVisibilityIcon = false,
  }) : super(key: key);

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
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

    return SizedBox(
      height: height65,
      width: width350,
      child: CupertinoTextField(
        cursorColor: black,
        cursorHeight: height25,
        placeholder: widget.placeholderText,
        controller: widget.controller,
        obscureText: widget.showVisibilityIcon ? hidePassword : false,
        prefix: Padding(
          padding: EdgeInsets.only(left: height15, right: height5),
          child: Icon(widget.icon),
        ),
        suffix: widget.showVisibilityIcon
            ? Padding(
                padding: EdgeInsets.only(left: height15, right: height5),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                  child: hidePassword
                      ? const Icon(
                          Icons.visibility_off,
                          color: Color.fromRGBO(122, 122, 122, 1.0),
                        )
                      : const Icon(
                          Icons.visibility,
                          color: Color.fromRGBO(122, 122, 122, 1.0),
                        ),
                ),
              )
            : null,
        style: TextStyle(
          color: black,
          height: 1.5,
        ),
        decoration: BoxDecoration(
            border: Border.all(
              color: royalYellow,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(height10)),
      ),
    );
  }
}
