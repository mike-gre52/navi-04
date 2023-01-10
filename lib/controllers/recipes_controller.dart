import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:whats_for_dinner/main.dart';
import 'package:whats_for_dinner/models/recipe.dart';
import 'package:whats_for_dinner/utils/constants.dart';

import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:whats_for_dinner/utils/helper.dart';

class RecipeController extends GetxController {
  static RecipeController instance = Get.find();

  Stream<List<Recipe>> getRecipes() {
    Stream<List<Recipe>> data = firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('recipes')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map(
            (doc) {
              return Recipe.static().fromJson(
                doc.data(),
              );
            },
          ).toList(),
        );
    return data;
  }

  void uploadRecipe(Recipe recipe) {
    firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('recipes')
        .doc(recipe.id) //specific list
        .set(recipe.toJson());
  }

  void deleteRecipe(Recipe recipe) {
    firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('recipes')
        .doc(recipe.id)
        .delete();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getRecipeIngrediants(
      Recipe recipe) async {
    Future<QuerySnapshot<Map<String, dynamic>>> data = firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('recipes')
        .doc(recipe.id) //specific list
        .collection('ingredients')
        .get()
        .then(
      (data) {
        return data;
      },
      onError: (e) => print("Error completing: $e"),
    );

    return data;
  }

  void addLinkRecipe(String url) {
    String recipeName = parseUrl(url);

    Recipe recipe = Recipe(
      name: recipeName,
      prepTime: 0,
      cookTime: 0,
      servings: 0,
      id: generateId(),
      imageUrl: '',
      ingredients: [],
      instructions: [],
      sourceUrl: url,
      isLink: true,
    );

    firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('recipes')
        .doc(recipe.id) //specific list
        .set(recipe.toJson());
  }

  void updateIngredients(Recipe recipe) {
    Map<String, dynamic> json = recipe.ingredientToJson(recipe.ingredients);
    try {
      firestore
          .collection('groups')
          .doc(globalGroupId)
          .collection('recipes')
          .doc(recipe.id)
          .update({'ingredients': json});
    } catch (e) {
      Get.snackbar(
        'Error Adding Restaurant',
        '$e',
      );
    }
  }

  void updateInstructions(Recipe recipe) {
    Map<String, dynamic> json = recipe.instructionToJson(recipe.instructions);
    try {
      firestore
          .collection('groups')
          .doc(globalGroupId)
          .collection('recipes')
          .doc(recipe.id)
          .update({'instructions': json});
    } catch (e) {
      Get.snackbar(
        'Error Adding Restaurant',
        '$e',
      );
    }
    print('updated instruct');
  }
}
