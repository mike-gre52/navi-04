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
    counter = 0;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              '$stepNumber) $instruction',
              style: TextStyle(fontSize: 16),
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
