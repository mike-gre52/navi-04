import 'package:flutter/material.dart';
import 'package:whats_for_dinner/models/recipe.dart';

class RecipeInstructionList extends StatelessWidget {
  List<Instruction> instructions;
  bool showDelete;
  Function deleteInstruction;
  RecipeInstructionList({
    Key? key,
    required this.instructions,
    required this.showDelete,
    required this.deleteInstruction,
  }) : super(key: key);

  int counter = 0;
  Widget buildRecipeInstruction(Instruction instruction) {
    counter++;
    return RecipeInstruction(
      stepNumber: counter,
      instruction: instruction.instruction,
      showDelete: showDelete,
      deleteInstruction: deleteInstruction,
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;
    double height10 = screenHeight / 89.6;
    double width20 = screenWidth / 20.7;

    counter = 0;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width20, vertical: height10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: instructions.map(buildRecipeInstruction).toList(),
      ),
    );
  }
}

class RecipeInstruction extends StatelessWidget {
  int stepNumber;
  String instruction;
  bool showDelete;
  Function deleteInstruction;
  RecipeInstruction({
    Key? key,
    required this.instruction,
    required this.stepNumber,
    required this.showDelete,
    required this.deleteInstruction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;
    double height10 = screenHeight / 89.6;
    double fontSize16 = screenHeight / 56;

    return Container(
      margin: EdgeInsets.only(top: height10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              '$stepNumber) $instruction',
              style: TextStyle(fontSize: fontSize16),
            ),
          ),
          showDelete
              ? GestureDetector(
                  onTap: () {
                    deleteInstruction(stepNumber - 1);
                  },
                  child: const Icon(
                    Icons.close,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
