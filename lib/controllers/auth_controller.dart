import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whats_for_dinner/main.dart';
import 'package:whats_for_dinner/models/group.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/helper.dart';
import 'package:whats_for_dinner/views/screens/auth/sign_in.dart';
import 'package:whats_for_dinner/views/screens/auth/sign_up.dart';
import 'package:whats_for_dinner/views/screens/navigation.dart';
import '../data/local_data.dart';
import '../models/user.dart' as model;

import '../utils/constants.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  late Rx<File?> _pickedImage;

  File? get profileImage => _pickedImage.value;
  User get user => _user.value!;

  @override
  Future<void> onReady() async {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, setInitialScreen);
  }

  Future<void> getUserData() async {
    final docRef =
        firestore.collection('users').doc(firebaseAuth.currentUser!.uid);
    await docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        globalGroupId = data['groupId'];
        globalUsername = data['name'];
        globalColor = data['color'];
        inGroup = data["inGroup"];
        isPremium = data["isPremium"];
        signUpDate = data["signUpDate"];
      },
      onError: (e) => print("Error getting document: $e"),
    );
    if (inGroup) {
      final groupRef = firestore.collection('groups').doc(globalGroupId);
      await groupRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          categories = Group.categoriesJsonToString(data);
        },
        onError: (e) => print("Error getting document: $e"),
      );
    } else {
      categories = [];
    }
  }

  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      Get.snackbar('No account found with the email: ', email);
      return false;
    }
  }

  setInitialScreen(User? user) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (user == null) {
      Get.offAll(() => SignIn(), transition: Transition.cupertino);
    } else {
      await getData();
      Get.offAll(() => const Navigation(), transition: Transition.cupertino);
    }
  }

  setlocalUsername(String username) {
    Database().setUsername(username);
  }

  setlocalColor(String color) {
    Database().setColor(color);
  }

  String pickRandomColor() {
    List<Color> colors = [
      color1,
      color2,
      color3,
      color4,
      color5,
      color6,
      color7,
      color8,
      color9,
      color10,
      color11,
      color12,
      color13,
      color14,
      color15,
      color16,
      color17,
      color18,
    ];
    Random random = new Random();
    int ran = random.nextInt(17);
    Color color = colors[ran];
    return color.value.toString();
  }

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar(
          'Profile Picture', 'You have successfully selected [] image');
    }
    pickedImageSignUp = Rx<File?>(File(pickedImage!.path));
  }

  // upload to firebase storage
  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // registering the user
  Future<void> registerUser(
    String username,
    String email,
    String password,
    //File? image,
  ) async {
    try {
      if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty //&&
          //image != null
          ) {
        //save username to local storage
        setlocalUsername(username);
        //save local color
        setlocalColor('0xffccaa40');

        // save out user to our ath and firebase firestore
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        //String downloadUrl = await _uploadToStorage(image);
        model.User user = model.User(
          name: username,
          email: email,
          uid: cred.user!.uid,
          profileImage: '',
          groupId: cred.user!.uid,
          inGroup: false,
          color: pickRandomColor(),
          isPremium: false,
          signUpDate: Timestamp.now(),
        );
        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());

        //get data
        await getData();
      } else {
        Get.snackbar(
          'Error Creating Account',
          'Please enter all the fields',
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error Creating Account',
        filterErrorMessage(e.toString()),
      );
      print(e);
    }
  }

  Future<bool> validateCredentials(String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: user.email!, password: password);
      return true;
    } catch (e) {
      if (e.toString() ==
          "[firebase_auth/wrong-password] The password is invalid or the user does not have a password.") {
        Get.snackbar(
          'Incorrect Password',
          'The password is invalid',
        );
      } else {
        Get.snackbar(
          'Incorrect Password',
          filterErrorMessage(e.toString()),
        );
      }
      return false;
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);

        await getData();
        //NEED TO SAVE DATA TO LOCAL STORAGEm----------------------------------------
      } else {
        Get.snackbar(
          'Error Logging in',
          'Please enter all the fields',
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error Logging in',
        filterErrorMessage(e.toString()),
      );
    }
  }

  void signOut() async {
    await firebaseAuth.signOut();
  }

  void updateLocalDataOnSignOut() {
    globalGroupId = user.uid;
    globalUsername = user.uid;
    inGroup = false;
    isPremium = false;
    categories = [];
  }

  Future<void> deleteUserAccount(String password) async {
    try {
      await firebaseAuth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == "requires-recent-login") {
        await _reauthenticateAndDelete(password);
      } else {
        // Handle other Firebase exceptions
      }
    } catch (e) {
      // Handle general exception
    }
  }

  Future<void> _reauthenticateAndDelete(String password) async {
    print("need to reauth with password proviuded");
    AuthCredential auth = EmailAuthProvider.credential(
      email: user.email!,
      password: password,
    );
    await firebaseAuth.currentUser!.reauthenticateWithCredential(auth);
    await firebaseAuth.currentUser!.delete();
  }
}
