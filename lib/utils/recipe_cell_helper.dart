import 'package:whats_for_dinner/models/recipe.dart';

class RecipeCellHelper {
  static double getInstructionHeight(
      List<Instruction> instructions, double screenHeight, double screenWidth) {
    int charPerLine = ((screenWidth - 40) / 7.5).floor();
    int numLines = 0;
    double lineHeight = screenHeight / 29.866;
    int numInstructions = instructions.length - 1;
    int instructionSpacer = numInstructions *
        15; // adds 10px for each instruction to account for space between instrunctions

    for (var i = 0; i < instructions.length; i++) {
      Instruction instruction = instructions[i];
      int instructionLength = instruction.instruction.length;
      numLines += (instructionLength / charPerLine).ceil();
    }

    double height = (numLines * lineHeight) + instructionSpacer;
    return height;
  }
}
