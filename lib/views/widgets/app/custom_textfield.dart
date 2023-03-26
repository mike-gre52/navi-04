import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../../../utils/colors.dart';

class CustomTextfield extends StatefulWidget {
  IconData icon;
  String placeholderText;
  TextEditingController controller;
  bool showVisibilityIcon;
  Color borderColor;
  bool showIcon;
  double textfieldWidth;
  double textfieldHeight;
  double borderRadius;
  TextInputType keyboard;
  void Function(String?) onChanged;
  void Function(String) onSubmit;
  bool centerText;

  CustomTextfield({
    Key? key,
    required this.icon,
    required this.placeholderText,
    required this.controller,
    required this.borderColor,
    this.showVisibilityIcon = false,
    this.showIcon = true,
    required this.textfieldWidth,
    required this.textfieldHeight,
    required this.borderRadius,
    required this.onSubmit,
    required this.onChanged,
    this.keyboard = TextInputType.text,
    this.centerText = false,
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
    double height15 = screenHeight / 59.73;
    double height20 = screenHeight / 44.8;
    double textfieldWidth = screenWidth / (414 / widget.textfieldWidth);
    double textfieldHeight = screenHeight / (896 / widget.textfieldHeight);
    double textfieldBorderRadius = screenHeight / (896 / widget.borderRadius);

    double fontSize18 = screenHeight / 49.777;

    return SizedBox(
      height: textfieldHeight,
      width: textfieldWidth,
      child: CupertinoTextField(
        textAlign: widget.centerText ? TextAlign.center : TextAlign.start,
        onSubmitted: widget.onSubmit,
        cursorColor: black,
        cursorHeight: height20,
        placeholder: widget.placeholderText,
        placeholderStyle: TextStyle(fontSize: fontSize18, color: lightGrey),
        controller: widget.controller,
        keyboardType: widget.keyboard,
        onChanged: widget.onChanged,
        obscureText: widget.showVisibilityIcon ? hidePassword : false,
        prefix: widget.showIcon
            ? Padding(
                padding: EdgeInsets.only(left: height15, right: height5),
                child: Icon(widget.icon),
              )
            : Container(),
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
          fontFamily: "IBMPlexSansDevanagari",
          color: black,
          fontSize: fontSize18,
          height: 1.5,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.borderColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(textfieldBorderRadius),
        ),
      ),
    );
  }
}
