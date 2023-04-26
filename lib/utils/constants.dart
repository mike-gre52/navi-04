import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:whats_for_dinner/controllers/group_controller.dart';
import 'package:whats_for_dinner/controllers/lists_controller.dart';
import 'package:whats_for_dinner/controllers/recipes_controller.dart';
import 'package:whats_for_dinner/models/group.dart';

import '../controllers/auth_controller.dart';
import '../controllers/restaurant_controller.dart';
import '../controllers/user_controller.dart';

//FIREBASE
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

//CONTROLLER
var authController = AuthController.instance;
var userController = UserController.instance;
var restaurantController = RestaurantController.instance;
var groupController = GroupController.instance;
var listController = ListsController.instance;
var recipeController = RecipeController.instance;

//App
var appUrl = "https://apps.apple.com/us/app/what-is-for-dinner/id1639923197";
