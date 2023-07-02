import 'dart:ffi';

import 'package:whats_for_dinner/utils/helper.dart';

class Recipe {
  String? name;
  int? prepTime;
  int? cookTime;
  int? totalTime;
  String? servings;
  String? id;
  String? imageUrl;
  List<Ingredient> ingredients;
  List<Instruction> instructions;
  String? sourceUrl;
  List<String> categories;
  bool? isLink;
  bool? isImport;
  Recipe({
    required this.name,
    required this.prepTime,
    required this.cookTime,
    required this.totalTime,
    required this.servings,
    required this.id,
    required this.imageUrl,
    required this.ingredients,
    required this.instructions,
    required this.sourceUrl,
    required this.categories,
    required this.isLink,
    required this.isImport,
  });

  Recipe.static({
    this.name = '',
    this.prepTime = 0,
    this.cookTime = 0,
    this.totalTime = 0,
    this.servings = '',
    this.id = '',
    this.imageUrl = '',
    this.ingredients = const [],
    this.instructions = const [],
    this.sourceUrl = '',
    this.categories = const [],
    this.isLink = false,
    this.isImport = false,
  });

  List<Ingredient> ingredientJsonToString(Map<String, dynamic> json) {
    List<Ingredient> newIngredients = [];
    //print(json['ingredients']);
    if (json['ingredients'] != null) {
      json['ingredients'].forEach((_, ingredient) {
        final newIngredient = Ingredient(
          name: ingredient,
          id: id!,
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
        String ingredient = i.name;
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

  categoriesJsonToString(Map<String, dynamic> json) {
    List<String> categories = [];
    if (json["categories"] != null) {
      List jsonCategories = json["categories"];
      for (dynamic categorie in jsonCategories) {
        categories.add(categorie.toString());
      }
    }
    return categories;
  }

  Recipe fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json["name"],
      prepTime: json["prepTime"],
      cookTime: json["cookTime"],
      totalTime: json["totalTime"],
      servings: json["servings"],
      id: json["id"],
      imageUrl: json["imageUrl"],
      ingredients: ingredientJsonToString(json),
      instructions: instructionJsonToString(json),
      sourceUrl: json['sourceUrl'],
      categories: categoriesJsonToString(json),
      isLink: json['isLink'],
      isImport: json['isImport'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['prepTime'] = this.prepTime;
    data['cookTime'] = this.cookTime;
    data['totalTime'] = this.totalTime;
    data['servings'] = this.servings;
    data['id'] = this.id;
    data['ingredients'] = ingredientToJson(this.ingredients);
    data['instructions'] = instructionToJson(this.instructions);
    data['imageUrl'] = this.imageUrl;
    data['sourceUrl'] = this.sourceUrl;
    data['categories'] = this.categories;
    data['isLink'] = this.isLink;
    data['isImport'] = this.isImport;

    return data;
  }
}

class Ingredient {
  String name;
  String id;

  Ingredient({
    required this.name,
    required this.id,
  });

  Ingredient.static({
    this.name = '',
    this.id = '',
  });

  Ingredient fromJson(Map<String, dynamic> json) {
    final item = Ingredient(
      name: json['name'],
      id: json['id'],
    );

    return item;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
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
