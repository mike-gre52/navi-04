import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/data/local_data.dart';
import 'package:whats_for_dinner/models/group.dart';
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
        print(user.inGroup);
        return user;
      },
    );
    return data;
  }
}
