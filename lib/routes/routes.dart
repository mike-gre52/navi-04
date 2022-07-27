import 'package:get/get.dart';
import 'package:whats_for_dinner/views/screens/add_restaurant.dart';
import 'package:whats_for_dinner/views/screens/navigation.dart';

import '../views/screens/auth/sign_in.dart';
import '../views/screens/auth/sign_up.dart';

class RouteHelper {
  static String home = '/';
  static String signIn = '/sign-in';
  static String signUp = '/sign-up';
  static String addRestaurant = '/add-restaurant';

  static String getHomeRoute() => home;
  static String getSignInRoute() => signIn;
  static String getSignUpRoute() => signUp;
  static String getAddRestaurantRoute() => addRestaurant;

  static List<GetPage> routes = [
    GetPage(
      name: home,
      page: () => Navigation(),
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
    )
  ];
}
