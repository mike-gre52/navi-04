import 'package:get/get.dart';
import 'package:whats_for_dinner/views/screens/lists/add_list.dart';
import 'package:whats_for_dinner/views/screens/lists/edit_list_item.dart';
import 'package:whats_for_dinner/views/screens/lists/list.dart';
import 'package:whats_for_dinner/views/screens/lists/recently_deleted.dart';
import 'package:whats_for_dinner/views/screens/profile/all_members.dart';
import 'package:whats_for_dinner/views/screens/profile/select_color_screen.dart';
import 'package:whats_for_dinner/views/screens/restaurants/add_restaurant.dart';
import 'package:whats_for_dinner/views/screens/profile/create_group.dart';
import 'package:whats_for_dinner/views/screens/profile/manage_group.dart';
import 'package:whats_for_dinner/views/screens/navigation.dart';
import 'package:whats_for_dinner/views/screens/restaurants/filter_restaurants.dart';
import 'package:whats_for_dinner/views/screens/restaurants/restaurants.dart';
import 'package:whats_for_dinner/views/screens/restaurants/view_restaurant.dart';

import '../views/screens/auth/sign_in.dart';
import '../views/screens/auth/sign_up.dart';

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
  ];
}
