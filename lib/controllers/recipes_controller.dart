import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
          ).where((recipe) {
            return recipe.id != null && recipe.id != "";
          }).toList(),
        );
    return data;
  }

  Future<List<Recipe>> getRecipeQuery(String category) async {
    final recipeData = firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('recipes')
        .where(
          "categories",
          arrayContains: category,
        );

    QuerySnapshot<Object?> data = await recipeData.get();

    List<Recipe> recipes = [];

    data.docs.forEach((element) {
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;
      recipes.add(Recipe.static().fromJson(data));
    });
    recipes.forEach((element) {
      print(element.name);
    });
    return recipes;
  }

  void uploadRecipe(Recipe recipe) {
    firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('recipes')
        .doc(recipe.id) //specific list
        .set(recipe.toJson());
  }

  void deleteRecipeImageFromStorage(Recipe recipe) {
    if (recipe.isLink == true || recipe.isImport == true) {
      return;
    }
    try {
      firebaseStorage
          .ref()
          .child(globalGroupId)
          .child("recipeImages")
          .child(recipe.id!)
          .delete();
    } catch (e) {
      throw ("Error deleting recipe Image");
    }
  }

  void deleteRecipe(Recipe recipe) {
    //if (!recipe.isImport && recipe.imageUrl != "") {
    try {
      deleteRecipeImageFromStorage(recipe);
    } catch (e) {
      print("No image found at that location.");
    }
    //}
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

  void addLinkRecipe(String url, String bookmarkName) {
    String recipeName = bookmarkName;

    Recipe recipe = Recipe(
      name: recipeName,
      prepTime: 0,
      cookTime: 0,
      totalTime: 0,
      servings: '',
      id: generateId(),
      imageUrl: '',
      ingredients: [],
      instructions: [],
      sourceUrl: url,
      categories: [],
      isLink: true,
      isImport: false,
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
        'Error Updating Ingredients ',
        '$e',
      );
    }
  }

  void updateRecipePrepTime(Recipe recipe, int prepTime) {
    /*
    int newTotalTime;
    if (recipe.totalTime == null) {
      if (recipe.cookTime == null) {
        newTotalTime = prepTime;
      } else {
        newTotalTime = prepTime + recipe.cookTime!;
      }
    } else {
      //changed prepTime value
      if (recipe.prepTime != null) {
        int prepDif = prepTime - recipe.prepTime!;
        print("prepDIf   $prepDif");
        newTotalTime = prepDif + recipe.totalTime!;
      } else {
        //prepTime was empty
        newTotalTime = prepTime + recipe.totalTime!;
      }
    }
    print("updating");
    updateRecipeTotalTime(recipe, newTotalTime);

    */

    try {
      firestore
          .collection('groups')
          .doc(globalGroupId)
          .collection('recipes')
          .doc(recipe.id)
          .update({'prepTime': prepTime});
    } catch (e) {
      Get.snackbar(
        'Error editing prepTime',
        '$e',
      );
    }
  }

  void updateRecipeCookTime(Recipe recipe, int cookTime) {
    try {
      firestore
          .collection('groups')
          .doc(globalGroupId)
          .collection('recipes')
          .doc(recipe.id)
          .update({'cookTime': cookTime});
    } catch (e) {
      Get.snackbar(
        'Error editing cookTime',
        '$e',
      );
    }
  }

  void updateRecipeCategories(Recipe recipe) {
    try {
      firestore
          .collection('groups')
          .doc(globalGroupId)
          .collection('recipes')
          .doc(recipe.id)
          .update({'categories': recipe.categories});
    } catch (e) {
      Get.snackbar(
        'Error editing totalTime',
        '$e',
      );
    }
  }

  void updateRecipeTotalTime(Recipe recipe, int totalTime) {
    try {
      firestore
          .collection('groups')
          .doc(globalGroupId)
          .collection('recipes')
          .doc(recipe.id)
          .update({'totalTime': totalTime});
    } catch (e) {
      Get.snackbar(
        'Error editing totalTime',
        '$e',
      );
    }
  }

  void updateRecipeServings(Recipe recipe, String servings) {
    try {
      firestore
          .collection('groups')
          .doc(globalGroupId)
          .collection('recipes')
          .doc(recipe.id)
          .update({'servings': servings});
    } catch (e) {
      Get.snackbar(
        'Error editing servings',
        '$e',
      );
    }
  }

  void updateImageUrl(Recipe recipe, String url) {
    try {
      firestore
          .collection('groups')
          .doc(globalGroupId)
          .collection('recipes')
          .doc(recipe.id)
          .update({'imageUrl': url});
    } catch (e) {
      Get.snackbar(
        'Error uploading image',
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
  }
}
