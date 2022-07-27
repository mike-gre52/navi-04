import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/views/widgets/header.dart';
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
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: const EdgeInsets.only(left: 30),
            child: Header(
              headerText: 'Quick Add',
              dividerColor: royalYellow,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
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
                  height: 75,
                  width: 75,
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
                          fontSize: 40,
                          color: royalYellow,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              )
      ],
    );
  }
}
