import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/test.dart';
import 'package:whats_for_dinner/views/app/textfield_And_Submit_Screen.dart';
import 'package:whats_for_dinner/views/screens/lists/add_list.dart';
import 'package:whats_for_dinner/views/screens/lists/edit_list_item.dart';
import 'package:whats_for_dinner/views/screens/lists/list.dart';
import 'package:whats_for_dinner/views/screens/lists/recently_deleted.dart';
import 'package:whats_for_dinner/views/screens/lists/select_ingredients.dart';
import 'package:whats_for_dinner/views/screens/loading_screen.dart';
import 'package:whats_for_dinner/views/screens/profile/all_members.dart';
import 'package:whats_for_dinner/views/screens/profile/select_color_screen.dart';
import 'package:whats_for_dinner/views/screens/recipes/bookmark_link.dart';
import 'package:whats_for_dinner/views/screens/recipes/confirm_import_recipe.dart';
import 'package:whats_for_dinner/views/screens/recipes/create_recipe.dart';
import 'package:whats_for_dinner/views/screens/recipes/edit_recipe.dart';
import 'package:whats_for_dinner/views/screens/recipes/edit_recipe_item.dart';
import 'package:whats_for_dinner/views/screens/recipes/imported_recipe.dart';
import 'package:whats_for_dinner/views/screens/recipes/recipe.dart';
import 'package:whats_for_dinner/views/screens/recipes/select_list_from_import.dart';
import 'package:whats_for_dinner/views/screens/restaurants/add_restaurant.dart';
import 'package:whats_for_dinner/views/screens/profile/create_group.dart';
import 'package:whats_for_dinner/views/screens/profile/manage_group.dart';
import 'package:whats_for_dinner/views/screens/navigation.dart';
import 'package:whats_for_dinner/views/screens/restaurants/filter_restaurants.dart';
import 'package:whats_for_dinner/views/screens/restaurants/restaurants.dart';
import 'package:whats_for_dinner/views/screens/restaurants/view_restaurant.dart';
import 'package:whats_for_dinner/views/screens/recipes/add_recipe.dart';
import 'package:whats_for_dinner/views/widgets/recipes/select_list.dart';

import '../views/screens/auth/sign_in.dart';
import '../views/screens/auth/sign_up.dart';
import '../views/screens/lists/add_to_list_select_recipe_screen.dart';

class RouteHelper {
  static String home = '/';
  static String signIn = '/sign-in';
  static String signUp = '/sign-up';
  static String addRestaurant = '/add-restaurant';
  static String createGroup = '/create-group';
  static String manageGroup = '/manage-group';
  static String selectColor = '/select-color';
  static String singleList = '/single-list';
  static String addList = '/add-list';
  static String restaurantFilter = '/restaurant-filter';
  static String restaurants = '/restaurants';
  static String allMembers = '/all-members';
  static String viewRestaurant = '/view-restaurant';
  static String editListItem = '/editListItem';
  static String recentlyDeleted = '/recentlyDeleted';
  static String addRecipe = '/addRecipe';
  static String recipeScreen = '/recipeScreen';
  static String addToListSelectRecipeScreen = '/addToListSelectRecipeScreen';
  static String selectIngredients = '/selectIngredients';
  static String createRecipeScreen = '/createRecipeScreen';
  static String editRecipeScreen = '/editRecipeScreen';
  static String editRecipeItemScreen = '/editRecipeItemScreen';
  static String singleTextfieldAndSubmitScreen =
      '/singleTextfieldAndSubmitScreen';
  static String confirmImportRecipe = '/confirmImportRecipe';
  static String loadingScreen = '/loadingScreen';
  static String bookmarkList = '/bookmarkList';
  static String selectList = '/selectList';
  static String importedRecipe = '/importedRecipe';
  static String selectListFromImportRecipe = '/selectListFromImportRecipe';
  static String testScreen = '/testScreen';

  static String getHomeRoute() => home;
  static String getSignInRoute() => signIn;
  static String getSignUpRoute() => signUp;
  static String getAddRestaurantRoute() => addRestaurant;
  static String getCreateGroupRoute() => createGroup;
  static String getManageGroupRoute() => manageGroup;
  static String getSelectColorRoute() => selectColor;
  static String getSingleList() => singleList;
  static String getAddList() => addList;
  static String getRestaurantFilter() => restaurantFilter;
  static String getRestaurants() => restaurants;
  static String getAllMembers() => allMembers;
  static String getViewRestaurants() => viewRestaurant;
  static String getEditListItem() => editListItem;
  static String getRecentlyDeleted() => recentlyDeleted;
  static String getAddRecipe() => addRecipe;
  static String getRecipeScreen() => recipeScreen;
  static String getAddToListSelectRecipeScreen() => addToListSelectRecipeScreen;
  static String getSelectIngredients() => selectIngredients;
  static String getCreateRecipeScreen() => createRecipeScreen;
  static String getEditRecipeScreen() => editRecipeScreen;
  static String getEditRecipeItemScreen() => editRecipeItemScreen;
  static String getSingleTextfieldAndSubmitScreen() =>
      singleTextfieldAndSubmitScreen;
  static String getConfirmImportRecipe() => confirmImportRecipe;
  static String getLoadingScreen() => loadingScreen;
  static String getBookmarkList() => bookmarkList;
  static String getSelectList() => selectList;
  static String getImportedRecipe() => importedRecipe;
  static String getSelectListFromImportRecipe() => selectListFromImportRecipe;
  static String getTestScreen() => testScreen;

  static List<GetPage> routes = [
    GetPage(
      name: home,
      page: () => const Navigation(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: signIn,
      page: () => const SignIn(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: signUp,
      page: () => const SignUp(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: addRestaurant,
      page: () => AddRestaurant(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: createGroup,
      page: () => const CreateGroupScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: manageGroup,
      page: () => const ManageGroupScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: selectColor,
      page: () => const SelectColorScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: singleList,
      page: () => ListScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: addList,
      page: () => AddListScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: restaurantFilter,
      page: () => const FilterRestaurantScreens(),
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: restaurants,
      page: () => const ResturantsScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: allMembers,
      page: () => const AllMembersScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: viewRestaurant,
      page: () => const ViewRestaurant(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: editListItem,
      page: () => const EditListItemScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: recentlyDeleted,
      page: () => const RecentlyDeleted(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: addRecipe,
      page: () => const AddRecipeScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: recipeScreen,
      page: () => const RecipeScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: addToListSelectRecipeScreen,
      page: () => AddToListSelectRecipeScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: selectIngredients,
      page: () => SelectIngredients(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: createRecipeScreen,
      page: () => const CreateRecipeScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: editRecipeScreen,
      page: () => EditRecipe(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: editRecipeItemScreen,
      page: () => const EditRecipeItemScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: singleTextfieldAndSubmitScreen,
      page: () => const TextfieldAndSubmitScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: confirmImportRecipe,
      page: () => const ConfirmImportRecipe(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: loadingScreen,
      page: () => const LoadingScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: bookmarkList,
      page: () => const BookmarkLink(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: selectList,
      page: () => SelectList(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: importedRecipe,
      page: () => ImportedRecipe(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    //
    //
    //
    //
    GetPage(
      name: selectListFromImportRecipe,
      page: () => SelectListFromImportRecipe(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: testScreen,
      page: () => const Test(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),
    ),
  ];
}
