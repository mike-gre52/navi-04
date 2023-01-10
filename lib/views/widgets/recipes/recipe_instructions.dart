import 'package:flutter/material.dart';
import 'package:whats_for_dinner/models/recipe.dart';

class RecipeInstructionList extends StatelessWidget {
  List<Instruction> instructions;
  RecipeInstructionList({
    Key? key,
    required this.instructions,
  }) : super(key: key);

  int counter = 0;
  Widget buildRecipeInstruction(Instruction instruction) {
    counter++;
    return RecipeInstruction(
      stepNumber: counter,
      instruction: instruction.instruction,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: instructions.map(buildRecipeInstruction).toList(),
        ),
      ),
    );
  }
}

class RecipeInstruction extends StatelessWidget {
  int stepNumber;
  String instruction;
  RecipeInstruction({
    Key? key,
    required this.instruction,
    required this.stepNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Flexible(
            child: Text(
              '$stepNumber) $instruction',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
