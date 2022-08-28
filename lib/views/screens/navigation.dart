import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/controllers/auth_controller.dart';
import 'package:whats_for_dinner/main.dart';
import 'package:whats_for_dinner/models/user.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/screens/home.dart';
import 'package:whats_for_dinner/views/screens/lists/lists.dart';
import 'package:whats_for_dinner/views/screens/profile/profile.dart';
import 'package:whats_for_dinner/views/screens/restaurants/restaurants.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List pages = [
      //const HomeScreen(),
      const ResturantsScreen(),
      const ListsScreen(),
      Container(
        child: GestureDetector(
          onTap: () {
            authController.signOut();
          },
          child: const Center(
            child: Text('Page 4'),
          ),
        ),
      ),
      ProfileScreen(),
    ];
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: (_selectedIndex == 0)
                    ? appRed
                    : (_selectedIndex == 1)
                        ? appGreen
                        : (_selectedIndex == 2)
                            ? appBlue
                            : royalYellow,
                width: 3,
              ),
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0),
                blurRadius: 3.0,
                spreadRadius: 1.0,
              ), //Bo
            ],
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
                  ? appRed
                  : (_selectedIndex == 1)
                      ? appGreen
                      : (_selectedIndex == 2)
                          ? appBlue
                          : royalYellow,
            ),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedFontSize: 15.0,
            unselectedFontSize: 12.0,
            currentIndex: _selectedIndex,
            onTap: onTapNav,
            items: const [
              //  BottomNavigationBarItem(
              //    icon: Icon(
              //      Icons.home_rounded,
              //      size: 40,
              //    ),
              //    label: 'Home',
              //  ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.format_list_bulleted_rounded,
                  size: 40,
                ),
                label: 'Resturants',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_bag_outlined,
                  size: 40,
                ),
                label: 'Lists',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.bookmark_outline_outlined,
                  size: 40,
                ),
                label: 'Recipes',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_outline_rounded,
                  size: 40,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
