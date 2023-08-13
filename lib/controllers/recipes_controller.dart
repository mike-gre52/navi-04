import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
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

  Stream<List<Recipe>> getRecipesInFolder(String category) {
    Stream<List<Recipe>> data = firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('recipes')
        .where(
          "categories",
          arrayContains: category,
        )
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
    } else {
      if (recipe.imageUrl != null && recipe.imageUrl != "") {
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

  deleteRecipeCategory(String category) async {
    List<Recipe> recipes = await getRecipeQuery(category);

    //removes each category tag for each recipe within the category
    for (Recipe recipe in recipes) {
      removeRecipeCategoryFromRecipe(recipe, category);
    }

    //removes category from group category tab
    deleteRecipeCategoryFromGroup(category);
  }

  void removeRecipeCategoryFromRecipe(Recipe recipe, String category) {
    try {
      firestore
          .collection('groups')
          .doc(globalGroupId)
          .collection('recipes')
          .doc(recipe.id)
          .update(
        {
          'categories': FieldValue.arrayRemove([category]),
        },
      );
    } catch (e) {
      Get.snackbar(
        'Error editing totalTime',
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

  void addRecipesToCategory(List<Recipe> recipes, String category) {
    for (Recipe recipe in recipes) {
      recipe.categories.add(category);
      updateRecipeCategories(recipe);
    }
  }

  Future<void> renameCategory(String category, String newCategory) async {
    if (category != newCategory) {
      List<Recipe> recipes = await getRecipeQuery(category);
      deleteRecipeCategory(category);
      addRecipeCategory(newCategory);
      for (Recipe recipe in recipes) {
        recipe.categories.add(newCategory);
        updateRecipeCategories(recipe);
      }
    }
  }

  Future<List<String>> getRecipeCategories() async {
    List<String> fetchedCategories = [];
    final recipeData =
        firestore.collection('groups').doc(globalGroupId).get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        List<dynamic> categoriesData = data["categories"];
        categoriesData.forEach((category) {
          fetchedCategories.add(category.toString());
        });
      },
      onError: (e) => print(e),
    );
    return fetchedCategories;
  }

  bool addRecipeCategory(String category) {
    if (!categories.contains(category)) {
      try {
        firestore.collection('groups').doc(globalGroupId).update({
          'categories': FieldValue.arrayUnion([category]),
        });
        return true;
      } catch (e) {
        Get.snackbar(
          'Error adding folder',
          '$e',
        );
        return false;
      }
    } else {
      return false;
    }
  }

  void deleteRecipeCategoryFromGroup(String category) {
    try {
      firestore.collection('groups').doc(globalGroupId).update({
        'categories': FieldValue.arrayRemove([category]),
      });
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
