import 'dart:ffi';

import 'package:whats_for_dinner/utils/helper.dart';

class Recipe {
  String name;
  int prepTime;
  int cookTime;
  int servings;
  String id;
  String imageUrl;
  List<Ingredient> ingredients;
  List<Instruction> instructions;
  String sourceUrl;
  bool isLink;
  Recipe({
    required this.name,
    required this.prepTime,
    required this.cookTime,
    required this.servings,
    required this.id,
    required this.imageUrl,
    required this.ingredients,
    required this.instructions,
    required this.sourceUrl,
    required this.isLink,
  });

  Recipe.static({
    this.name = '',
    this.prepTime = 0,
    this.cookTime = 0,
    this.servings = 0,
    this.id = '',
    this.imageUrl = '',
    this.ingredients = const [],
    this.instructions = const [],
    this.sourceUrl = '',
    this.isLink = false,
  });

  List<Ingredient> ingredientJsonToString(Map<String, dynamic> json) {
    List<Ingredient> newIngredients = [];
    //print(json['ingredients']);
    if (json['ingredients'] != null) {
      json['ingredients'].forEach((_, ingredient) {
        //print(ingredient.toString());
        final ingredientString = ingredient.toString();
        final itemList = ingredientString.split(',');
        //print(itemList);
        final newIngredient = Ingredient(
          name: itemList[1],
          amount: double.parse(itemList[0]),
          id: id,
        );
        newIngredients.add(newIngredient);
      });
    }
    return newIngredients;
  }

  Map<String, dynamic> ingredientToJson(List<Ingredient> ingredients) {
    Map<String, dynamic> jsonData = {};
    int count = 0;
    ingredients.forEach(
      (i) {
        count++;
        String ingredient = '${i.amount},${i.name}';
        jsonData[count.toString()] = ingredient;
      },
    );

    return jsonData;
  }

  Map<String, dynamic> instructionToJson(List<Instruction> instructions) {
    Map<String, dynamic> jsonData = {};
    int count = 0;
    instructions.forEach(
      (i) {
        count++;
        jsonData[count.toString()] = i.instruction;
      },
    );

    return jsonData;
  }

  List<Instruction> instructionJsonToString(Map<String, dynamic> json) {
    List<Instruction> newInstructionList = [];

    if (json['instructions'] != null) {
      json['instructions'].forEach((key, instruction) {
        final instructionString = instruction.toString();

        final newInstruction = Instruction(
          instruction: instructionString,
          id: generateId(),
          orderNumber: int.parse(key),
        );
        newInstructionList.add(newInstruction);
      });
    }

    newInstructionList.sort((a, b) => a.orderNumber.compareTo(b.orderNumber));

    return newInstructionList;
  }

  Recipe fromJson(Map<String, dynamic> json) {
    List<Instruction> newInstructionList = [];
    //print(json);

    return Recipe(
        name: json["name"],
        prepTime: json["prepTime"],
        cookTime: json["cookTime"],
        servings: json["servings"],
        id: json["id"],
        imageUrl: json["imageUrl"],
        ingredients: ingredientJsonToString(json),
        instructions: instructionJsonToString(json),
        sourceUrl: json['sourceUrl'],
        isLink: json['isLink']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['prepTime'] = this.prepTime;
    data['cookTime'] = this.cookTime;
    data['servings'] = this.servings;
    data['id'] = this.id;
    data['ingredients'] = ingredientToJson(this.ingredients);
    data['instructions'] = instructionToJson(this.instructions);
    data['imageUrl'] = this.imageUrl;
    data['sourceUrl'] = this.sourceUrl;
    data['isLink'] = this.isLink;

    return data;
  }
}

class Ingredient {
  String name;
  double amount;

  String id;

  Ingredient({
    required this.name,
    required this.amount,
    required this.id,
  });

  Ingredient.static({
    this.name = '',
    this.amount = 0,
    this.id = '',
  });

  Ingredient fromJson(Map<String, dynamic> json) {
    final item = Ingredient(
      name: json['name'],
      amount: json['amount'],
      id: json['id'],
    );

    return item;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['id'] = this.id;

    return data;
  }
}

class Instruction {
  String instruction;
  String id;
  int orderNumber;

  Instruction({
    required this.instruction,
    required this.id,
    required this.orderNumber,
  });

  Instruction.static({
    this.instruction = '',
    this.id = '',
    this.orderNumber = 1,
  });
}
