import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/data/local_data.dart';
import 'package:whats_for_dinner/main.dart';
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
        return user;
      },
    );
    return data;
  }

  premiumIAPPurchased() {
    try {
      firestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .update({'isPremium': true});
    } catch (e) {
      Get.snackbar(
        'Error Accessing Server',
        '$e',
      );
    }
  }

  Future<User> getUserDataSnapshot() async {
    User user;
    try {
      DocumentReference documentReference =
          firestore.collection('users').doc(firebaseAuth.currentUser!.uid);
      DocumentSnapshot doc = await documentReference.get();
      final data = doc;
      user = User.fromJson(data);
      return user;
    } catch (e) {
      throw ("Could not get user Data");
      //Error getting user data
    }
  }

  Future<String> getlocalColor() async {
    return await Database().getColor();
  }

  setlocalUsername(String username) {
    Database().setUsername(username);
  }

  setFirebaseUserColor(String color) {
    firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .update({"color": color});
  }
}
