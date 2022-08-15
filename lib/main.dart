import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/controllers/group_controller.dart';
import 'package:whats_for_dinner/controllers/restaurant_controller.dart';
import 'package:whats_for_dinner/controllers/user_controller.dart';
import 'package:whats_for_dinner/data/local_data.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/screens/auth/sign_up.dart';

import 'controllers/auth_controller.dart';
import 'views/screens/auth/sign_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    Get.put(AuthController());
    Get.put(UserController());
    Get.put(RestaurantController());
    Get.put(GroupController());
  });
  getData();
  runApp(const MyApp());
}

getData() async {
  groupController.setGroupId();
  globalGroupId = await Database().getGroupId();
}

late String globalGroupId;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'IBMPlexSansDevanagari',
      ),
      //home: const SignUp(),
      initialRoute: RouteHelper.getSignInRoute(),
      getPages: RouteHelper.routes,
    );
  }
}
