import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/models/recipe.dart';
import 'package:whats_for_dinner/routes/routes.dart';

class EditInstructionCell extends StatelessWidget {
  int counterValue;
  Instruction instruction;
  Function deleteInstruction;
  Function editInstruction;
  Function addInstruction;

  EditInstructionCell({
    Key? key,
    required this.instruction,
    required this.counterValue,
    required this.deleteInstruction,
    required this.editInstruction,
    required this.addInstruction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double height24 = screenHeight / 37.33333;
    double fontSize16 = screenHeight / 56;

    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                counterValue.toString() + ')',
                style: TextStyle(
                    fontSize: fontSize16, fontWeight: FontWeight.w500),
              ),
              Expanded(child: Container()),
              GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.editRecipeItemScreen, arguments: [
                    'Instruction',
                    instruction,
                    counterValue,
                    editInstruction,
                    addInstruction,
                    false
                  ]);
                },
                child: Icon(
                  Icons.edit,
                  size: height24,
                ),
              ),
              GestureDetector(
                onTap: () {
                  deleteInstruction(counterValue - 1);
                },
                child: Icon(
                  CupertinoIcons.delete,
                  size: height24,
                ),
              )
            ],
          ),
          Text(
            instruction.instruction,
            style: TextStyle(fontSize: fontSize16),
          ),
        ],
      ),
    );
  }
}
