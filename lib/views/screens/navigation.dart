import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:whats_for_dinner/controllers/auth_controller.dart';
import 'package:whats_for_dinner/main.dart';
import 'package:whats_for_dinner/models/user.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/ad_helper.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/screens/home.dart';
import 'package:whats_for_dinner/views/screens/lists/lists.dart';
import 'package:whats_for_dinner/views/screens/profile/group.dart';
import 'package:whats_for_dinner/views/screens/recipes/recipe.dart';
import 'package:whats_for_dinner/views/screens/recipes/recipe_folders.dart';
import 'package:whats_for_dinner/views/screens/recipes/recipe_navigator.dart';
import 'package:whats_for_dinner/views/screens/recipes/recipes.dart';
import 'package:whats_for_dinner/views/screens/restaurants/restaurants.dart';
import 'package:whats_for_dinner/views/widgets/app/banner_ad_widget.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;
  AuthController _authController = AuthController();

  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  var recipeScreen = recipePage.allRecipes;

  String category = "";

  void setRecipeScreen(var newScreen, String recipeCategory) {
    setState(() {
      recipeScreen = newScreen;
    });
    if (newScreen == recipePage.filteredRecipes) {
      category = recipeCategory;
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double height20 = screenHeight / 44.8;
    double height40 = screenHeight / 22.4;
    double fontSize12 = screenHeight / 74.667;
    double fontSize15 = screenHeight / 59.733;
    List pages = [
      //const HomeScreen(),
      const ListsScreen(),
      RecipeNavigator(
          screen: recipeScreen, setScreen: setRecipeScreen, category: category),
      //const RecipesScreen(),
      const ResturantsScreen(),
      GroupScreen(),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BannerAdWidget(),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: (_selectedIndex == 0)
                        ? appGreen
                        : (_selectedIndex == 1)
                            ? appBlue
                            : (_selectedIndex == 2)
                                ? appRed
                                : royalYellow,
                    width: 3,
                  ),
                ),
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: black,
                unselectedItemColor: Colors.grey,
                selectedLabelStyle: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'IBMPlexSansDevanagari',
                  fontWeight: FontWeight.w600,
                ),
                selectedIconTheme: IconThemeData(
                  color: (_selectedIndex == 0)
                      ? appGreen
                      : (_selectedIndex == 1)
                          ? appBlue
                          : (_selectedIndex == 2)
                              ? appRed
                              : royalYellow,
                ),
                showSelectedLabels: true,
                showUnselectedLabels: true,
                selectedFontSize: fontSize15,
                unselectedFontSize: fontSize12,
                currentIndex: _selectedIndex,
                onTap: onTapNav,
                items: [
                  //  BottomNavigationBarItem(
                  //    icon: Icon(
                  //      Icons.home_rounded,
                  //      size: 40,
                  //    ),
                  //    label: 'Home',
                  //  ),

                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.shopping_bag_outlined,
                      size: height40,
                    ),
                    label: 'Lists',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.bookmark_outline_outlined,
                      size: height40,
                    ),
                    label: 'Recipes',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.format_list_bulleted_rounded,
                      size: height40,
                    ),
                    label: 'Resturants',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.groups_rounded,
                      size: height40,
                    ),
                    label: 'Group',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
