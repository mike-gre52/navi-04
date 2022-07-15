import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/controllers/auth_controller.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/views/screens/home.dart';

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
  Widget build(BuildContext context) {
    List pages = [
      HomeScreen(),
      Container(child: Center(child: Text('Page 2'))),
      Container(child: Center(child: Text('Page 3'))),
      Container(child: Center(child: Text('Page 4'))),
      GestureDetector(
        onTap: (() {
          _authController.signOut();
        }),
        child: Container(
          child: Center(child: Text('Page 5')),
        ),
      ),
    ];
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
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
            color: (_selectedIndex == 1)
                ? appRed
                : (_selectedIndex == 2)
                    ? appGreen
                    : (_selectedIndex == 3)
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
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_rounded,
                size: 40,
              ),
              label: 'Home',
            ),
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
    );
  }
}
