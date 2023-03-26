import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/controllers/group_controller.dart';
import 'package:whats_for_dinner/controllers/lists_controller.dart';
import 'package:whats_for_dinner/controllers/recipes_controller.dart';
import 'package:whats_for_dinner/controllers/restaurant_controller.dart';
import 'package:whats_for_dinner/controllers/user_controller.dart';
import 'package:whats_for_dinner/data/local_data.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/screens/auth/sign_up.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'controllers/auth_controller.dart';
import 'views/screens/auth/sign_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    Get.put(AuthController());
    Get.put(UserController());
    Get.put(RestaurantController());
    Get.put(GroupController());
    Get.put(ListsController());
    Get.put(RecipeController());
  });

  MobileAds.instance.initialize();
  //await getData();
  runApp(const MyApp());
}

getData() async {
  await authController.getUserData();
}

late String globalUsername;
late String globalGroupId;
late String globalColor;
late bool inGroup;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.upToDown,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'IBMPlexSansDevanagari',
      ),
      //home: const SignUp(),
      initialRoute: RouteHelper.loadingScreen,
      getPages: RouteHelper.routes,
      builder: (context, child) {
        return MediaQuery(
          child: child!,
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        );
      },
    );
  }
}
