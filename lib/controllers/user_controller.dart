import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/utils/constants.dart';

import '../models/user.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();

  Stream<User> getUserData() {
    Stream<User> data = firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .snapshots()
        .map(
      (snapshot) {
        User user = User.fromJson(snapshot);
        return user;
      },
    );
    return data;
  }
}
