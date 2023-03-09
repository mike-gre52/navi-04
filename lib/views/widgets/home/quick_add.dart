import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/views/widgets/app/header.dart';
import 'package:whats_for_dinner/views/widgets/home/quick_add_button.dart';

class QuickAdd extends StatefulWidget {
  const QuickAdd({Key? key}) : super(key: key);

  @override
  State<QuickAdd> createState() => _QuickAddState();
}

class _QuickAddState extends State<QuickAdd> {
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;
    double height20 = screenHeight / 44.8;
    double height60 = screenHeight / 14.933;
    double height75 = screenHeight / 11.946;
    double width30 = screenWidth / 13.8;
    double width115 = screenWidth / 3.6;
    double fontSize16 = screenHeight / 56;
    double fontSize40 = screenHeight / 10.35;
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: EdgeInsets.only(left: width30),
            child: Header(
              headerText: 'Quick Add',
              dividerColor: royalYellow,
            ),
          ),
        ),
        SizedBox(
          height: height20,
        ),
        isClicked
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  QuickAddButton(
                    buttonText: 'Restaurant',
                    buttonColor: appRed,
                  ),
                  QuickAddButton(
                    buttonText: 'List',
                    buttonColor: appGreen,
                  ),
                  QuickAddButton(
                    buttonText: 'Recipe',
                    buttonColor: appBlue,
                  ),
                ],
              )
            : GestureDetector(
                onTap: () {
                  setState(() {
                    isClicked = true;
                  });
                },
                child: Container(
                  height: height75,
                  width: height75,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(width: 3, color: royalYellow),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(180, 180, 180, 1.0),
                        offset: Offset(0.0, 1.0),
                        blurRadius: 3.0,
                        spreadRadius: 1.0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      '+',
                      style: TextStyle(
                        fontSize: fontSize40,
                        color: royalYellow,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              )
      ],
    );
  }
}
